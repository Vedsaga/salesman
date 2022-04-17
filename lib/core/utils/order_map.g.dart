// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderMap _$OrderMapFromJson(Map<String, dynamic> json) => OrderMap(
      id: json['id'] as int,
      status: json['status'] as String,
      clientName: json['clientName'] as String,
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderMapToJson(OrderMap instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'clientName': instance.clientName,
      'total': instance.total,
    };
