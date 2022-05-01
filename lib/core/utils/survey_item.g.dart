// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyItem _$SurveyItemFromJson(Map<String, dynamic> json) => SurveyItem(
      name: json['name'] as String,
      id: json['id'] as int,
      unit: json['unit'] as String,
      previousStock: (json['previousStock'] as num).toDouble(),
      availableQuantity: (json['availableQuantity'] as num).toDouble(),
      lastSurveyedOn: DateTime.parse(json['lastSurveyedOn'] as String),
    );

Map<String, dynamic> _$SurveyItemToJson(SurveyItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'unit': instance.unit,
      'previousStock': instance.previousStock,
      'availableQuantity': instance.availableQuantity,
      'lastSurveyedOn': instance.lastSurveyedOn.toIso8601String(),
    };
