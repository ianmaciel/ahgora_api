// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clock_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClockTime _$ClockTimeFromJson(Map<String, dynamic> json) {
  return ClockTime(
    ClockTime._timeFromJson(json['hora'] as String),
    json['tipo'] as String,
  );
}

Map<String, dynamic> _$ClockTimeToJson(ClockTime instance) => <String, dynamic>{
      'hora': instance.time?.toIso8601String(),
      'tipo': instance.type,
    };
