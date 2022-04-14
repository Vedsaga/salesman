// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemMap _$ItemMapFromJson(Map<String, dynamic> json) => ItemMap(
      name: json['name'] as String,
      unit: json['unit'] as String,
      id: json['id'] as int,
      rate: (json['rate'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
      totalWorth: (json['totalWorth'] as num).toDouble(),
    );

Map<String, dynamic> _$ItemMapToJson(ItemMap instance) => <String, dynamic>{
      'name': instance.name,
      'unit': instance.unit,
      'id': instance.id,
      'rate': instance.rate,
      'quantity': instance.quantity,
      'totalWorth': instance.totalWorth,
    };
