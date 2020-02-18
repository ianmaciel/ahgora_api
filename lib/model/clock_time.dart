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
part 'clock_time.g.dart';

enum ClockTimeType {
  regular,
  manual,
  expected,
}

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
class ClockTime {
  ClockTime(
    this.time,
    this.type,
  );

  // The API will return a JSON like the following example:
  // {
  //  "hora":"09:03",
  //  "tipo":"ORIGINAL" // "ORIGINAL", "MANUAL", "PREVISTA"
  // }

  @JsonKey(name: 'hora', fromJson: _timeFromJson)
  DateTime time;

  @JsonKey(name: 'tipo', fromJson: _typeFromJson)
  ClockTimeType type;

  static DateTime _timeFromJson(String date) => DateFormat('HH:mm').parse(date);
  static ClockTimeType _typeFromJson(String type) {
    switch (type) {
      case 'MANUAL':
        return ClockTimeType.manual;
      case 'PREVISTA':
        return ClockTimeType.expected;
      case 'ORIGINAL':
      default:
        return ClockTimeType.regular;
    }
  }

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$ClockTimeFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory ClockTime.fromJson(Map<String, dynamic> json) =>
      _$ClockTimeFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$ClockTimeToJson`.
  Map<String, dynamic> toJson() => _$ClockTimeToJson(this);
}
