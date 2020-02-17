/*
 * Copyright (c) 2020 Ian Koerich Maciel
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:ahgora_api/model/ahgora_exceptions.dart';
import 'package:ahgora_api/model/day.dart';
import 'package:ahgora_api/model/monthly_report.dart';

class Ahgora {
  static const String _ahgoraAddress = 'https://www.ahgora.com.br';
  int userId;
  String password;
  String companyId;
  DateTime expirationDate;
  String _rawJwt;
  DateTime _expirationDate;
  String get jwt => _rawJwt;
  set jwt(String value) {
    _rawJwt = value;
    _headers['cookie'] = 'qwert-external=$_rawJwt';
  }

  String get _api => '$_ahgoraAddress/api-espelho/apuracao';
  String get _loginAddress => '$_ahgoraAddress/externo/login';
  bool get isLoggedIn => jwt != null && jwt.isNotEmpty;

  final Map<String, String> _headers = <String, String>{
    'Content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
  };

  Future<bool> login(String companyId, int userId, String password) async {
    this.userId = userId;
    this.password = password;
    this.companyId = companyId;

    http.Response response = await http.post(_loginAddress,
        body:
            'empresa=$companyId&origin=portal&matricula=$userId&senha=$password',
        headers: _headers);

    if (response.body.isNotEmpty) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['r'] == 'success') {
        jwt = body['jwt'];

        _parseJwtExpirationDate(response.headers['set-cookie']);
        return true;
      }
    }
    return false;
  }

  void _parseJwtExpirationDate(String cookie) {
    List<String> keys = cookie.split('; ');
    String expires =
        keys.firstWhere((String element) => element.startsWith('expires='));

    // Expires will have the following pattern:
    // expires=Mon, 24-Feb-2020 03:06:38 GMT
    expires = expires.substring(
      'expires='.length,
    );
    final DateFormat dateFormat = DateFormat('EEE, dd-MMM-yyyy HH:mm:ss zzz');
    expirationDate = dateFormat.parseUtc(expires);
  }

  ///
  /// Ahgora has a report page where user see the "fiscal month" instead of the
  /// month of a timestamp day - it means that when you open a report from
  /// february/2020 you will get a few timestamps from january (the last days,
  /// where the fiscal month of january ends and start february), and the
  /// timestamps will end before the end of the month.
  ///
  /// If you clocked-in on 31/jan/2020, you will probably find this timestamp
  /// on february report.
  /// If you clocked-in on 26/feb/2020, you will probably find this timestamp
  /// on march report.
  ///
  /// To avoid misleading the users, this API will try allow two ways to fetch
  /// data:
  /// 1) The default way [fiscalMonth = false] will try it by fetching the two
  ///    subsequents months (the current and the next one) and show reports in a
  ///    way that users can easily find the desired timestamp.
  /// 2) The optional way [fiscalMonth = true] will allow to calculate the hour
  ///    balance correctly using the values from fiscal month.
  ///
  Future<MonthlyReport> getMonthlyReport(DateTime dateTime,
      {bool fiscalMonth = false}) async {
    if (!isLoggedIn) {
      throw InexistentSession();
    }

    final DateFormat dateFormat = DateFormat('yyyy-MM');

    MonthlyReport monthlyReport =
        await _fetchMonthlyReport(dateFormat.format(dateTime));

    if (!fiscalMonth) {
      // When not fetchin for fiscal reasons, make a second request to the next
      // month. Remove all results that are actually on the next month and add
      // all to our existing list.
      DateTime nextMonth = DateTime(dateTime.year, dateTime.month + 1, 1);

      MonthlyReport nextMonthlyReport =
          await _fetchMonthlyReport(dateFormat.format(nextMonth));
      monthlyReport.days.addAll(nextMonthlyReport.days);

      // Remove days from other months (previous and next).
      monthlyReport.days.removeWhere((Day day) =>
          day.clockTimes.isEmpty ||
          day.clockTimes.first.time.month != dateTime.month);
    }

    // Remove days without timestamps (most likely non business days).
    monthlyReport.days.removeWhere((Day day) => day.clockTimes.isEmpty);
    return monthlyReport;
  }

  Future<MonthlyReport> _fetchMonthlyReport(String monthUrl) async {
    final http.Response response =
        await http.get('$_api/$monthUrl', headers: _headers);

    if (response.body.isNotEmpty) {
      dynamic jsonRespose = json.decode(response.body);
      if (jsonRespose['error'] != null && jsonRespose['error'] == true) {
        print(
            'MyCERTI: Error when trying to read from ahgora: ${jsonRespose["message"]}');
        if (jsonRespose["message"] == 'Acesso proibido') {
          throw InexistentSession();
        }
        return null;
      }
      MonthlyReport monthlyReport =
          MonthlyReport.fromJson(json.decode(response.body));

      return monthlyReport;
    } else {
      return null;
    }
  }
}
