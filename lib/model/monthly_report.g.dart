// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthlyReport _$MonthlyReportFromJson(Map<String, dynamic> json) {
  return MonthlyReport(
    json['funcionario'] == null
        ? null
        : Employee.fromJson(json['funcionario'] as Map<String, dynamic>),
    MonthlyReport._referenceFromJson(json['referencia'] as String),
    MonthlyReport._daysFromJson(json['dias'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MonthlyReportToJson(MonthlyReport instance) =>
    <String, dynamic>{
      'funcionario': instance.employee,
      'referencia': instance.reference?.toIso8601String(),
      'dias': instance.days,
    };
