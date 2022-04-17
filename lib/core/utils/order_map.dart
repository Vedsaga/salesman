// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'order_map.g.dart';

@JsonSerializable()
class OrderMap {
  final int id;
  final String status;
  final String clientName;
  final double total;
  OrderMap({
    required this.id,
    required this.status,
    required this.clientName,
    required this.total,
  });

  factory OrderMap.fromJson(Map<String, dynamic> json) =>
      _$OrderMapFromJson(json);

  Map<String, dynamic> toJson() => _$OrderMapToJson(this);
}
