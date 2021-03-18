// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clock_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClockTime _$ClockTimeFromJson(Map<String, dynamic> json) {
  return ClockTime(
    ClockTime._timeFromJson(json['hora'] as String),
    ClockTime._typeFromJson(json['tipo'] as String),
  );
}

Map<String, dynamic> _$ClockTimeToJson(ClockTime instance) => <String, dynamic>{
      'hora': instance.time.toIso8601String(),
      'tipo': _$ClockTimeTypeEnumMap[instance.type],
    };

const _$ClockTimeTypeEnumMap = {
  ClockTimeType.regular: 'regular',
  ClockTimeType.manual: 'manual',
  ClockTimeType.expected: 'expected',
};
