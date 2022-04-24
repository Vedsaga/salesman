// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'order_map.g.dart';

@JsonSerializable()
class OrderMap {
  final int id;
  final String name;
  OrderStatus status;
  final double total;
  OrderMap({
    required this.id,
    required this.name,
    required this.total,
    this.status = OrderStatus.pending,
  });

  factory OrderMap.fromJson(Map<String, dynamic> json) =>
      _$OrderMapFromJson(json);

  Map<String, dynamic> toJson() => _$OrderMapToJson(this);
}

enum OrderStatus {
  deliver,
  reject,
  pending,
}
