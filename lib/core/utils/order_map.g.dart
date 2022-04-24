// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderMap _$OrderMapFromJson(Map<String, dynamic> json) => OrderMap(
      id: json['id'] as int,
      name: json['name'] as String,
      total: (json['total'] as num).toDouble(),
      status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status']) ??
          OrderStatus.pending,
    );

Map<String, dynamic> _$OrderMapToJson(OrderMap instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': _$OrderStatusEnumMap[instance.status],
      'total': instance.total,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.deliver: 'deliver',
  OrderStatus.reject: 'reject',
  OrderStatus.pending: 'pending',
};
