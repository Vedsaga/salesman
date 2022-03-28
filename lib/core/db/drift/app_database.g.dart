// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ModelClientData extends DataClass implements Insertable<ModelClientData> {
  final int clientId;
  final String clientName;
  final String clientPhone;
  final bool isActive;
  ModelClientData(
      {required this.clientId,
      required this.clientName,
      required this.clientPhone,
      required this.isActive});
  factory ModelClientData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelClientData(
      clientId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_id'])!,
      clientName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_name'])!,
      clientPhone: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_phone'])!,
      isActive: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_active'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_id'] = Variable<int>(clientId);
    map['client_name'] = Variable<String>(clientName);
    map['client_phone'] = Variable<String>(clientPhone);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ModelClientCompanion toCompanion(bool nullToAbsent) {
    return ModelClientCompanion(
      clientId: Value(clientId),
      clientName: Value(clientName),
      clientPhone: Value(clientPhone),
      isActive: Value(isActive),
    );
  }

  factory ModelClientData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelClientData(
      clientId: serializer.fromJson<int>(json['clientId']),
      clientName: serializer.fromJson<String>(json['clientName']),
      clientPhone: serializer.fromJson<String>(json['clientPhone']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientId': serializer.toJson<int>(clientId),
      'clientName': serializer.toJson<String>(clientName),
      'clientPhone': serializer.toJson<String>(clientPhone),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  ModelClientData copyWith(
          {int? clientId,
          String? clientName,
          String? clientPhone,
          bool? isActive}) =>
      ModelClientData(
        clientId: clientId ?? this.clientId,
        clientName: clientName ?? this.clientName,
        clientPhone: clientPhone ?? this.clientPhone,
        isActive: isActive ?? this.isActive,
      );
  @override
  String toString() {
    return (StringBuffer('ModelClientData(')
          ..write('clientId: $clientId, ')
          ..write('clientName: $clientName, ')
          ..write('clientPhone: $clientPhone, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clientId, clientName, clientPhone, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelClientData &&
          other.clientId == this.clientId &&
          other.clientName == this.clientName &&
          other.clientPhone == this.clientPhone &&
          other.isActive == this.isActive);
}

class ModelClientCompanion extends UpdateCompanion<ModelClientData> {
  final Value<int> clientId;
  final Value<String> clientName;
  final Value<String> clientPhone;
  final Value<bool> isActive;
  const ModelClientCompanion({
    this.clientId = const Value.absent(),
    this.clientName = const Value.absent(),
    this.clientPhone = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  ModelClientCompanion.insert({
    this.clientId = const Value.absent(),
    required String clientName,
    required String clientPhone,
    this.isActive = const Value.absent(),
  })  : clientName = Value(clientName),
        clientPhone = Value(clientPhone);
  static Insertable<ModelClientData> custom({
    Expression<int>? clientId,
    Expression<String>? clientName,
    Expression<String>? clientPhone,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (clientId != null) 'client_id': clientId,
      if (clientName != null) 'client_name': clientName,
      if (clientPhone != null) 'client_phone': clientPhone,
      if (isActive != null) 'is_active': isActive,
    });
  }

  ModelClientCompanion copyWith(
      {Value<int>? clientId,
      Value<String>? clientName,
      Value<String>? clientPhone,
      Value<bool>? isActive}) {
    return ModelClientCompanion(
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (clientName.present) {
      map['client_name'] = Variable<String>(clientName.value);
    }
    if (clientPhone.present) {
      map['client_phone'] = Variable<String>(clientPhone.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelClientCompanion(')
          ..write('clientId: $clientId, ')
          ..write('clientName: $clientName, ')
          ..write('clientPhone: $clientPhone, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $ModelClientTable extends ModelClient
    with TableInfo<$ModelClientTable, ModelClientData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelClientTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _clientIdMeta = const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<int?> clientId = GeneratedColumn<int?>(
      'client_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _clientNameMeta = const VerificationMeta('clientName');
  @override
  late final GeneratedColumn<String?> clientName = GeneratedColumn<String?>(
      'client_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _clientPhoneMeta =
      const VerificationMeta('clientPhone');
  @override
  late final GeneratedColumn<String?> clientPhone = GeneratedColumn<String?>(
      'client_phone', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 7, maxTextLength: 15),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _isActiveMeta = const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool?> isActive = GeneratedColumn<bool?>(
      'is_active', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_active IN (0, 1))',
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [clientId, clientName, clientPhone, isActive];
  @override
  String get aliasedName => _alias ?? 'model_client';
  @override
  String get actualTableName => 'model_client';
  @override
  VerificationContext validateIntegrity(Insertable<ModelClientData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    }
    if (data.containsKey('client_name')) {
      context.handle(
          _clientNameMeta,
          clientName.isAcceptableOrUnknown(
              data['client_name']!, _clientNameMeta));
    } else if (isInserting) {
      context.missing(_clientNameMeta);
    }
    if (data.containsKey('client_phone')) {
      context.handle(
          _clientPhoneMeta,
          clientPhone.isAcceptableOrUnknown(
              data['client_phone']!, _clientPhoneMeta));
    } else if (isInserting) {
      context.missing(_clientPhoneMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientId};
  @override
  ModelClientData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ModelClientData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelClientTable createAlias(String alias) {
    return $ModelClientTable(attachedDatabase, alias);
  }
}

class ModelItemData extends DataClass implements Insertable<ModelItemData> {
  final int itemId;
  final String itemName;
  final String unit;
  final double sellingPrice;
  final double buyingPrice;
  final double availableQuantity;
  final double reservedQuantity;
  final bool isActive;
  ModelItemData(
      {required this.itemId,
      required this.itemName,
      required this.unit,
      required this.sellingPrice,
      required this.buyingPrice,
      required this.availableQuantity,
      required this.reservedQuantity,
      required this.isActive});
  factory ModelItemData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelItemData(
      itemId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_id'])!,
      itemName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_name'])!,
      unit: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unit'])!,
      sellingPrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}selling_price'])!,
      buyingPrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}buying_price'])!,
      availableQuantity: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}available_quantity'])!,
      reservedQuantity: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}reserved_quantity'])!,
      isActive: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_active'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<int>(itemId);
    map['item_name'] = Variable<String>(itemName);
    map['unit'] = Variable<String>(unit);
    map['selling_price'] = Variable<double>(sellingPrice);
    map['buying_price'] = Variable<double>(buyingPrice);
    map['available_quantity'] = Variable<double>(availableQuantity);
    map['reserved_quantity'] = Variable<double>(reservedQuantity);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ModelItemCompanion toCompanion(bool nullToAbsent) {
    return ModelItemCompanion(
      itemId: Value(itemId),
      itemName: Value(itemName),
      unit: Value(unit),
      sellingPrice: Value(sellingPrice),
      buyingPrice: Value(buyingPrice),
      availableQuantity: Value(availableQuantity),
      reservedQuantity: Value(reservedQuantity),
      isActive: Value(isActive),
    );
  }

  factory ModelItemData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelItemData(
      itemId: serializer.fromJson<int>(json['itemId']),
      itemName: serializer.fromJson<String>(json['itemName']),
      unit: serializer.fromJson<String>(json['unit']),
      sellingPrice: serializer.fromJson<double>(json['sellingPrice']),
      buyingPrice: serializer.fromJson<double>(json['buyingPrice']),
      availableQuantity: serializer.fromJson<double>(json['availableQuantity']),
      reservedQuantity: serializer.fromJson<double>(json['reservedQuantity']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<int>(itemId),
      'itemName': serializer.toJson<String>(itemName),
      'unit': serializer.toJson<String>(unit),
      'sellingPrice': serializer.toJson<double>(sellingPrice),
      'buyingPrice': serializer.toJson<double>(buyingPrice),
      'availableQuantity': serializer.toJson<double>(availableQuantity),
      'reservedQuantity': serializer.toJson<double>(reservedQuantity),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  ModelItemData copyWith(
          {int? itemId,
          String? itemName,
          String? unit,
          double? sellingPrice,
          double? buyingPrice,
          double? availableQuantity,
          double? reservedQuantity,
          bool? isActive}) =>
      ModelItemData(
        itemId: itemId ?? this.itemId,
        itemName: itemName ?? this.itemName,
        unit: unit ?? this.unit,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        buyingPrice: buyingPrice ?? this.buyingPrice,
        availableQuantity: availableQuantity ?? this.availableQuantity,
        reservedQuantity: reservedQuantity ?? this.reservedQuantity,
        isActive: isActive ?? this.isActive,
      );
  @override
  String toString() {
    return (StringBuffer('ModelItemData(')
          ..write('itemId: $itemId, ')
          ..write('itemName: $itemName, ')
          ..write('unit: $unit, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('buyingPrice: $buyingPrice, ')
          ..write('availableQuantity: $availableQuantity, ')
          ..write('reservedQuantity: $reservedQuantity, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(itemId, itemName, unit, sellingPrice,
      buyingPrice, availableQuantity, reservedQuantity, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelItemData &&
          other.itemId == this.itemId &&
          other.itemName == this.itemName &&
          other.unit == this.unit &&
          other.sellingPrice == this.sellingPrice &&
          other.buyingPrice == this.buyingPrice &&
          other.availableQuantity == this.availableQuantity &&
          other.reservedQuantity == this.reservedQuantity &&
          other.isActive == this.isActive);
}

class ModelItemCompanion extends UpdateCompanion<ModelItemData> {
  final Value<int> itemId;
  final Value<String> itemName;
  final Value<String> unit;
  final Value<double> sellingPrice;
  final Value<double> buyingPrice;
  final Value<double> availableQuantity;
  final Value<double> reservedQuantity;
  final Value<bool> isActive;
  const ModelItemCompanion({
    this.itemId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.unit = const Value.absent(),
    this.sellingPrice = const Value.absent(),
    this.buyingPrice = const Value.absent(),
    this.availableQuantity = const Value.absent(),
    this.reservedQuantity = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  ModelItemCompanion.insert({
    this.itemId = const Value.absent(),
    required String itemName,
    required String unit,
    this.sellingPrice = const Value.absent(),
    this.buyingPrice = const Value.absent(),
    this.availableQuantity = const Value.absent(),
    this.reservedQuantity = const Value.absent(),
    this.isActive = const Value.absent(),
  })  : itemName = Value(itemName),
        unit = Value(unit);
  static Insertable<ModelItemData> custom({
    Expression<int>? itemId,
    Expression<String>? itemName,
    Expression<String>? unit,
    Expression<double>? sellingPrice,
    Expression<double>? buyingPrice,
    Expression<double>? availableQuantity,
    Expression<double>? reservedQuantity,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (itemName != null) 'item_name': itemName,
      if (unit != null) 'unit': unit,
      if (sellingPrice != null) 'selling_price': sellingPrice,
      if (buyingPrice != null) 'buying_price': buyingPrice,
      if (availableQuantity != null) 'available_quantity': availableQuantity,
      if (reservedQuantity != null) 'reserved_quantity': reservedQuantity,
      if (isActive != null) 'is_active': isActive,
    });
  }

  ModelItemCompanion copyWith(
      {Value<int>? itemId,
      Value<String>? itemName,
      Value<String>? unit,
      Value<double>? sellingPrice,
      Value<double>? buyingPrice,
      Value<double>? availableQuantity,
      Value<double>? reservedQuantity,
      Value<bool>? isActive}) {
    return ModelItemCompanion(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      unit: unit ?? this.unit,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      buyingPrice: buyingPrice ?? this.buyingPrice,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      reservedQuantity: reservedQuantity ?? this.reservedQuantity,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (sellingPrice.present) {
      map['selling_price'] = Variable<double>(sellingPrice.value);
    }
    if (buyingPrice.present) {
      map['buying_price'] = Variable<double>(buyingPrice.value);
    }
    if (availableQuantity.present) {
      map['available_quantity'] = Variable<double>(availableQuantity.value);
    }
    if (reservedQuantity.present) {
      map['reserved_quantity'] = Variable<double>(reservedQuantity.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelItemCompanion(')
          ..write('itemId: $itemId, ')
          ..write('itemName: $itemName, ')
          ..write('unit: $unit, ')
          ..write('sellingPrice: $sellingPrice, ')
          ..write('buyingPrice: $buyingPrice, ')
          ..write('availableQuantity: $availableQuantity, ')
          ..write('reservedQuantity: $reservedQuantity, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $ModelItemTable extends ModelItem
    with TableInfo<$ModelItemTable, ModelItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelItemTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int?> itemId = GeneratedColumn<int?>(
      'item_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _itemNameMeta = const VerificationMeta('itemName');
  @override
  late final GeneratedColumn<String?> itemName = GeneratedColumn<String?>(
      'item_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String?> unit = GeneratedColumn<String?>(
      'unit', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _sellingPriceMeta =
      const VerificationMeta('sellingPrice');
  @override
  late final GeneratedColumn<double?> sellingPrice = GeneratedColumn<double?>(
      'selling_price', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  final VerificationMeta _buyingPriceMeta =
      const VerificationMeta('buyingPrice');
  @override
  late final GeneratedColumn<double?> buyingPrice = GeneratedColumn<double?>(
      'buying_price', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  final VerificationMeta _availableQuantityMeta =
      const VerificationMeta('availableQuantity');
  @override
  late final GeneratedColumn<double?> availableQuantity =
      GeneratedColumn<double?>('available_quantity', aliasedName, false,
          type: const RealType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  final VerificationMeta _reservedQuantityMeta =
      const VerificationMeta('reservedQuantity');
  @override
  late final GeneratedColumn<double?> reservedQuantity =
      GeneratedColumn<double?>('reserved_quantity', aliasedName, false,
          type: const RealType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  final VerificationMeta _isActiveMeta = const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool?> isActive = GeneratedColumn<bool?>(
      'is_active', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_active IN (0, 1))',
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        itemId,
        itemName,
        unit,
        sellingPrice,
        buyingPrice,
        availableQuantity,
        reservedQuantity,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? 'model_item';
  @override
  String get actualTableName => 'model_item';
  @override
  VerificationContext validateIntegrity(Insertable<ModelItemData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    }
    if (data.containsKey('item_name')) {
      context.handle(_itemNameMeta,
          itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta));
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('selling_price')) {
      context.handle(
          _sellingPriceMeta,
          sellingPrice.isAcceptableOrUnknown(
              data['selling_price']!, _sellingPriceMeta));
    }
    if (data.containsKey('buying_price')) {
      context.handle(
          _buyingPriceMeta,
          buyingPrice.isAcceptableOrUnknown(
              data['buying_price']!, _buyingPriceMeta));
    }
    if (data.containsKey('available_quantity')) {
      context.handle(
          _availableQuantityMeta,
          availableQuantity.isAcceptableOrUnknown(
              data['available_quantity']!, _availableQuantityMeta));
    }
    if (data.containsKey('reserved_quantity')) {
      context.handle(
          _reservedQuantityMeta,
          reservedQuantity.isAcceptableOrUnknown(
              data['reserved_quantity']!, _reservedQuantityMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId};
  @override
  ModelItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ModelItemData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelItemTable createAlias(String alias) {
    return $ModelItemTable(attachedDatabase, alias);
  }
}

class ModelOrderData extends DataClass implements Insertable<ModelOrderData> {
  final int orderId;
  final int clientId;
  final int itemId;
  final double quantity;
  final double totalPrice;
  final String orderNote;
  final String orderType;
  final String createdBy;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final DateTime expectedDeliveryDate;
  final bool isValid;
  ModelOrderData(
      {required this.orderId,
      required this.clientId,
      required this.itemId,
      required this.quantity,
      required this.totalPrice,
      required this.orderNote,
      required this.orderType,
      required this.createdBy,
      required this.createdAt,
      required this.lastUpdated,
      required this.expectedDeliveryDate,
      required this.isValid});
  factory ModelOrderData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelOrderData(
      orderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
      clientId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_id'])!,
      itemId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_id'])!,
      quantity: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity'])!,
      totalPrice: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_price'])!,
      orderNote: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_note'])!,
      orderType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_type'])!,
      createdBy: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      lastUpdated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated'])!,
      expectedDeliveryDate: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}expected_delivery_date'])!,
      isValid: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_valid'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['order_id'] = Variable<int>(orderId);
    map['client_id'] = Variable<int>(clientId);
    map['item_id'] = Variable<int>(itemId);
    map['quantity'] = Variable<double>(quantity);
    map['total_price'] = Variable<double>(totalPrice);
    map['order_note'] = Variable<String>(orderNote);
    map['order_type'] = Variable<String>(orderType);
    map['created_by'] = Variable<String>(createdBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['expected_delivery_date'] = Variable<DateTime>(expectedDeliveryDate);
    map['is_valid'] = Variable<bool>(isValid);
    return map;
  }

  ModelOrderCompanion toCompanion(bool nullToAbsent) {
    return ModelOrderCompanion(
      orderId: Value(orderId),
      clientId: Value(clientId),
      itemId: Value(itemId),
      quantity: Value(quantity),
      totalPrice: Value(totalPrice),
      orderNote: Value(orderNote),
      orderType: Value(orderType),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
      lastUpdated: Value(lastUpdated),
      expectedDeliveryDate: Value(expectedDeliveryDate),
      isValid: Value(isValid),
    );
  }

  factory ModelOrderData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelOrderData(
      orderId: serializer.fromJson<int>(json['orderId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      itemId: serializer.fromJson<int>(json['itemId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      orderNote: serializer.fromJson<String>(json['orderNote']),
      orderType: serializer.fromJson<String>(json['orderType']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      expectedDeliveryDate:
          serializer.fromJson<DateTime>(json['expectedDeliveryDate']),
      isValid: serializer.fromJson<bool>(json['isValid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'orderId': serializer.toJson<int>(orderId),
      'clientId': serializer.toJson<int>(clientId),
      'itemId': serializer.toJson<int>(itemId),
      'quantity': serializer.toJson<double>(quantity),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'orderNote': serializer.toJson<String>(orderNote),
      'orderType': serializer.toJson<String>(orderType),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'expectedDeliveryDate': serializer.toJson<DateTime>(expectedDeliveryDate),
      'isValid': serializer.toJson<bool>(isValid),
    };
  }

  ModelOrderData copyWith(
          {int? orderId,
          int? clientId,
          int? itemId,
          double? quantity,
          double? totalPrice,
          String? orderNote,
          String? orderType,
          String? createdBy,
          DateTime? createdAt,
          DateTime? lastUpdated,
          DateTime? expectedDeliveryDate,
          bool? isValid}) =>
      ModelOrderData(
        orderId: orderId ?? this.orderId,
        clientId: clientId ?? this.clientId,
        itemId: itemId ?? this.itemId,
        quantity: quantity ?? this.quantity,
        totalPrice: totalPrice ?? this.totalPrice,
        orderNote: orderNote ?? this.orderNote,
        orderType: orderType ?? this.orderType,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
        isValid: isValid ?? this.isValid,
      );
  @override
  String toString() {
    return (StringBuffer('ModelOrderData(')
          ..write('orderId: $orderId, ')
          ..write('clientId: $clientId, ')
          ..write('itemId: $itemId, ')
          ..write('quantity: $quantity, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('orderNote: $orderNote, ')
          ..write('orderType: $orderType, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('expectedDeliveryDate: $expectedDeliveryDate, ')
          ..write('isValid: $isValid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      orderId,
      clientId,
      itemId,
      quantity,
      totalPrice,
      orderNote,
      orderType,
      createdBy,
      createdAt,
      lastUpdated,
      expectedDeliveryDate,
      isValid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelOrderData &&
          other.orderId == this.orderId &&
          other.clientId == this.clientId &&
          other.itemId == this.itemId &&
          other.quantity == this.quantity &&
          other.totalPrice == this.totalPrice &&
          other.orderNote == this.orderNote &&
          other.orderType == this.orderType &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.lastUpdated == this.lastUpdated &&
          other.expectedDeliveryDate == this.expectedDeliveryDate &&
          other.isValid == this.isValid);
}

class ModelOrderCompanion extends UpdateCompanion<ModelOrderData> {
  final Value<int> orderId;
  final Value<int> clientId;
  final Value<int> itemId;
  final Value<double> quantity;
  final Value<double> totalPrice;
  final Value<String> orderNote;
  final Value<String> orderType;
  final Value<String> createdBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastUpdated;
  final Value<DateTime> expectedDeliveryDate;
  final Value<bool> isValid;
  const ModelOrderCompanion({
    this.orderId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.orderNote = const Value.absent(),
    this.orderType = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.expectedDeliveryDate = const Value.absent(),
    this.isValid = const Value.absent(),
  });
  ModelOrderCompanion.insert({
    this.orderId = const Value.absent(),
    required int clientId,
    required int itemId,
    required double quantity,
    required double totalPrice,
    required String orderNote,
    required String orderType,
    required String createdBy,
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.expectedDeliveryDate = const Value.absent(),
    this.isValid = const Value.absent(),
  })  : clientId = Value(clientId),
        itemId = Value(itemId),
        quantity = Value(quantity),
        totalPrice = Value(totalPrice),
        orderNote = Value(orderNote),
        orderType = Value(orderType),
        createdBy = Value(createdBy);
  static Insertable<ModelOrderData> custom({
    Expression<int>? orderId,
    Expression<int>? clientId,
    Expression<int>? itemId,
    Expression<double>? quantity,
    Expression<double>? totalPrice,
    Expression<String>? orderNote,
    Expression<String>? orderType,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdated,
    Expression<DateTime>? expectedDeliveryDate,
    Expression<bool>? isValid,
  }) {
    return RawValuesInsertable({
      if (orderId != null) 'order_id': orderId,
      if (clientId != null) 'client_id': clientId,
      if (itemId != null) 'item_id': itemId,
      if (quantity != null) 'quantity': quantity,
      if (totalPrice != null) 'total_price': totalPrice,
      if (orderNote != null) 'order_note': orderNote,
      if (orderType != null) 'order_type': orderType,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (expectedDeliveryDate != null)
        'expected_delivery_date': expectedDeliveryDate,
      if (isValid != null) 'is_valid': isValid,
    });
  }

  ModelOrderCompanion copyWith(
      {Value<int>? orderId,
      Value<int>? clientId,
      Value<int>? itemId,
      Value<double>? quantity,
      Value<double>? totalPrice,
      Value<String>? orderNote,
      Value<String>? orderType,
      Value<String>? createdBy,
      Value<DateTime>? createdAt,
      Value<DateTime>? lastUpdated,
      Value<DateTime>? expectedDeliveryDate,
      Value<bool>? isValid}) {
    return ModelOrderCompanion(
      orderId: orderId ?? this.orderId,
      clientId: clientId ?? this.clientId,
      itemId: itemId ?? this.itemId,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      orderNote: orderNote ?? this.orderNote,
      orderType: orderType ?? this.orderType,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (orderNote.present) {
      map['order_note'] = Variable<String>(orderNote.value);
    }
    if (orderType.present) {
      map['order_type'] = Variable<String>(orderType.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (expectedDeliveryDate.present) {
      map['expected_delivery_date'] =
          Variable<DateTime>(expectedDeliveryDate.value);
    }
    if (isValid.present) {
      map['is_valid'] = Variable<bool>(isValid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelOrderCompanion(')
          ..write('orderId: $orderId, ')
          ..write('clientId: $clientId, ')
          ..write('itemId: $itemId, ')
          ..write('quantity: $quantity, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('orderNote: $orderNote, ')
          ..write('orderType: $orderType, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('expectedDeliveryDate: $expectedDeliveryDate, ')
          ..write('isValid: $isValid')
          ..write(')'))
        .toString();
  }
}

class $ModelOrderTable extends ModelOrder
    with TableInfo<$ModelOrderTable, ModelOrderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelOrderTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int?> orderId = GeneratedColumn<int?>(
      'order_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _clientIdMeta = const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<int?> clientId = GeneratedColumn<int?>(
      'client_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES model_client (client_id)');
  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int?> itemId = GeneratedColumn<int?>(
      'item_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES model_item (item_id)');
  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double?> quantity = GeneratedColumn<double?>(
      'quantity', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _totalPriceMeta = const VerificationMeta('totalPrice');
  @override
  late final GeneratedColumn<double?> totalPrice = GeneratedColumn<double?>(
      'total_price', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _orderNoteMeta = const VerificationMeta('orderNote');
  @override
  late final GeneratedColumn<String?> orderNote = GeneratedColumn<String?>(
      'order_note', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _orderTypeMeta = const VerificationMeta('orderType');
  @override
  late final GeneratedColumn<String?> orderType = GeneratedColumn<String?>(
      'order_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String?> createdBy = GeneratedColumn<String?>(
      'created_by', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  final VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime?> lastUpdated =
      GeneratedColumn<DateTime?>('last_updated', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime.now()));
  final VerificationMeta _expectedDeliveryDateMeta =
      const VerificationMeta('expectedDeliveryDate');
  @override
  late final GeneratedColumn<DateTime?> expectedDeliveryDate =
      GeneratedColumn<DateTime?>('expected_delivery_date', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime.now()));
  final VerificationMeta _isValidMeta = const VerificationMeta('isValid');
  @override
  late final GeneratedColumn<bool?> isValid = GeneratedColumn<bool?>(
      'is_valid', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_valid IN (0, 1))',
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        orderId,
        clientId,
        itemId,
        quantity,
        totalPrice,
        orderNote,
        orderType,
        createdBy,
        createdAt,
        lastUpdated,
        expectedDeliveryDate,
        isValid
      ];
  @override
  String get aliasedName => _alias ?? 'model_order';
  @override
  String get actualTableName => 'model_order';
  @override
  VerificationContext validateIntegrity(Insertable<ModelOrderData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
          _totalPriceMeta,
          totalPrice.isAcceptableOrUnknown(
              data['total_price']!, _totalPriceMeta));
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('order_note')) {
      context.handle(_orderNoteMeta,
          orderNote.isAcceptableOrUnknown(data['order_note']!, _orderNoteMeta));
    } else if (isInserting) {
      context.missing(_orderNoteMeta);
    }
    if (data.containsKey('order_type')) {
      context.handle(_orderTypeMeta,
          orderType.isAcceptableOrUnknown(data['order_type']!, _orderTypeMeta));
    } else if (isInserting) {
      context.missing(_orderTypeMeta);
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    if (data.containsKey('expected_delivery_date')) {
      context.handle(
          _expectedDeliveryDateMeta,
          expectedDeliveryDate.isAcceptableOrUnknown(
              data['expected_delivery_date']!, _expectedDeliveryDateMeta));
    }
    if (data.containsKey('is_valid')) {
      context.handle(_isValidMeta,
          isValid.isAcceptableOrUnknown(data['is_valid']!, _isValidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {orderId};
  @override
  ModelOrderData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ModelOrderData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelOrderTable createAlias(String alias) {
    return $ModelOrderTable(attachedDatabase, alias);
  }
}

class ModelDeliveryData extends DataClass
    implements Insertable<ModelDeliveryData> {
  final int deliveryId;
  final int orderId;
  final String deliveryStatus;
  final String deliveredBy;
  final String paymentStatus;
  final double dueAmount;
  final DateTime startedAt;
  final DateTime lastUpdated;
  final bool isValid;
  ModelDeliveryData(
      {required this.deliveryId,
      required this.orderId,
      required this.deliveryStatus,
      required this.deliveredBy,
      required this.paymentStatus,
      required this.dueAmount,
      required this.startedAt,
      required this.lastUpdated,
      required this.isValid});
  factory ModelDeliveryData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelDeliveryData(
      deliveryId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}delivery_id'])!,
      orderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
      deliveryStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}delivery_status'])!,
      deliveredBy: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}delivered_by'])!,
      paymentStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_status'])!,
      dueAmount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}due_amount'])!,
      startedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}started_at'])!,
      lastUpdated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated'])!,
      isValid: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_valid'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['delivery_id'] = Variable<int>(deliveryId);
    map['order_id'] = Variable<int>(orderId);
    map['delivery_status'] = Variable<String>(deliveryStatus);
    map['delivered_by'] = Variable<String>(deliveredBy);
    map['payment_status'] = Variable<String>(paymentStatus);
    map['due_amount'] = Variable<double>(dueAmount);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['is_valid'] = Variable<bool>(isValid);
    return map;
  }

  ModelDeliveryCompanion toCompanion(bool nullToAbsent) {
    return ModelDeliveryCompanion(
      deliveryId: Value(deliveryId),
      orderId: Value(orderId),
      deliveryStatus: Value(deliveryStatus),
      deliveredBy: Value(deliveredBy),
      paymentStatus: Value(paymentStatus),
      dueAmount: Value(dueAmount),
      startedAt: Value(startedAt),
      lastUpdated: Value(lastUpdated),
      isValid: Value(isValid),
    );
  }

  factory ModelDeliveryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelDeliveryData(
      deliveryId: serializer.fromJson<int>(json['deliveryId']),
      orderId: serializer.fromJson<int>(json['orderId']),
      deliveryStatus: serializer.fromJson<String>(json['deliveryStatus']),
      deliveredBy: serializer.fromJson<String>(json['deliveredBy']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      dueAmount: serializer.fromJson<double>(json['dueAmount']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      isValid: serializer.fromJson<bool>(json['isValid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'deliveryId': serializer.toJson<int>(deliveryId),
      'orderId': serializer.toJson<int>(orderId),
      'deliveryStatus': serializer.toJson<String>(deliveryStatus),
      'deliveredBy': serializer.toJson<String>(deliveredBy),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'dueAmount': serializer.toJson<double>(dueAmount),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'isValid': serializer.toJson<bool>(isValid),
    };
  }

  ModelDeliveryData copyWith(
          {int? deliveryId,
          int? orderId,
          String? deliveryStatus,
          String? deliveredBy,
          String? paymentStatus,
          double? dueAmount,
          DateTime? startedAt,
          DateTime? lastUpdated,
          bool? isValid}) =>
      ModelDeliveryData(
        deliveryId: deliveryId ?? this.deliveryId,
        orderId: orderId ?? this.orderId,
        deliveryStatus: deliveryStatus ?? this.deliveryStatus,
        deliveredBy: deliveredBy ?? this.deliveredBy,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        dueAmount: dueAmount ?? this.dueAmount,
        startedAt: startedAt ?? this.startedAt,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        isValid: isValid ?? this.isValid,
      );
  @override
  String toString() {
    return (StringBuffer('ModelDeliveryData(')
          ..write('deliveryId: $deliveryId, ')
          ..write('orderId: $orderId, ')
          ..write('deliveryStatus: $deliveryStatus, ')
          ..write('deliveredBy: $deliveredBy, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('dueAmount: $dueAmount, ')
          ..write('startedAt: $startedAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isValid: $isValid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(deliveryId, orderId, deliveryStatus,
      deliveredBy, paymentStatus, dueAmount, startedAt, lastUpdated, isValid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelDeliveryData &&
          other.deliveryId == this.deliveryId &&
          other.orderId == this.orderId &&
          other.deliveryStatus == this.deliveryStatus &&
          other.deliveredBy == this.deliveredBy &&
          other.paymentStatus == this.paymentStatus &&
          other.dueAmount == this.dueAmount &&
          other.startedAt == this.startedAt &&
          other.lastUpdated == this.lastUpdated &&
          other.isValid == this.isValid);
}

class ModelDeliveryCompanion extends UpdateCompanion<ModelDeliveryData> {
  final Value<int> deliveryId;
  final Value<int> orderId;
  final Value<String> deliveryStatus;
  final Value<String> deliveredBy;
  final Value<String> paymentStatus;
  final Value<double> dueAmount;
  final Value<DateTime> startedAt;
  final Value<DateTime> lastUpdated;
  final Value<bool> isValid;
  const ModelDeliveryCompanion({
    this.deliveryId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.deliveryStatus = const Value.absent(),
    this.deliveredBy = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.dueAmount = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isValid = const Value.absent(),
  });
  ModelDeliveryCompanion.insert({
    this.deliveryId = const Value.absent(),
    required int orderId,
    required String deliveryStatus,
    required String deliveredBy,
    required String paymentStatus,
    required double dueAmount,
    this.startedAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isValid = const Value.absent(),
  })  : orderId = Value(orderId),
        deliveryStatus = Value(deliveryStatus),
        deliveredBy = Value(deliveredBy),
        paymentStatus = Value(paymentStatus),
        dueAmount = Value(dueAmount);
  static Insertable<ModelDeliveryData> custom({
    Expression<int>? deliveryId,
    Expression<int>? orderId,
    Expression<String>? deliveryStatus,
    Expression<String>? deliveredBy,
    Expression<String>? paymentStatus,
    Expression<double>? dueAmount,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? lastUpdated,
    Expression<bool>? isValid,
  }) {
    return RawValuesInsertable({
      if (deliveryId != null) 'delivery_id': deliveryId,
      if (orderId != null) 'order_id': orderId,
      if (deliveryStatus != null) 'delivery_status': deliveryStatus,
      if (deliveredBy != null) 'delivered_by': deliveredBy,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (dueAmount != null) 'due_amount': dueAmount,
      if (startedAt != null) 'started_at': startedAt,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (isValid != null) 'is_valid': isValid,
    });
  }

  ModelDeliveryCompanion copyWith(
      {Value<int>? deliveryId,
      Value<int>? orderId,
      Value<String>? deliveryStatus,
      Value<String>? deliveredBy,
      Value<String>? paymentStatus,
      Value<double>? dueAmount,
      Value<DateTime>? startedAt,
      Value<DateTime>? lastUpdated,
      Value<bool>? isValid}) {
    return ModelDeliveryCompanion(
      deliveryId: deliveryId ?? this.deliveryId,
      orderId: orderId ?? this.orderId,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      deliveredBy: deliveredBy ?? this.deliveredBy,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      dueAmount: dueAmount ?? this.dueAmount,
      startedAt: startedAt ?? this.startedAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (deliveryId.present) {
      map['delivery_id'] = Variable<int>(deliveryId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (deliveryStatus.present) {
      map['delivery_status'] = Variable<String>(deliveryStatus.value);
    }
    if (deliveredBy.present) {
      map['delivered_by'] = Variable<String>(deliveredBy.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(paymentStatus.value);
    }
    if (dueAmount.present) {
      map['due_amount'] = Variable<double>(dueAmount.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (isValid.present) {
      map['is_valid'] = Variable<bool>(isValid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelDeliveryCompanion(')
          ..write('deliveryId: $deliveryId, ')
          ..write('orderId: $orderId, ')
          ..write('deliveryStatus: $deliveryStatus, ')
          ..write('deliveredBy: $deliveredBy, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('dueAmount: $dueAmount, ')
          ..write('startedAt: $startedAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isValid: $isValid')
          ..write(')'))
        .toString();
  }
}

class $ModelDeliveryTable extends ModelDelivery
    with TableInfo<$ModelDeliveryTable, ModelDeliveryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelDeliveryTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _deliveryIdMeta = const VerificationMeta('deliveryId');
  @override
  late final GeneratedColumn<int?> deliveryId = GeneratedColumn<int?>(
      'delivery_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int?> orderId = GeneratedColumn<int?>(
      'order_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES model_order (order_id)');
  final VerificationMeta _deliveryStatusMeta =
      const VerificationMeta('deliveryStatus');
  @override
  late final GeneratedColumn<String?> deliveryStatus = GeneratedColumn<String?>(
      'delivery_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _deliveredByMeta =
      const VerificationMeta('deliveredBy');
  @override
  late final GeneratedColumn<String?> deliveredBy = GeneratedColumn<String?>(
      'delivered_by', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _paymentStatusMeta =
      const VerificationMeta('paymentStatus');
  @override
  late final GeneratedColumn<String?> paymentStatus = GeneratedColumn<String?>(
      'payment_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _dueAmountMeta = const VerificationMeta('dueAmount');
  @override
  late final GeneratedColumn<double?> dueAmount = GeneratedColumn<double?>(
      'due_amount', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _startedAtMeta = const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime?> startedAt = GeneratedColumn<DateTime?>(
      'started_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  final VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime?> lastUpdated =
      GeneratedColumn<DateTime?>('last_updated', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime.now()));
  final VerificationMeta _isValidMeta = const VerificationMeta('isValid');
  @override
  late final GeneratedColumn<bool?> isValid = GeneratedColumn<bool?>(
      'is_valid', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_valid IN (0, 1))',
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        deliveryId,
        orderId,
        deliveryStatus,
        deliveredBy,
        paymentStatus,
        dueAmount,
        startedAt,
        lastUpdated,
        isValid
      ];
  @override
  String get aliasedName => _alias ?? 'model_delivery';
  @override
  String get actualTableName => 'model_delivery';
  @override
  VerificationContext validateIntegrity(Insertable<ModelDeliveryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('delivery_id')) {
      context.handle(
          _deliveryIdMeta,
          deliveryId.isAcceptableOrUnknown(
              data['delivery_id']!, _deliveryIdMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('delivery_status')) {
      context.handle(
          _deliveryStatusMeta,
          deliveryStatus.isAcceptableOrUnknown(
              data['delivery_status']!, _deliveryStatusMeta));
    } else if (isInserting) {
      context.missing(_deliveryStatusMeta);
    }
    if (data.containsKey('delivered_by')) {
      context.handle(
          _deliveredByMeta,
          deliveredBy.isAcceptableOrUnknown(
              data['delivered_by']!, _deliveredByMeta));
    } else if (isInserting) {
      context.missing(_deliveredByMeta);
    }
    if (data.containsKey('payment_status')) {
      context.handle(
          _paymentStatusMeta,
          paymentStatus.isAcceptableOrUnknown(
              data['payment_status']!, _paymentStatusMeta));
    } else if (isInserting) {
      context.missing(_paymentStatusMeta);
    }
    if (data.containsKey('due_amount')) {
      context.handle(_dueAmountMeta,
          dueAmount.isAcceptableOrUnknown(data['due_amount']!, _dueAmountMeta));
    } else if (isInserting) {
      context.missing(_dueAmountMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    if (data.containsKey('is_valid')) {
      context.handle(_isValidMeta,
          isValid.isAcceptableOrUnknown(data['is_valid']!, _isValidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deliveryId};
  @override
  ModelDeliveryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ModelDeliveryData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelDeliveryTable createAlias(String alias) {
    return $ModelDeliveryTable(attachedDatabase, alias);
  }
}

class ModelReturnData extends DataClass implements Insertable<ModelReturnData> {
  final int returnId;
  final int orderId;
  final String returnStatus;
  final String paymentStatus;
  final double dueAmount;
  final String returnedBy;
  final DateTime startedAt;
  final DateTime lastUpdated;
  final bool isValid;
  ModelReturnData(
      {required this.returnId,
      required this.orderId,
      required this.returnStatus,
      required this.paymentStatus,
      required this.dueAmount,
      required this.returnedBy,
      required this.startedAt,
      required this.lastUpdated,
      required this.isValid});
  factory ModelReturnData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelReturnData(
      returnId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}return_id'])!,
      orderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
      returnStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}return_status'])!,
      paymentStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_status'])!,
      dueAmount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}due_amount'])!,
      returnedBy: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}returned_by'])!,
      startedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}started_at'])!,
      lastUpdated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated'])!,
      isValid: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_valid'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['return_id'] = Variable<int>(returnId);
    map['order_id'] = Variable<int>(orderId);
    map['return_status'] = Variable<String>(returnStatus);
    map['payment_status'] = Variable<String>(paymentStatus);
    map['due_amount'] = Variable<double>(dueAmount);
    map['returned_by'] = Variable<String>(returnedBy);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['is_valid'] = Variable<bool>(isValid);
    return map;
  }

  ModelReturnCompanion toCompanion(bool nullToAbsent) {
    return ModelReturnCompanion(
      returnId: Value(returnId),
      orderId: Value(orderId),
      returnStatus: Value(returnStatus),
      paymentStatus: Value(paymentStatus),
      dueAmount: Value(dueAmount),
      returnedBy: Value(returnedBy),
      startedAt: Value(startedAt),
      lastUpdated: Value(lastUpdated),
      isValid: Value(isValid),
    );
  }

  factory ModelReturnData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelReturnData(
      returnId: serializer.fromJson<int>(json['returnId']),
      orderId: serializer.fromJson<int>(json['orderId']),
      returnStatus: serializer.fromJson<String>(json['returnStatus']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      dueAmount: serializer.fromJson<double>(json['dueAmount']),
      returnedBy: serializer.fromJson<String>(json['returnedBy']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      isValid: serializer.fromJson<bool>(json['isValid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'returnId': serializer.toJson<int>(returnId),
      'orderId': serializer.toJson<int>(orderId),
      'returnStatus': serializer.toJson<String>(returnStatus),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'dueAmount': serializer.toJson<double>(dueAmount),
      'returnedBy': serializer.toJson<String>(returnedBy),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'isValid': serializer.toJson<bool>(isValid),
    };
  }

  ModelReturnData copyWith(
          {int? returnId,
          int? orderId,
          String? returnStatus,
          String? paymentStatus,
          double? dueAmount,
          String? returnedBy,
          DateTime? startedAt,
          DateTime? lastUpdated,
          bool? isValid}) =>
      ModelReturnData(
        returnId: returnId ?? this.returnId,
        orderId: orderId ?? this.orderId,
        returnStatus: returnStatus ?? this.returnStatus,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        dueAmount: dueAmount ?? this.dueAmount,
        returnedBy: returnedBy ?? this.returnedBy,
        startedAt: startedAt ?? this.startedAt,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        isValid: isValid ?? this.isValid,
      );
  @override
  String toString() {
    return (StringBuffer('ModelReturnData(')
          ..write('returnId: $returnId, ')
          ..write('orderId: $orderId, ')
          ..write('returnStatus: $returnStatus, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('dueAmount: $dueAmount, ')
          ..write('returnedBy: $returnedBy, ')
          ..write('startedAt: $startedAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isValid: $isValid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(returnId, orderId, returnStatus,
      paymentStatus, dueAmount, returnedBy, startedAt, lastUpdated, isValid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelReturnData &&
          other.returnId == this.returnId &&
          other.orderId == this.orderId &&
          other.returnStatus == this.returnStatus &&
          other.paymentStatus == this.paymentStatus &&
          other.dueAmount == this.dueAmount &&
          other.returnedBy == this.returnedBy &&
          other.startedAt == this.startedAt &&
          other.lastUpdated == this.lastUpdated &&
          other.isValid == this.isValid);
}

class ModelReturnCompanion extends UpdateCompanion<ModelReturnData> {
  final Value<int> returnId;
  final Value<int> orderId;
  final Value<String> returnStatus;
  final Value<String> paymentStatus;
  final Value<double> dueAmount;
  final Value<String> returnedBy;
  final Value<DateTime> startedAt;
  final Value<DateTime> lastUpdated;
  final Value<bool> isValid;
  const ModelReturnCompanion({
    this.returnId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.returnStatus = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.dueAmount = const Value.absent(),
    this.returnedBy = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isValid = const Value.absent(),
  });
  ModelReturnCompanion.insert({
    this.returnId = const Value.absent(),
    required int orderId,
    required String returnStatus,
    required String paymentStatus,
    required double dueAmount,
    required String returnedBy,
    this.startedAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isValid = const Value.absent(),
  })  : orderId = Value(orderId),
        returnStatus = Value(returnStatus),
        paymentStatus = Value(paymentStatus),
        dueAmount = Value(dueAmount),
        returnedBy = Value(returnedBy);
  static Insertable<ModelReturnData> custom({
    Expression<int>? returnId,
    Expression<int>? orderId,
    Expression<String>? returnStatus,
    Expression<String>? paymentStatus,
    Expression<double>? dueAmount,
    Expression<String>? returnedBy,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? lastUpdated,
    Expression<bool>? isValid,
  }) {
    return RawValuesInsertable({
      if (returnId != null) 'return_id': returnId,
      if (orderId != null) 'order_id': orderId,
      if (returnStatus != null) 'return_status': returnStatus,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (dueAmount != null) 'due_amount': dueAmount,
      if (returnedBy != null) 'returned_by': returnedBy,
      if (startedAt != null) 'started_at': startedAt,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (isValid != null) 'is_valid': isValid,
    });
  }

  ModelReturnCompanion copyWith(
      {Value<int>? returnId,
      Value<int>? orderId,
      Value<String>? returnStatus,
      Value<String>? paymentStatus,
      Value<double>? dueAmount,
      Value<String>? returnedBy,
      Value<DateTime>? startedAt,
      Value<DateTime>? lastUpdated,
      Value<bool>? isValid}) {
    return ModelReturnCompanion(
      returnId: returnId ?? this.returnId,
      orderId: orderId ?? this.orderId,
      returnStatus: returnStatus ?? this.returnStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      dueAmount: dueAmount ?? this.dueAmount,
      returnedBy: returnedBy ?? this.returnedBy,
      startedAt: startedAt ?? this.startedAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (returnId.present) {
      map['return_id'] = Variable<int>(returnId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (returnStatus.present) {
      map['return_status'] = Variable<String>(returnStatus.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(paymentStatus.value);
    }
    if (dueAmount.present) {
      map['due_amount'] = Variable<double>(dueAmount.value);
    }
    if (returnedBy.present) {
      map['returned_by'] = Variable<String>(returnedBy.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (isValid.present) {
      map['is_valid'] = Variable<bool>(isValid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelReturnCompanion(')
          ..write('returnId: $returnId, ')
          ..write('orderId: $orderId, ')
          ..write('returnStatus: $returnStatus, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('dueAmount: $dueAmount, ')
          ..write('returnedBy: $returnedBy, ')
          ..write('startedAt: $startedAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isValid: $isValid')
          ..write(')'))
        .toString();
  }
}

class $ModelReturnTable extends ModelReturn
    with TableInfo<$ModelReturnTable, ModelReturnData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelReturnTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _returnIdMeta = const VerificationMeta('returnId');
  @override
  late final GeneratedColumn<int?> returnId = GeneratedColumn<int?>(
      'return_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int?> orderId = GeneratedColumn<int?>(
      'order_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES model_order (order_id)');
  final VerificationMeta _returnStatusMeta =
      const VerificationMeta('returnStatus');
  @override
  late final GeneratedColumn<String?> returnStatus = GeneratedColumn<String?>(
      'return_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _paymentStatusMeta =
      const VerificationMeta('paymentStatus');
  @override
  late final GeneratedColumn<String?> paymentStatus = GeneratedColumn<String?>(
      'payment_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _dueAmountMeta = const VerificationMeta('dueAmount');
  @override
  late final GeneratedColumn<double?> dueAmount = GeneratedColumn<double?>(
      'due_amount', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _returnedByMeta = const VerificationMeta('returnedBy');
  @override
  late final GeneratedColumn<String?> returnedBy = GeneratedColumn<String?>(
      'returned_by', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _startedAtMeta = const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime?> startedAt = GeneratedColumn<DateTime?>(
      'started_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  final VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime?> lastUpdated =
      GeneratedColumn<DateTime?>('last_updated', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime.now()));
  final VerificationMeta _isValidMeta = const VerificationMeta('isValid');
  @override
  late final GeneratedColumn<bool?> isValid = GeneratedColumn<bool?>(
      'is_valid', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_valid IN (0, 1))',
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        returnId,
        orderId,
        returnStatus,
        paymentStatus,
        dueAmount,
        returnedBy,
        startedAt,
        lastUpdated,
        isValid
      ];
  @override
  String get aliasedName => _alias ?? 'model_return';
  @override
  String get actualTableName => 'model_return';
  @override
  VerificationContext validateIntegrity(Insertable<ModelReturnData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('return_id')) {
      context.handle(_returnIdMeta,
          returnId.isAcceptableOrUnknown(data['return_id']!, _returnIdMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('return_status')) {
      context.handle(
          _returnStatusMeta,
          returnStatus.isAcceptableOrUnknown(
              data['return_status']!, _returnStatusMeta));
    } else if (isInserting) {
      context.missing(_returnStatusMeta);
    }
    if (data.containsKey('payment_status')) {
      context.handle(
          _paymentStatusMeta,
          paymentStatus.isAcceptableOrUnknown(
              data['payment_status']!, _paymentStatusMeta));
    } else if (isInserting) {
      context.missing(_paymentStatusMeta);
    }
    if (data.containsKey('due_amount')) {
      context.handle(_dueAmountMeta,
          dueAmount.isAcceptableOrUnknown(data['due_amount']!, _dueAmountMeta));
    } else if (isInserting) {
      context.missing(_dueAmountMeta);
    }
    if (data.containsKey('returned_by')) {
      context.handle(
          _returnedByMeta,
          returnedBy.isAcceptableOrUnknown(
              data['returned_by']!, _returnedByMeta));
    } else if (isInserting) {
      context.missing(_returnedByMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    if (data.containsKey('is_valid')) {
      context.handle(_isValidMeta,
          isValid.isAcceptableOrUnknown(data['is_valid']!, _isValidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {returnId};
  @override
  ModelReturnData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ModelReturnData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelReturnTable createAlias(String alias) {
    return $ModelReturnTable(attachedDatabase, alias);
  }
}

class ModelPaymentReceivedData extends DataClass
    implements Insertable<ModelPaymentReceivedData> {
  final int paymentReceivedId;
  final int orderId;
  final double amount;
  final String paymentMode;
  final String paymentNote;
  final DateTime createdAt;
  final bool isValid;
  ModelPaymentReceivedData(
      {required this.paymentReceivedId,
      required this.orderId,
      required this.amount,
      required this.paymentMode,
      required this.paymentNote,
      required this.createdAt,
      required this.isValid});
  factory ModelPaymentReceivedData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelPaymentReceivedData(
      paymentReceivedId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}payment_received_id'])!,
      orderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
      amount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      paymentMode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_mode'])!,
      paymentNote: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_note'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      isValid: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_valid'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['payment_received_id'] = Variable<int>(paymentReceivedId);
    map['order_id'] = Variable<int>(orderId);
    map['amount'] = Variable<double>(amount);
    map['payment_mode'] = Variable<String>(paymentMode);
    map['payment_note'] = Variable<String>(paymentNote);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_valid'] = Variable<bool>(isValid);
    return map;
  }

  ModelPaymentReceivedCompanion toCompanion(bool nullToAbsent) {
    return ModelPaymentReceivedCompanion(
      paymentReceivedId: Value(paymentReceivedId),
      orderId: Value(orderId),
      amount: Value(amount),
      paymentMode: Value(paymentMode),
      paymentNote: Value(paymentNote),
      createdAt: Value(createdAt),
      isValid: Value(isValid),
    );
  }

  factory ModelPaymentReceivedData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelPaymentReceivedData(
      paymentReceivedId: serializer.fromJson<int>(json['paymentReceivedId']),
      orderId: serializer.fromJson<int>(json['orderId']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMode: serializer.fromJson<String>(json['paymentMode']),
      paymentNote: serializer.fromJson<String>(json['paymentNote']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isValid: serializer.fromJson<bool>(json['isValid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'paymentReceivedId': serializer.toJson<int>(paymentReceivedId),
      'orderId': serializer.toJson<int>(orderId),
      'amount': serializer.toJson<double>(amount),
      'paymentMode': serializer.toJson<String>(paymentMode),
      'paymentNote': serializer.toJson<String>(paymentNote),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isValid': serializer.toJson<bool>(isValid),
    };
  }

  ModelPaymentReceivedData copyWith(
          {int? paymentReceivedId,
          int? orderId,
          double? amount,
          String? paymentMode,
          String? paymentNote,
          DateTime? createdAt,
          bool? isValid}) =>
      ModelPaymentReceivedData(
        paymentReceivedId: paymentReceivedId ?? this.paymentReceivedId,
        orderId: orderId ?? this.orderId,
        amount: amount ?? this.amount,
        paymentMode: paymentMode ?? this.paymentMode,
        paymentNote: paymentNote ?? this.paymentNote,
        createdAt: createdAt ?? this.createdAt,
        isValid: isValid ?? this.isValid,
      );
  @override
  String toString() {
    return (StringBuffer('ModelPaymentReceivedData(')
          ..write('paymentReceivedId: $paymentReceivedId, ')
          ..write('orderId: $orderId, ')
          ..write('amount: $amount, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('paymentNote: $paymentNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('isValid: $isValid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(paymentReceivedId, orderId, amount,
      paymentMode, paymentNote, createdAt, isValid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelPaymentReceivedData &&
          other.paymentReceivedId == this.paymentReceivedId &&
          other.orderId == this.orderId &&
          other.amount == this.amount &&
          other.paymentMode == this.paymentMode &&
          other.paymentNote == this.paymentNote &&
          other.createdAt == this.createdAt &&
          other.isValid == this.isValid);
}

class ModelPaymentReceivedCompanion
    extends UpdateCompanion<ModelPaymentReceivedData> {
  final Value<int> paymentReceivedId;
  final Value<int> orderId;
  final Value<double> amount;
  final Value<String> paymentMode;
  final Value<String> paymentNote;
  final Value<DateTime> createdAt;
  final Value<bool> isValid;
  const ModelPaymentReceivedCompanion({
    this.paymentReceivedId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.paymentNote = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isValid = const Value.absent(),
  });
  ModelPaymentReceivedCompanion.insert({
    this.paymentReceivedId = const Value.absent(),
    required int orderId,
    required double amount,
    required String paymentMode,
    required String paymentNote,
    this.createdAt = const Value.absent(),
    this.isValid = const Value.absent(),
  })  : orderId = Value(orderId),
        amount = Value(amount),
        paymentMode = Value(paymentMode),
        paymentNote = Value(paymentNote);
  static Insertable<ModelPaymentReceivedData> custom({
    Expression<int>? paymentReceivedId,
    Expression<int>? orderId,
    Expression<double>? amount,
    Expression<String>? paymentMode,
    Expression<String>? paymentNote,
    Expression<DateTime>? createdAt,
    Expression<bool>? isValid,
  }) {
    return RawValuesInsertable({
      if (paymentReceivedId != null) 'payment_received_id': paymentReceivedId,
      if (orderId != null) 'order_id': orderId,
      if (amount != null) 'amount': amount,
      if (paymentMode != null) 'payment_mode': paymentMode,
      if (paymentNote != null) 'payment_note': paymentNote,
      if (createdAt != null) 'created_at': createdAt,
      if (isValid != null) 'is_valid': isValid,
    });
  }

  ModelPaymentReceivedCompanion copyWith(
      {Value<int>? paymentReceivedId,
      Value<int>? orderId,
      Value<double>? amount,
      Value<String>? paymentMode,
      Value<String>? paymentNote,
      Value<DateTime>? createdAt,
      Value<bool>? isValid}) {
    return ModelPaymentReceivedCompanion(
      paymentReceivedId: paymentReceivedId ?? this.paymentReceivedId,
      orderId: orderId ?? this.orderId,
      amount: amount ?? this.amount,
      paymentMode: paymentMode ?? this.paymentMode,
      paymentNote: paymentNote ?? this.paymentNote,
      createdAt: createdAt ?? this.createdAt,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (paymentReceivedId.present) {
      map['payment_received_id'] = Variable<int>(paymentReceivedId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMode.present) {
      map['payment_mode'] = Variable<String>(paymentMode.value);
    }
    if (paymentNote.present) {
      map['payment_note'] = Variable<String>(paymentNote.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isValid.present) {
      map['is_valid'] = Variable<bool>(isValid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelPaymentReceivedCompanion(')
          ..write('paymentReceivedId: $paymentReceivedId, ')
          ..write('orderId: $orderId, ')
          ..write('amount: $amount, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('paymentNote: $paymentNote, ')
          ..write('createdAt: $createdAt, ')
          ..write('isValid: $isValid')
          ..write(')'))
        .toString();
  }
}

class $ModelPaymentReceivedTable extends ModelPaymentReceived
    with TableInfo<$ModelPaymentReceivedTable, ModelPaymentReceivedData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelPaymentReceivedTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _paymentReceivedIdMeta =
      const VerificationMeta('paymentReceivedId');
  @override
  late final GeneratedColumn<int?> paymentReceivedId = GeneratedColumn<int?>(
      'payment_received_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int?> orderId = GeneratedColumn<int?>(
      'order_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES model_order (order_id)');
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double?> amount = GeneratedColumn<double?>(
      'amount', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _paymentModeMeta =
      const VerificationMeta('paymentMode');
  @override
  late final GeneratedColumn<String?> paymentMode = GeneratedColumn<String?>(
      'payment_mode', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _paymentNoteMeta =
      const VerificationMeta('paymentNote');
  @override
  late final GeneratedColumn<String?> paymentNote = GeneratedColumn<String?>(
      'payment_note', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  final VerificationMeta _isValidMeta = const VerificationMeta('isValid');
  @override
  late final GeneratedColumn<bool?> isValid = GeneratedColumn<bool?>(
      'is_valid', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_valid IN (0, 1))',
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        paymentReceivedId,
        orderId,
        amount,
        paymentMode,
        paymentNote,
        createdAt,
        isValid
      ];
  @override
  String get aliasedName => _alias ?? 'model_payment_received';
  @override
  String get actualTableName => 'model_payment_received';
  @override
  VerificationContext validateIntegrity(
      Insertable<ModelPaymentReceivedData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('payment_received_id')) {
      context.handle(
          _paymentReceivedIdMeta,
          paymentReceivedId.isAcceptableOrUnknown(
              data['payment_received_id']!, _paymentReceivedIdMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('payment_mode')) {
      context.handle(
          _paymentModeMeta,
          paymentMode.isAcceptableOrUnknown(
              data['payment_mode']!, _paymentModeMeta));
    } else if (isInserting) {
      context.missing(_paymentModeMeta);
    }
    if (data.containsKey('payment_note')) {
      context.handle(
          _paymentNoteMeta,
          paymentNote.isAcceptableOrUnknown(
              data['payment_note']!, _paymentNoteMeta));
    } else if (isInserting) {
      context.missing(_paymentNoteMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_valid')) {
      context.handle(_isValidMeta,
          isValid.isAcceptableOrUnknown(data['is_valid']!, _isValidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {paymentReceivedId};
  @override
  ModelPaymentReceivedData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return ModelPaymentReceivedData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelPaymentReceivedTable createAlias(String alias) {
    return $ModelPaymentReceivedTable(attachedDatabase, alias);
  }
}

class ModelSurveyData extends DataClass implements Insertable<ModelSurveyData> {
  final int surveyId;
  final int clientId;
  final int itemId;
  final double remainQuantity;
  final String surveyDescription;
  final String conductedBy;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final bool isValid;
  ModelSurveyData(
      {required this.surveyId,
      required this.clientId,
      required this.itemId,
      required this.remainQuantity,
      required this.surveyDescription,
      required this.conductedBy,
      required this.createdAt,
      required this.lastUpdated,
      required this.isValid});
  factory ModelSurveyData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelSurveyData(
      surveyId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}survey_id'])!,
      clientId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_id'])!,
      itemId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_id'])!,
      remainQuantity: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}remain_quantity'])!,
      surveyDescription: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}survey_description'])!,
      conductedBy: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}conducted_by'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      lastUpdated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated'])!,
      isValid: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_valid'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['survey_id'] = Variable<int>(surveyId);
    map['client_id'] = Variable<int>(clientId);
    map['item_id'] = Variable<int>(itemId);
    map['remain_quantity'] = Variable<double>(remainQuantity);
    map['survey_description'] = Variable<String>(surveyDescription);
    map['conducted_by'] = Variable<String>(conductedBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['is_valid'] = Variable<bool>(isValid);
    return map;
  }

  ModelSurveyCompanion toCompanion(bool nullToAbsent) {
    return ModelSurveyCompanion(
      surveyId: Value(surveyId),
      clientId: Value(clientId),
      itemId: Value(itemId),
      remainQuantity: Value(remainQuantity),
      surveyDescription: Value(surveyDescription),
      conductedBy: Value(conductedBy),
      createdAt: Value(createdAt),
      lastUpdated: Value(lastUpdated),
      isValid: Value(isValid),
    );
  }

  factory ModelSurveyData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelSurveyData(
      surveyId: serializer.fromJson<int>(json['surveyId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      itemId: serializer.fromJson<int>(json['itemId']),
      remainQuantity: serializer.fromJson<double>(json['remainQuantity']),
      surveyDescription: serializer.fromJson<String>(json['surveyDescription']),
      conductedBy: serializer.fromJson<String>(json['conductedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      isValid: serializer.fromJson<bool>(json['isValid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surveyId': serializer.toJson<int>(surveyId),
      'clientId': serializer.toJson<int>(clientId),
      'itemId': serializer.toJson<int>(itemId),
      'remainQuantity': serializer.toJson<double>(remainQuantity),
      'surveyDescription': serializer.toJson<String>(surveyDescription),
      'conductedBy': serializer.toJson<String>(conductedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'isValid': serializer.toJson<bool>(isValid),
    };
  }

  ModelSurveyData copyWith(
          {int? surveyId,
          int? clientId,
          int? itemId,
          double? remainQuantity,
          String? surveyDescription,
          String? conductedBy,
          DateTime? createdAt,
          DateTime? lastUpdated,
          bool? isValid}) =>
      ModelSurveyData(
        surveyId: surveyId ?? this.surveyId,
        clientId: clientId ?? this.clientId,
        itemId: itemId ?? this.itemId,
        remainQuantity: remainQuantity ?? this.remainQuantity,
        surveyDescription: surveyDescription ?? this.surveyDescription,
        conductedBy: conductedBy ?? this.conductedBy,
        createdAt: createdAt ?? this.createdAt,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        isValid: isValid ?? this.isValid,
      );
  @override
  String toString() {
    return (StringBuffer('ModelSurveyData(')
          ..write('surveyId: $surveyId, ')
          ..write('clientId: $clientId, ')
          ..write('itemId: $itemId, ')
          ..write('remainQuantity: $remainQuantity, ')
          ..write('surveyDescription: $surveyDescription, ')
          ..write('conductedBy: $conductedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isValid: $isValid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(surveyId, clientId, itemId, remainQuantity,
      surveyDescription, conductedBy, createdAt, lastUpdated, isValid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelSurveyData &&
          other.surveyId == this.surveyId &&
          other.clientId == this.clientId &&
          other.itemId == this.itemId &&
          other.remainQuantity == this.remainQuantity &&
          other.surveyDescription == this.surveyDescription &&
          other.conductedBy == this.conductedBy &&
          other.createdAt == this.createdAt &&
          other.lastUpdated == this.lastUpdated &&
          other.isValid == this.isValid);
}

class ModelSurveyCompanion extends UpdateCompanion<ModelSurveyData> {
  final Value<int> surveyId;
  final Value<int> clientId;
  final Value<int> itemId;
  final Value<double> remainQuantity;
  final Value<String> surveyDescription;
  final Value<String> conductedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastUpdated;
  final Value<bool> isValid;
  const ModelSurveyCompanion({
    this.surveyId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.remainQuantity = const Value.absent(),
    this.surveyDescription = const Value.absent(),
    this.conductedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isValid = const Value.absent(),
  });
  ModelSurveyCompanion.insert({
    this.surveyId = const Value.absent(),
    required int clientId,
    required int itemId,
    required double remainQuantity,
    required String surveyDescription,
    required String conductedBy,
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isValid = const Value.absent(),
  })  : clientId = Value(clientId),
        itemId = Value(itemId),
        remainQuantity = Value(remainQuantity),
        surveyDescription = Value(surveyDescription),
        conductedBy = Value(conductedBy);
  static Insertable<ModelSurveyData> custom({
    Expression<int>? surveyId,
    Expression<int>? clientId,
    Expression<int>? itemId,
    Expression<double>? remainQuantity,
    Expression<String>? surveyDescription,
    Expression<String>? conductedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdated,
    Expression<bool>? isValid,
  }) {
    return RawValuesInsertable({
      if (surveyId != null) 'survey_id': surveyId,
      if (clientId != null) 'client_id': clientId,
      if (itemId != null) 'item_id': itemId,
      if (remainQuantity != null) 'remain_quantity': remainQuantity,
      if (surveyDescription != null) 'survey_description': surveyDescription,
      if (conductedBy != null) 'conducted_by': conductedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (isValid != null) 'is_valid': isValid,
    });
  }

  ModelSurveyCompanion copyWith(
      {Value<int>? surveyId,
      Value<int>? clientId,
      Value<int>? itemId,
      Value<double>? remainQuantity,
      Value<String>? surveyDescription,
      Value<String>? conductedBy,
      Value<DateTime>? createdAt,
      Value<DateTime>? lastUpdated,
      Value<bool>? isValid}) {
    return ModelSurveyCompanion(
      surveyId: surveyId ?? this.surveyId,
      clientId: clientId ?? this.clientId,
      itemId: itemId ?? this.itemId,
      remainQuantity: remainQuantity ?? this.remainQuantity,
      surveyDescription: surveyDescription ?? this.surveyDescription,
      conductedBy: conductedBy ?? this.conductedBy,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surveyId.present) {
      map['survey_id'] = Variable<int>(surveyId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (remainQuantity.present) {
      map['remain_quantity'] = Variable<double>(remainQuantity.value);
    }
    if (surveyDescription.present) {
      map['survey_description'] = Variable<String>(surveyDescription.value);
    }
    if (conductedBy.present) {
      map['conducted_by'] = Variable<String>(conductedBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (isValid.present) {
      map['is_valid'] = Variable<bool>(isValid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelSurveyCompanion(')
          ..write('surveyId: $surveyId, ')
          ..write('clientId: $clientId, ')
          ..write('itemId: $itemId, ')
          ..write('remainQuantity: $remainQuantity, ')
          ..write('surveyDescription: $surveyDescription, ')
          ..write('conductedBy: $conductedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isValid: $isValid')
          ..write(')'))
        .toString();
  }
}

class $ModelSurveyTable extends ModelSurvey
    with TableInfo<$ModelSurveyTable, ModelSurveyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelSurveyTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _surveyIdMeta = const VerificationMeta('surveyId');
  @override
  late final GeneratedColumn<int?> surveyId = GeneratedColumn<int?>(
      'survey_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _clientIdMeta = const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<int?> clientId = GeneratedColumn<int?>(
      'client_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES model_client (client_id)');
  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int?> itemId = GeneratedColumn<int?>(
      'item_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES model_item (item_id)');
  final VerificationMeta _remainQuantityMeta =
      const VerificationMeta('remainQuantity');
  @override
  late final GeneratedColumn<double?> remainQuantity = GeneratedColumn<double?>(
      'remain_quantity', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _surveyDescriptionMeta =
      const VerificationMeta('surveyDescription');
  @override
  late final GeneratedColumn<String?> surveyDescription =
      GeneratedColumn<String?>('survey_description', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 3, maxTextLength: 50),
          type: const StringType(),
          requiredDuringInsert: true);
  final VerificationMeta _conductedByMeta =
      const VerificationMeta('conductedBy');
  @override
  late final GeneratedColumn<String?> conductedBy = GeneratedColumn<String?>(
      'conducted_by', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  final VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime?> lastUpdated =
      GeneratedColumn<DateTime?>('last_updated', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: Constant(DateTime.now()));
  final VerificationMeta _isValidMeta = const VerificationMeta('isValid');
  @override
  late final GeneratedColumn<bool?> isValid = GeneratedColumn<bool?>(
      'is_valid', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_valid IN (0, 1))',
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        surveyId,
        clientId,
        itemId,
        remainQuantity,
        surveyDescription,
        conductedBy,
        createdAt,
        lastUpdated,
        isValid
      ];
  @override
  String get aliasedName => _alias ?? 'model_survey';
  @override
  String get actualTableName => 'model_survey';
  @override
  VerificationContext validateIntegrity(Insertable<ModelSurveyData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('survey_id')) {
      context.handle(_surveyIdMeta,
          surveyId.isAcceptableOrUnknown(data['survey_id']!, _surveyIdMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(_itemIdMeta,
          itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta));
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('remain_quantity')) {
      context.handle(
          _remainQuantityMeta,
          remainQuantity.isAcceptableOrUnknown(
              data['remain_quantity']!, _remainQuantityMeta));
    } else if (isInserting) {
      context.missing(_remainQuantityMeta);
    }
    if (data.containsKey('survey_description')) {
      context.handle(
          _surveyDescriptionMeta,
          surveyDescription.isAcceptableOrUnknown(
              data['survey_description']!, _surveyDescriptionMeta));
    } else if (isInserting) {
      context.missing(_surveyDescriptionMeta);
    }
    if (data.containsKey('conducted_by')) {
      context.handle(
          _conductedByMeta,
          conductedBy.isAcceptableOrUnknown(
              data['conducted_by']!, _conductedByMeta));
    } else if (isInserting) {
      context.missing(_conductedByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    if (data.containsKey('is_valid')) {
      context.handle(_isValidMeta,
          isValid.isAcceptableOrUnknown(data['is_valid']!, _isValidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surveyId};
  @override
  ModelSurveyData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ModelSurveyData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelSurveyTable createAlias(String alias) {
    return $ModelSurveyTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ModelClientTable modelClient = $ModelClientTable(this);
  late final $ModelItemTable modelItem = $ModelItemTable(this);
  late final $ModelOrderTable modelOrder = $ModelOrderTable(this);
  late final $ModelDeliveryTable modelDelivery = $ModelDeliveryTable(this);
  late final $ModelReturnTable modelReturn = $ModelReturnTable(this);
  late final $ModelPaymentReceivedTable modelPaymentReceived =
      $ModelPaymentReceivedTable(this);
  late final $ModelSurveyTable modelSurvey = $ModelSurveyTable(this);
  late final ClientTableQueries clientTableQueries =
      ClientTableQueries(this as AppDatabase);
  late final ItemTableQueries itemTableQueries =
      ItemTableQueries(this as AppDatabase);
  late final OrderTableQueries orderTableQueries =
      OrderTableQueries(this as AppDatabase);
  late final DeliveryTableQueries deliveryTableQueries =
      DeliveryTableQueries(this as AppDatabase);
  late final ReturnTableQueries returnTableQueries =
      ReturnTableQueries(this as AppDatabase);
  late final PaymentReceivedTableQueries paymentReceivedTableQueries =
      PaymentReceivedTableQueries(this as AppDatabase);
  late final SurveyTableQueries surveyTableQueries =
      SurveyTableQueries(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        modelClient,
        modelItem,
        modelOrder,
        modelDelivery,
        modelReturn,
        modelPaymentReceived,
        modelSurvey
      ];
}
