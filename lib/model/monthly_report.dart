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

import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import 'day.dart';
import 'employee.dart';

/// This allows the `Employee` class to access private members in the generated
/// file.
part 'monthly_report.g.dart';

/// An annotation for the code generator to know that this class needs the JSON
/// serialization logic to be generated.
@JsonSerializable()

///
/// Employee model for Ahgora API
///
/// This class uses generated sources (json_serializable). Before compiling or
/// running you must generate the sources. Read more about here:
/// https://flutter.dev/docs/development/data-and-backend/json
///
///   `flutter pub run build_runner build`
///   or
///   `flutter pub run build_runner watch`
class MonthlyReport {
  MonthlyReport(this.employee, this.reference, this.days);

  // The API will return a JSON like the following example:
  // {
  //   "funcionario":{  },
  //   "solicitacoes":[  ],
  //   "aprovacao":{  },
  //   "referencia":"2020-02",
  //   "pdf":"externo\/gera_pdf\/02-2020",
  //   "extrato":null,
  //   "dias":{  },
  //   "meses":{  }
  // }

  @JsonKey(name: 'funcionario')
  Employee employee;

  @JsonKey(name: 'referencia', fromJson: _referenceFromJson)
  DateTime reference;

  @JsonKey(name: 'dias', fromJson: _daysFromJson)
  List<Day> days;

  static DateTime _referenceFromJson(String date) =>
      DateFormat('yyyy-MM').parse(date);

  static List<Day> _daysFromJson(Map<String, dynamic> mapOfDays) =>
      mapOfDays.values.map((dynamic day) => Day.fromJson(day)).toList();

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$MonthlyReportFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory MonthlyReport.fromJson(Map<String, dynamic> json) =>
      _$MonthlyReportFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$MonthlyReportToJson`.
  Map<String, dynamic> toJson() => _$MonthlyReportToJson(this);
}
