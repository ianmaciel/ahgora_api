// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return Employee(
    json['id'] as String,
    json['nome'] as String,
    json['matricula'] as String,
    json['pis'] as String,
    Employee._admissionFromJson(json['admissao'] as String),
    json['departamento'] as String,
  )..role = json['cargo'] as String;
}

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.name,
      'matricula': instance.enrollment,
      'pis': instance.pis,
      'admissao': instance.admission?.toIso8601String(),
      'cargo': instance.role,
      'departamento': instance.department,
    };
