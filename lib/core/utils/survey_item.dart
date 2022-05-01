import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_item.g.dart';

@JsonSerializable()
class SurveyItem extends Equatable {
  final String name;
  final int id;
  final String unit;
  final double previousStock;
  final double availableQuantity;
  final DateTime lastSurveyedOn ;
  const SurveyItem({
    required this.name,
    required this.id,
    required this.unit,
    required this.previousStock,
    required this.availableQuantity,
    required this.lastSurveyedOn ,
  });

  factory SurveyItem.fromJson(Map<String, dynamic> json) =>
      _$SurveyItemFromJson(json);

  Map<String, dynamic> toJson() => _$SurveyItemToJson(this);

  @override
  List<Object?> get props => [
        name,
      ];
}
