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

/// This allows the `Employee` class to access private members in the generated
/// file.
part 'hour_summary.g.dart';

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
class HourSummary {
  HourSummary(
    this.group,
    this.description,
    this.value,
  );

  // The API will return a JSON like the following example:
  // {
  //   "grupo":"Outros",
  //   "descricao":"Horas Trabalhadas",
  //   "valor":"08:32"
  // }

  @JsonKey(name: 'grupo')
  String group;

  @JsonKey(name: 'descricao')
  String description;

  @JsonKey(name: 'valor', fromJson: _durationFromJson)
  Duration value;

  static Duration _durationFromJson(String date) {
    // Remove negative signal.
    bool negative = false;
    if (date.startsWith('-')) {
      date = date.substring(1);
      negative = true;
    }

    DateTime dateTime = DateFormat('HH:mm').parse(date);
    return Duration(
      hours: negative ? -1 * dateTime.hour : dateTime.hour,
      minutes: dateTime.minute,
    );
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$HourSummaryFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory HourSummary.fromJson(Map<String, dynamic> json) =>
      _$HourSummaryFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$HourSummaryToJson`.
  Map<String, dynamic> toJson() => _$HourSummaryToJson(this);
}
