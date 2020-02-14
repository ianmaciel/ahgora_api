// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hour_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourSummary _$HourSummaryFromJson(Map<String, dynamic> json) {
  return HourSummary(
    json['grupo'] as String,
    json['descricao'] as String,
    HourSummary._durationFromJson(json['valor'] as String),
  );
}

Map<String, dynamic> _$HourSummaryToJson(HourSummary instance) =>
    <String, dynamic>{
      'grupo': instance.group,
      'descricao': instance.description,
      'valor': instance.value?.inMicroseconds,
    };
