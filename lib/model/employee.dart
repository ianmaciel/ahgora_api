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
part 'employee.g.dart';

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
class Employee {
  Employee(
    this.id,
    this.name,
    this.enrollment,
    this.pis,
    this.admission,
    this.department,
  );

  // The API will return a JSON like the following example:
  // {
  //   "id":"fEsdAWdsad4DSc323rdcCD",
  //   "nome":"Ian Koerich Maciel",
  //   "matricula":"9999",
  //   "pis":"999999999999",
  //   "admissao":"2000-12-31",
  //   "cargo":"Technical Lead",
  //   "departamento":"CDM - CERTI"
  // }

  String id;

  @JsonKey(name: 'nome')
  String name;

  @JsonKey(name: 'matricula')
  String enrollment;

  @JsonKey(name: 'pis')
  String pis;

  @JsonKey(name: 'admissao', fromJson: _admissionFromJson)
  DateTime admission;

  @JsonKey(name: 'cargo')
  String role;

  @JsonKey(name: 'departamento')
  String department;

  static DateTime _admissionFromJson(String date) =>
      DateFormat('yyyy-MM-dd').parse(date);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$EmployeeFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$EmployeeToJson`.
  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
