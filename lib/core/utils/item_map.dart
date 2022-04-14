// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_map.g.dart';

@JsonSerializable()
class ItemMap extends Equatable {
  final String name;
  final String unit;
  final int id;
  final double rate;
  final double quantity;
  final double totalWorth;
  const ItemMap({
    required this.name,
    required this.unit,
    required this.id,
    required this.rate,
    required this.quantity,
    required this.totalWorth,
  });

  factory ItemMap.fromJson(Map<String, dynamic> json) =>
      _$ItemMapFromJson(json);

  Map<String, dynamic> toJson() => _$ItemMapToJson(this);

  @override
  List<Object> get props => [
        name,
      ];
}
