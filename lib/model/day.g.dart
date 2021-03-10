// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Day _$DayFromJson(Map<String, dynamic> json) {
  return Day(
    Day._referenceFromJson(json['referencia'] as String),
    json['escala'] as String,
    json['jornada'] as String,
    (json['batidas'] as List<dynamic>)
        .map((e) => ClockTime.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['totais'] as List<dynamic>)
        .map((e) => HourSummary.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['afastamentos'] as int,
    json['estado'] as String,
  );
}

Map<String, dynamic> _$DayToJson(Day instance) => <String, dynamic>{
      'referencia': instance.reference?.toIso8601String(),
      'escala': instance.schedule,
      'jornada': instance.workday,
      'batidas': instance.clockTimes,
      'totais': instance.hourSummaries,
      'afastamentos': instance.workLeaves,
      'estado': instance.state,
    };
