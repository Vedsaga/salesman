// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: require_trailing_commas, avoid_redundant_argument_values, avoid_positional_boolean_parameters

part of 'app_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ModelClientData extends DataClass implements Insertable<ModelClientData> {
  final int clientId;
  final String clientName;
  final String clientPhone;
  final double totalTrade;
  final double dueAmount;
  final bool isActive;
  final DateTime? lastTradeOn;
  ModelClientData(
      {required this.clientId,
      required this.clientName,
      required this.clientPhone,
      required this.totalTrade,
      required this.dueAmount,
      required this.isActive,
      this.lastTradeOn});
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
      totalTrade: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_trade'])!,
      dueAmount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}due_amount'])!,
      isActive: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_active'])!,
      lastTradeOn: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_trade_on']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_id'] = Variable<int>(clientId);
    map['client_name'] = Variable<String>(clientName);
    map['client_phone'] = Variable<String>(clientPhone);
    map['total_trade'] = Variable<double>(totalTrade);
    map['due_amount'] = Variable<double>(dueAmount);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastTradeOn != null) {
      map['last_trade_on'] = Variable<DateTime?>(lastTradeOn);
    }
    return map;
  }

  ModelClientCompanion toCompanion(bool nullToAbsent) {
    return ModelClientCompanion(
      clientId: Value(clientId),
      clientName: Value(clientName),
      clientPhone: Value(clientPhone),
      totalTrade: Value(totalTrade),
      dueAmount: Value(dueAmount),
      isActive: Value(isActive),
      lastTradeOn: lastTradeOn == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTradeOn),
    );
  }

  factory ModelClientData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelClientData(
      clientId: serializer.fromJson<int>(json['clientId']),
      clientName: serializer.fromJson<String>(json['clientName']),
      clientPhone: serializer.fromJson<String>(json['clientPhone']),
      totalTrade: serializer.fromJson<double>(json['totalTrade']),
      dueAmount: serializer.fromJson<double>(json['dueAmount']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastTradeOn: serializer.fromJson<DateTime?>(json['lastTradeOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientId': serializer.toJson<int>(clientId),
      'clientName': serializer.toJson<String>(clientName),
      'clientPhone': serializer.toJson<String>(clientPhone),
      'totalTrade': serializer.toJson<double>(totalTrade),
      'dueAmount': serializer.toJson<double>(dueAmount),
      'isActive': serializer.toJson<bool>(isActive),
      'lastTradeOn': serializer.toJson<DateTime?>(lastTradeOn),
    };
  }

  ModelClientData copyWith(
          {int? clientId,
          String? clientName,
          String? clientPhone,
          double? totalTrade,
          double? dueAmount,
          bool? isActive,
          DateTime? lastTradeOn}) =>
      ModelClientData(
        clientId: clientId ?? this.clientId,
        clientName: clientName ?? this.clientName,
        clientPhone: clientPhone ?? this.clientPhone,
        totalTrade: totalTrade ?? this.totalTrade,
        dueAmount: dueAmount ?? this.dueAmount,
        isActive: isActive ?? this.isActive,
        lastTradeOn: lastTradeOn ?? this.lastTradeOn,
      );
  @override
  String toString() {
    return (StringBuffer('ModelClientData(')
          ..write('clientId: $clientId, ')
          ..write('clientName: $clientName, ')
          ..write('clientPhone: $clientPhone, ')
          ..write('totalTrade: $totalTrade, ')
          ..write('dueAmount: $dueAmount, ')
          ..write('isActive: $isActive, ')
          ..write('lastTradeOn: $lastTradeOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clientId, clientName, clientPhone, totalTrade,
      dueAmount, isActive, lastTradeOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelClientData &&
          other.clientId == this.clientId &&
          other.clientName == this.clientName &&
          other.clientPhone == this.clientPhone &&
          other.totalTrade == this.totalTrade &&
          other.dueAmount == this.dueAmount &&
          other.isActive == this.isActive &&
          other.lastTradeOn == this.lastTradeOn);
}

class ModelClientCompanion extends UpdateCompanion<ModelClientData> {
  final Value<int> clientId;
  final Value<String> clientName;
  final Value<String> clientPhone;
  final Value<double> totalTrade;
  final Value<double> dueAmount;
  final Value<bool> isActive;
  final Value<DateTime?> lastTradeOn;
  const ModelClientCompanion({
    this.clientId = const Value.absent(),
    this.clientName = const Value.absent(),
    this.clientPhone = const Value.absent(),
    this.totalTrade = const Value.absent(),
    this.dueAmount = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastTradeOn = const Value.absent(),
  });
  ModelClientCompanion.insert({
    this.clientId = const Value.absent(),
    required String clientName,
    required String clientPhone,
    this.totalTrade = const Value.absent(),
    this.dueAmount = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastTradeOn = const Value.absent(),
  })  : clientName = Value(clientName),
        clientPhone = Value(clientPhone);
  static Insertable<ModelClientData> custom({
    Expression<int>? clientId,
    Expression<String>? clientName,
    Expression<String>? clientPhone,
    Expression<double>? totalTrade,
    Expression<double>? dueAmount,
    Expression<bool>? isActive,
    Expression<DateTime?>? lastTradeOn,
  }) {
    return RawValuesInsertable({
      if (clientId != null) 'client_id': clientId,
      if (clientName != null) 'client_name': clientName,
      if (clientPhone != null) 'client_phone': clientPhone,
      if (totalTrade != null) 'total_trade': totalTrade,
      if (dueAmount != null) 'due_amount': dueAmount,
      if (isActive != null) 'is_active': isActive,
      if (lastTradeOn != null) 'last_trade_on': lastTradeOn,
    });
  }

  ModelClientCompanion copyWith(
      {Value<int>? clientId,
      Value<String>? clientName,
      Value<String>? clientPhone,
      Value<double>? totalTrade,
      Value<double>? dueAmount,
      Value<bool>? isActive,
      Value<DateTime?>? lastTradeOn}) {
    return ModelClientCompanion(
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      totalTrade: totalTrade ?? this.totalTrade,
      dueAmount: dueAmount ?? this.dueAmount,
      isActive: isActive ?? this.isActive,
      lastTradeOn: lastTradeOn ?? this.lastTradeOn,
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
    if (totalTrade.present) {
      map['total_trade'] = Variable<double>(totalTrade.value);
    }
    if (dueAmount.present) {
      map['due_amount'] = Variable<double>(dueAmount.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastTradeOn.present) {
      map['last_trade_on'] = Variable<DateTime?>(lastTradeOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelClientCompanion(')
          ..write('clientId: $clientId, ')
          ..write('clientName: $clientName, ')
          ..write('clientPhone: $clientPhone, ')
          ..write('totalTrade: $totalTrade, ')
          ..write('dueAmount: $dueAmount, ')
          ..write('isActive: $isActive, ')
          ..write('lastTradeOn: $lastTradeOn')
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
  final VerificationMeta _totalTradeMeta = const VerificationMeta('totalTrade');
  @override
  late final GeneratedColumn<double?> totalTrade = GeneratedColumn<double?>(
      'total_trade', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  final VerificationMeta _dueAmountMeta = const VerificationMeta('dueAmount');
  @override
  late final GeneratedColumn<double?> dueAmount = GeneratedColumn<double?>(
      'due_amount', aliasedName, false,
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
  final VerificationMeta _lastTradeOnMeta =
      const VerificationMeta('lastTradeOn');
  @override
  late final GeneratedColumn<DateTime?> lastTradeOn =
      GeneratedColumn<DateTime?>('last_trade_on', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        clientId,
        clientName,
        clientPhone,
        totalTrade,
        dueAmount,
        isActive,
        lastTradeOn
      ];
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
    if (data.containsKey('total_trade')) {
      context.handle(
          _totalTradeMeta,
          totalTrade.isAcceptableOrUnknown(
              data['total_trade']!, _totalTradeMeta));
    }
    if (data.containsKey('due_amount')) {
      context.handle(_dueAmountMeta,
          dueAmount.isAcceptableOrUnknown(data['due_amount']!, _dueAmountMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('last_trade_on')) {
      context.handle(
          _lastTradeOnMeta,
          lastTradeOn.isAcceptableOrUnknown(
              data['last_trade_on']!, _lastTradeOnMeta));
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
  final double sellingPricePerUnit;
  final double buyingPricePerUnit;
  final double totalTrade;
  final double availableQuantity;
  final double reservedQuantity;
  final bool isActive;
  ModelItemData(
      {required this.itemId,
      required this.itemName,
      required this.unit,
      required this.sellingPricePerUnit,
      required this.buyingPricePerUnit,
      required this.totalTrade,
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
      sellingPricePerUnit: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}selling_price_per_unit'])!,
      buyingPricePerUnit: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}buying_price_per_unit'])!,
      totalTrade: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_trade'])!,
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
    map['selling_price_per_unit'] = Variable<double>(sellingPricePerUnit);
    map['buying_price_per_unit'] = Variable<double>(buyingPricePerUnit);
    map['total_trade'] = Variable<double>(totalTrade);
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
      sellingPricePerUnit: Value(sellingPricePerUnit),
      buyingPricePerUnit: Value(buyingPricePerUnit),
      totalTrade: Value(totalTrade),
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
      sellingPricePerUnit:
          serializer.fromJson<double>(json['sellingPricePerUnit']),
      buyingPricePerUnit:
          serializer.fromJson<double>(json['buyingPricePerUnit']),
      totalTrade: serializer.fromJson<double>(json['totalTrade']),
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
      'sellingPricePerUnit': serializer.toJson<double>(sellingPricePerUnit),
      'buyingPricePerUnit': serializer.toJson<double>(buyingPricePerUnit),
      'totalTrade': serializer.toJson<double>(totalTrade),
      'availableQuantity': serializer.toJson<double>(availableQuantity),
      'reservedQuantity': serializer.toJson<double>(reservedQuantity),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  ModelItemData copyWith(
          {int? itemId,
          String? itemName,
          String? unit,
          double? sellingPricePerUnit,
          double? buyingPricePerUnit,
          double? totalTrade,
          double? availableQuantity,
          double? reservedQuantity,
          bool? isActive}) =>
      ModelItemData(
        itemId: itemId ?? this.itemId,
        itemName: itemName ?? this.itemName,
        unit: unit ?? this.unit,
        sellingPricePerUnit: sellingPricePerUnit ?? this.sellingPricePerUnit,
        buyingPricePerUnit: buyingPricePerUnit ?? this.buyingPricePerUnit,
        totalTrade: totalTrade ?? this.totalTrade,
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
          ..write('sellingPricePerUnit: $sellingPricePerUnit, ')
          ..write('buyingPricePerUnit: $buyingPricePerUnit, ')
          ..write('totalTrade: $totalTrade, ')
          ..write('availableQuantity: $availableQuantity, ')
          ..write('reservedQuantity: $reservedQuantity, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      itemId,
      itemName,
      unit,
      sellingPricePerUnit,
      buyingPricePerUnit,
      totalTrade,
      availableQuantity,
      reservedQuantity,
      isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelItemData &&
          other.itemId == this.itemId &&
          other.itemName == this.itemName &&
          other.unit == this.unit &&
          other.sellingPricePerUnit == this.sellingPricePerUnit &&
          other.buyingPricePerUnit == this.buyingPricePerUnit &&
          other.totalTrade == this.totalTrade &&
          other.availableQuantity == this.availableQuantity &&
          other.reservedQuantity == this.reservedQuantity &&
          other.isActive == this.isActive);
}

class ModelItemCompanion extends UpdateCompanion<ModelItemData> {
  final Value<int> itemId;
  final Value<String> itemName;
  final Value<String> unit;
  final Value<double> sellingPricePerUnit;
  final Value<double> buyingPricePerUnit;
  final Value<double> totalTrade;
  final Value<double> availableQuantity;
  final Value<double> reservedQuantity;
  final Value<bool> isActive;
  const ModelItemCompanion({
    this.itemId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.unit = const Value.absent(),
    this.sellingPricePerUnit = const Value.absent(),
    this.buyingPricePerUnit = const Value.absent(),
    this.totalTrade = const Value.absent(),
    this.availableQuantity = const Value.absent(),
    this.reservedQuantity = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  ModelItemCompanion.insert({
    this.itemId = const Value.absent(),
    required String itemName,
    required String unit,
    this.sellingPricePerUnit = const Value.absent(),
    this.buyingPricePerUnit = const Value.absent(),
    this.totalTrade = const Value.absent(),
    this.availableQuantity = const Value.absent(),
    this.reservedQuantity = const Value.absent(),
    this.isActive = const Value.absent(),
  })  : itemName = Value(itemName),
        unit = Value(unit);
  static Insertable<ModelItemData> custom({
    Expression<int>? itemId,
    Expression<String>? itemName,
    Expression<String>? unit,
    Expression<double>? sellingPricePerUnit,
    Expression<double>? buyingPricePerUnit,
    Expression<double>? totalTrade,
    Expression<double>? availableQuantity,
    Expression<double>? reservedQuantity,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (itemName != null) 'item_name': itemName,
      if (unit != null) 'unit': unit,
      if (sellingPricePerUnit != null)
        'selling_price_per_unit': sellingPricePerUnit,
      if (buyingPricePerUnit != null)
        'buying_price_per_unit': buyingPricePerUnit,
      if (totalTrade != null) 'total_trade': totalTrade,
      if (availableQuantity != null) 'available_quantity': availableQuantity,
      if (reservedQuantity != null) 'reserved_quantity': reservedQuantity,
      if (isActive != null) 'is_active': isActive,
    });
  }

  ModelItemCompanion copyWith(
      {Value<int>? itemId,
      Value<String>? itemName,
      Value<String>? unit,
      Value<double>? sellingPricePerUnit,
      Value<double>? buyingPricePerUnit,
      Value<double>? totalTrade,
      Value<double>? availableQuantity,
      Value<double>? reservedQuantity,
      Value<bool>? isActive}) {
    return ModelItemCompanion(
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      unit: unit ?? this.unit,
      sellingPricePerUnit: sellingPricePerUnit ?? this.sellingPricePerUnit,
      buyingPricePerUnit: buyingPricePerUnit ?? this.buyingPricePerUnit,
      totalTrade: totalTrade ?? this.totalTrade,
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
    if (sellingPricePerUnit.present) {
      map['selling_price_per_unit'] =
          Variable<double>(sellingPricePerUnit.value);
    }
    if (buyingPricePerUnit.present) {
      map['buying_price_per_unit'] = Variable<double>(buyingPricePerUnit.value);
    }
    if (totalTrade.present) {
      map['total_trade'] = Variable<double>(totalTrade.value);
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
          ..write('sellingPricePerUnit: $sellingPricePerUnit, ')
          ..write('buyingPricePerUnit: $buyingPricePerUnit, ')
          ..write('totalTrade: $totalTrade, ')
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
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _sellingPricePerUnitMeta =
      const VerificationMeta('sellingPricePerUnit');
  @override
  late final GeneratedColumn<double?> sellingPricePerUnit =
      GeneratedColumn<double?>('selling_price_per_unit', aliasedName, false,
          type: const RealType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  final VerificationMeta _buyingPricePerUnitMeta =
      const VerificationMeta('buyingPricePerUnit');
  @override
  late final GeneratedColumn<double?> buyingPricePerUnit =
      GeneratedColumn<double?>('buying_price_per_unit', aliasedName, false,
          type: const RealType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  final VerificationMeta _totalTradeMeta = const VerificationMeta('totalTrade');
  @override
  late final GeneratedColumn<double?> totalTrade = GeneratedColumn<double?>(
      'total_trade', aliasedName, false,
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
        sellingPricePerUnit,
        buyingPricePerUnit,
        totalTrade,
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
    if (data.containsKey('selling_price_per_unit')) {
      context.handle(
          _sellingPricePerUnitMeta,
          sellingPricePerUnit.isAcceptableOrUnknown(
              data['selling_price_per_unit']!, _sellingPricePerUnitMeta));
    }
    if (data.containsKey('buying_price_per_unit')) {
      context.handle(
          _buyingPricePerUnitMeta,
          buyingPricePerUnit.isAcceptableOrUnknown(
              data['buying_price_per_unit']!, _buyingPricePerUnitMeta));
    }
    if (data.containsKey('total_trade')) {
      context.handle(
          _totalTradeMeta,
          totalTrade.isAcceptableOrUnknown(
              data['total_trade']!, _totalTradeMeta));
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

class ModelDeliveryOrderData extends DataClass
    implements Insertable<ModelDeliveryOrderData> {
  final int deliveryOrderId;
  final int clientId;
  final int itemId;
  final double perUnitCost;
  final double totalQuantity;
  final double totalCost;
  final double totalReceivedAmount;
  final double totalSendAmount;
  final String? paymentStatus;
  final String orderStatus;
  final String createdBy;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final DateTime? expectedDeliveryDate;
  ModelDeliveryOrderData(
      {required this.deliveryOrderId,
      required this.clientId,
      required this.itemId,
      required this.perUnitCost,
      required this.totalQuantity,
      required this.totalCost,
      required this.totalReceivedAmount,
      required this.totalSendAmount,
      this.paymentStatus,
      required this.orderStatus,
      required this.createdBy,
      required this.createdAt,
      required this.lastUpdated,
      this.expectedDeliveryDate});
  factory ModelDeliveryOrderData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelDeliveryOrderData(
      deliveryOrderId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}delivery_order_id'])!,
      clientId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_id'])!,
      itemId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_id'])!,
      perUnitCost: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}per_unit_cost'])!,
      totalQuantity: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_quantity'])!,
      totalCost: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}total_cost'])!,
      totalReceivedAmount: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}total_received_amount'])!,
      totalSendAmount: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}total_send_amount'])!,
      paymentStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_status']),
      orderStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_status'])!,
      createdBy: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      lastUpdated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated'])!,
      expectedDeliveryDate: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}expected_delivery_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['delivery_order_id'] = Variable<int>(deliveryOrderId);
    map['client_id'] = Variable<int>(clientId);
    map['item_id'] = Variable<int>(itemId);
    map['per_unit_cost'] = Variable<double>(perUnitCost);
    map['total_quantity'] = Variable<double>(totalQuantity);
    map['total_cost'] = Variable<double>(totalCost);
    map['total_received_amount'] = Variable<double>(totalReceivedAmount);
    map['total_send_amount'] = Variable<double>(totalSendAmount);
    if (!nullToAbsent || paymentStatus != null) {
      map['payment_status'] = Variable<String?>(paymentStatus);
    }
    map['order_status'] = Variable<String>(orderStatus);
    map['created_by'] = Variable<String>(createdBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    if (!nullToAbsent || expectedDeliveryDate != null) {
      map['expected_delivery_date'] = Variable<DateTime?>(expectedDeliveryDate);
    }
    return map;
  }

  ModelDeliveryOrderCompanion toCompanion(bool nullToAbsent) {
    return ModelDeliveryOrderCompanion(
      deliveryOrderId: Value(deliveryOrderId),
      clientId: Value(clientId),
      itemId: Value(itemId),
      perUnitCost: Value(perUnitCost),
      totalQuantity: Value(totalQuantity),
      totalCost: Value(totalCost),
      totalReceivedAmount: Value(totalReceivedAmount),
      totalSendAmount: Value(totalSendAmount),
      paymentStatus: paymentStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentStatus),
      orderStatus: Value(orderStatus),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
      lastUpdated: Value(lastUpdated),
      expectedDeliveryDate: expectedDeliveryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedDeliveryDate),
    );
  }

  factory ModelDeliveryOrderData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelDeliveryOrderData(
      deliveryOrderId: serializer.fromJson<int>(json['deliveryOrderId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      itemId: serializer.fromJson<int>(json['itemId']),
      perUnitCost: serializer.fromJson<double>(json['perUnitCost']),
      totalQuantity: serializer.fromJson<double>(json['totalQuantity']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      totalReceivedAmount:
          serializer.fromJson<double>(json['totalReceivedAmount']),
      totalSendAmount: serializer.fromJson<double>(json['totalSendAmount']),
      paymentStatus: serializer.fromJson<String?>(json['paymentStatus']),
      orderStatus: serializer.fromJson<String>(json['orderStatus']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      expectedDeliveryDate:
          serializer.fromJson<DateTime?>(json['expectedDeliveryDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'deliveryOrderId': serializer.toJson<int>(deliveryOrderId),
      'clientId': serializer.toJson<int>(clientId),
      'itemId': serializer.toJson<int>(itemId),
      'perUnitCost': serializer.toJson<double>(perUnitCost),
      'totalQuantity': serializer.toJson<double>(totalQuantity),
      'totalCost': serializer.toJson<double>(totalCost),
      'totalReceivedAmount': serializer.toJson<double>(totalReceivedAmount),
      'totalSendAmount': serializer.toJson<double>(totalSendAmount),
      'paymentStatus': serializer.toJson<String?>(paymentStatus),
      'orderStatus': serializer.toJson<String>(orderStatus),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'expectedDeliveryDate':
          serializer.toJson<DateTime?>(expectedDeliveryDate),
    };
  }

  ModelDeliveryOrderData copyWith(
          {int? deliveryOrderId,
          int? clientId,
          int? itemId,
          double? perUnitCost,
          double? totalQuantity,
          double? totalCost,
          double? totalReceivedAmount,
          double? totalSendAmount,
          String? paymentStatus,
          String? orderStatus,
          String? createdBy,
          DateTime? createdAt,
          DateTime? lastUpdated,
          DateTime? expectedDeliveryDate}) =>
      ModelDeliveryOrderData(
        deliveryOrderId: deliveryOrderId ?? this.deliveryOrderId,
        clientId: clientId ?? this.clientId,
        itemId: itemId ?? this.itemId,
        perUnitCost: perUnitCost ?? this.perUnitCost,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        totalCost: totalCost ?? this.totalCost,
        totalReceivedAmount: totalReceivedAmount ?? this.totalReceivedAmount,
        totalSendAmount: totalSendAmount ?? this.totalSendAmount,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        orderStatus: orderStatus ?? this.orderStatus,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
      );
  @override
  String toString() {
    return (StringBuffer('ModelDeliveryOrderData(')
          ..write('deliveryOrderId: $deliveryOrderId, ')
          ..write('clientId: $clientId, ')
          ..write('itemId: $itemId, ')
          ..write('perUnitCost: $perUnitCost, ')
          ..write('totalQuantity: $totalQuantity, ')
          ..write('totalCost: $totalCost, ')
          ..write('totalReceivedAmount: $totalReceivedAmount, ')
          ..write('totalSendAmount: $totalSendAmount, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('orderStatus: $orderStatus, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('expectedDeliveryDate: $expectedDeliveryDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      deliveryOrderId,
      clientId,
      itemId,
      perUnitCost,
      totalQuantity,
      totalCost,
      totalReceivedAmount,
      totalSendAmount,
      paymentStatus,
      orderStatus,
      createdBy,
      createdAt,
      lastUpdated,
      expectedDeliveryDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelDeliveryOrderData &&
          other.deliveryOrderId == this.deliveryOrderId &&
          other.clientId == this.clientId &&
          other.itemId == this.itemId &&
          other.perUnitCost == this.perUnitCost &&
          other.totalQuantity == this.totalQuantity &&
          other.totalCost == this.totalCost &&
          other.totalReceivedAmount == this.totalReceivedAmount &&
          other.totalSendAmount == this.totalSendAmount &&
          other.paymentStatus == this.paymentStatus &&
          other.orderStatus == this.orderStatus &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.lastUpdated == this.lastUpdated &&
          other.expectedDeliveryDate == this.expectedDeliveryDate);
}

class ModelDeliveryOrderCompanion
    extends UpdateCompanion<ModelDeliveryOrderData> {
  final Value<int> deliveryOrderId;
  final Value<int> clientId;
  final Value<int> itemId;
  final Value<double> perUnitCost;
  final Value<double> totalQuantity;
  final Value<double> totalCost;
  final Value<double> totalReceivedAmount;
  final Value<double> totalSendAmount;
  final Value<String?> paymentStatus;
  final Value<String> orderStatus;
  final Value<String> createdBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastUpdated;
  final Value<DateTime?> expectedDeliveryDate;
  const ModelDeliveryOrderCompanion({
    this.deliveryOrderId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.perUnitCost = const Value.absent(),
    this.totalQuantity = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.totalReceivedAmount = const Value.absent(),
    this.totalSendAmount = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.orderStatus = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.expectedDeliveryDate = const Value.absent(),
  });
  ModelDeliveryOrderCompanion.insert({
    this.deliveryOrderId = const Value.absent(),
    required int clientId,
    required int itemId,
    required double perUnitCost,
    required double totalQuantity,
    required double totalCost,
    this.totalReceivedAmount = const Value.absent(),
    this.totalSendAmount = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    required String orderStatus,
    required String createdBy,
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.expectedDeliveryDate = const Value.absent(),
  })  : clientId = Value(clientId),
        itemId = Value(itemId),
        perUnitCost = Value(perUnitCost),
        totalQuantity = Value(totalQuantity),
        totalCost = Value(totalCost),
        orderStatus = Value(orderStatus),
        createdBy = Value(createdBy);
  static Insertable<ModelDeliveryOrderData> custom({
    Expression<int>? deliveryOrderId,
    Expression<int>? clientId,
    Expression<int>? itemId,
    Expression<double>? perUnitCost,
    Expression<double>? totalQuantity,
    Expression<double>? totalCost,
    Expression<double>? totalReceivedAmount,
    Expression<double>? totalSendAmount,
    Expression<String?>? paymentStatus,
    Expression<String>? orderStatus,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdated,
    Expression<DateTime?>? expectedDeliveryDate,
  }) {
    return RawValuesInsertable({
      if (deliveryOrderId != null) 'delivery_order_id': deliveryOrderId,
      if (clientId != null) 'client_id': clientId,
      if (itemId != null) 'item_id': itemId,
      if (perUnitCost != null) 'per_unit_cost': perUnitCost,
      if (totalQuantity != null) 'total_quantity': totalQuantity,
      if (totalCost != null) 'total_cost': totalCost,
      if (totalReceivedAmount != null)
        'total_received_amount': totalReceivedAmount,
      if (totalSendAmount != null) 'total_send_amount': totalSendAmount,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (orderStatus != null) 'order_status': orderStatus,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (expectedDeliveryDate != null)
        'expected_delivery_date': expectedDeliveryDate,
    });
  }

  ModelDeliveryOrderCompanion copyWith(
      {Value<int>? deliveryOrderId,
      Value<int>? clientId,
      Value<int>? itemId,
      Value<double>? perUnitCost,
      Value<double>? totalQuantity,
      Value<double>? totalCost,
      Value<double>? totalReceivedAmount,
      Value<double>? totalSendAmount,
      Value<String?>? paymentStatus,
      Value<String>? orderStatus,
      Value<String>? createdBy,
      Value<DateTime>? createdAt,
      Value<DateTime>? lastUpdated,
      Value<DateTime?>? expectedDeliveryDate}) {
    return ModelDeliveryOrderCompanion(
      deliveryOrderId: deliveryOrderId ?? this.deliveryOrderId,
      clientId: clientId ?? this.clientId,
      itemId: itemId ?? this.itemId,
      perUnitCost: perUnitCost ?? this.perUnitCost,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      totalCost: totalCost ?? this.totalCost,
      totalReceivedAmount: totalReceivedAmount ?? this.totalReceivedAmount,
      totalSendAmount: totalSendAmount ?? this.totalSendAmount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      orderStatus: orderStatus ?? this.orderStatus,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      expectedDeliveryDate: expectedDeliveryDate ?? this.expectedDeliveryDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (deliveryOrderId.present) {
      map['delivery_order_id'] = Variable<int>(deliveryOrderId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (perUnitCost.present) {
      map['per_unit_cost'] = Variable<double>(perUnitCost.value);
    }
    if (totalQuantity.present) {
      map['total_quantity'] = Variable<double>(totalQuantity.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (totalReceivedAmount.present) {
      map['total_received_amount'] =
          Variable<double>(totalReceivedAmount.value);
    }
    if (totalSendAmount.present) {
      map['total_send_amount'] = Variable<double>(totalSendAmount.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String?>(paymentStatus.value);
    }
    if (orderStatus.present) {
      map['order_status'] = Variable<String>(orderStatus.value);
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
          Variable<DateTime?>(expectedDeliveryDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelDeliveryOrderCompanion(')
          ..write('deliveryOrderId: $deliveryOrderId, ')
          ..write('clientId: $clientId, ')
          ..write('itemId: $itemId, ')
          ..write('perUnitCost: $perUnitCost, ')
          ..write('totalQuantity: $totalQuantity, ')
          ..write('totalCost: $totalCost, ')
          ..write('totalReceivedAmount: $totalReceivedAmount, ')
          ..write('totalSendAmount: $totalSendAmount, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('orderStatus: $orderStatus, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('expectedDeliveryDate: $expectedDeliveryDate')
          ..write(')'))
        .toString();
  }
}

class $ModelDeliveryOrderTable extends ModelDeliveryOrder
    with TableInfo<$ModelDeliveryOrderTable, ModelDeliveryOrderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelDeliveryOrderTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _deliveryOrderIdMeta =
      const VerificationMeta('deliveryOrderId');
  @override
  late final GeneratedColumn<int?> deliveryOrderId = GeneratedColumn<int?>(
      'delivery_order_id', aliasedName, false,
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
  final VerificationMeta _perUnitCostMeta =
      const VerificationMeta('perUnitCost');
  @override
  late final GeneratedColumn<double?> perUnitCost = GeneratedColumn<double?>(
      'per_unit_cost', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _totalQuantityMeta =
      const VerificationMeta('totalQuantity');
  @override
  late final GeneratedColumn<double?> totalQuantity = GeneratedColumn<double?>(
      'total_quantity', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _totalCostMeta = const VerificationMeta('totalCost');
  @override
  late final GeneratedColumn<double?> totalCost = GeneratedColumn<double?>(
      'total_cost', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _totalReceivedAmountMeta =
      const VerificationMeta('totalReceivedAmount');
  @override
  late final GeneratedColumn<double?> totalReceivedAmount =
      GeneratedColumn<double?>('total_received_amount', aliasedName, false,
          type: const RealType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  final VerificationMeta _totalSendAmountMeta =
      const VerificationMeta('totalSendAmount');
  @override
  late final GeneratedColumn<double?> totalSendAmount =
      GeneratedColumn<double?>('total_send_amount', aliasedName, false,
          type: const RealType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  final VerificationMeta _paymentStatusMeta =
      const VerificationMeta('paymentStatus');
  @override
  late final GeneratedColumn<String?> paymentStatus = GeneratedColumn<String?>(
      'payment_status', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _orderStatusMeta =
      const VerificationMeta('orderStatus');
  @override
  late final GeneratedColumn<String?> orderStatus = GeneratedColumn<String?>(
      'order_status', aliasedName, false,
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
      GeneratedColumn<DateTime?>('expected_delivery_date', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        deliveryOrderId,
        clientId,
        itemId,
        perUnitCost,
        totalQuantity,
        totalCost,
        totalReceivedAmount,
        totalSendAmount,
        paymentStatus,
        orderStatus,
        createdBy,
        createdAt,
        lastUpdated,
        expectedDeliveryDate
      ];
  @override
  String get aliasedName => _alias ?? 'model_delivery_order';
  @override
  String get actualTableName => 'model_delivery_order';
  @override
  VerificationContext validateIntegrity(
      Insertable<ModelDeliveryOrderData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('delivery_order_id')) {
      context.handle(
          _deliveryOrderIdMeta,
          deliveryOrderId.isAcceptableOrUnknown(
              data['delivery_order_id']!, _deliveryOrderIdMeta));
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
    if (data.containsKey('per_unit_cost')) {
      context.handle(
          _perUnitCostMeta,
          perUnitCost.isAcceptableOrUnknown(
              data['per_unit_cost']!, _perUnitCostMeta));
    } else if (isInserting) {
      context.missing(_perUnitCostMeta);
    }
    if (data.containsKey('total_quantity')) {
      context.handle(
          _totalQuantityMeta,
          totalQuantity.isAcceptableOrUnknown(
              data['total_quantity']!, _totalQuantityMeta));
    } else if (isInserting) {
      context.missing(_totalQuantityMeta);
    }
    if (data.containsKey('total_cost')) {
      context.handle(_totalCostMeta,
          totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta));
    } else if (isInserting) {
      context.missing(_totalCostMeta);
    }
    if (data.containsKey('total_received_amount')) {
      context.handle(
          _totalReceivedAmountMeta,
          totalReceivedAmount.isAcceptableOrUnknown(
              data['total_received_amount']!, _totalReceivedAmountMeta));
    }
    if (data.containsKey('total_send_amount')) {
      context.handle(
          _totalSendAmountMeta,
          totalSendAmount.isAcceptableOrUnknown(
              data['total_send_amount']!, _totalSendAmountMeta));
    }
    if (data.containsKey('payment_status')) {
      context.handle(
          _paymentStatusMeta,
          paymentStatus.isAcceptableOrUnknown(
              data['payment_status']!, _paymentStatusMeta));
    }
    if (data.containsKey('order_status')) {
      context.handle(
          _orderStatusMeta,
          orderStatus.isAcceptableOrUnknown(
              data['order_status']!, _orderStatusMeta));
    } else if (isInserting) {
      context.missing(_orderStatusMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {deliveryOrderId};
  @override
  ModelDeliveryOrderData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ModelDeliveryOrderData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelDeliveryOrderTable createAlias(String alias) {
    return $ModelDeliveryOrderTable(attachedDatabase, alias);
  }
}

class ModelTransportData extends DataClass
    implements Insertable<ModelTransportData> {
  final int transportId;
  final int orderId;
  final String deliveryStatus;
  final String deliveredBy;
  final String paymentStatus;
  final double dueAmount;
  final DateTime startedAt;
  final DateTime lastUpdated;
  final bool isValid;
  ModelTransportData(
      {required this.transportId,
      required this.orderId,
      required this.deliveryStatus,
      required this.deliveredBy,
      required this.paymentStatus,
      required this.dueAmount,
      required this.startedAt,
      required this.lastUpdated,
      required this.isValid});
  factory ModelTransportData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelTransportData(
      transportId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transport_id'])!,
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
    map['transport_id'] = Variable<int>(transportId);
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

  ModelTransportCompanion toCompanion(bool nullToAbsent) {
    return ModelTransportCompanion(
      transportId: Value(transportId),
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

  factory ModelTransportData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelTransportData(
      transportId: serializer.fromJson<int>(json['transportId']),
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
      'transportId': serializer.toJson<int>(transportId),
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

  ModelTransportData copyWith(
          {int? transportId,
          int? orderId,
          String? deliveryStatus,
          String? deliveredBy,
          String? paymentStatus,
          double? dueAmount,
          DateTime? startedAt,
          DateTime? lastUpdated,
          bool? isValid}) =>
      ModelTransportData(
        transportId: transportId ?? this.transportId,
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
    return (StringBuffer('ModelTransportData(')
          ..write('transportId: $transportId, ')
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
  int get hashCode => Object.hash(transportId, orderId, deliveryStatus,
      deliveredBy, paymentStatus, dueAmount, startedAt, lastUpdated, isValid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelTransportData &&
          other.transportId == this.transportId &&
          other.orderId == this.orderId &&
          other.deliveryStatus == this.deliveryStatus &&
          other.deliveredBy == this.deliveredBy &&
          other.paymentStatus == this.paymentStatus &&
          other.dueAmount == this.dueAmount &&
          other.startedAt == this.startedAt &&
          other.lastUpdated == this.lastUpdated &&
          other.isValid == this.isValid);
}

class ModelTransportCompanion extends UpdateCompanion<ModelTransportData> {
  final Value<int> transportId;
  final Value<int> orderId;
  final Value<String> deliveryStatus;
  final Value<String> deliveredBy;
  final Value<String> paymentStatus;
  final Value<double> dueAmount;
  final Value<DateTime> startedAt;
  final Value<DateTime> lastUpdated;
  final Value<bool> isValid;
  const ModelTransportCompanion({
    this.transportId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.deliveryStatus = const Value.absent(),
    this.deliveredBy = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.dueAmount = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isValid = const Value.absent(),
  });
  ModelTransportCompanion.insert({
    this.transportId = const Value.absent(),
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
  static Insertable<ModelTransportData> custom({
    Expression<int>? transportId,
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
      if (transportId != null) 'transport_id': transportId,
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

  ModelTransportCompanion copyWith(
      {Value<int>? transportId,
      Value<int>? orderId,
      Value<String>? deliveryStatus,
      Value<String>? deliveredBy,
      Value<String>? paymentStatus,
      Value<double>? dueAmount,
      Value<DateTime>? startedAt,
      Value<DateTime>? lastUpdated,
      Value<bool>? isValid}) {
    return ModelTransportCompanion(
      transportId: transportId ?? this.transportId,
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
    if (transportId.present) {
      map['transport_id'] = Variable<int>(transportId.value);
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
    return (StringBuffer('ModelTransportCompanion(')
          ..write('transportId: $transportId, ')
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

class $ModelTransportTable extends ModelTransport
    with TableInfo<$ModelTransportTable, ModelTransportData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelTransportTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _transportIdMeta =
      const VerificationMeta('transportId');
  @override
  late final GeneratedColumn<int?> transportId = GeneratedColumn<int?>(
      'transport_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int?> orderId = GeneratedColumn<int?>(
      'order_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES model_delivery_order (delivery_order_id)');
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
        transportId,
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
  String get aliasedName => _alias ?? 'model_transport';
  @override
  String get actualTableName => 'model_transport';
  @override
  VerificationContext validateIntegrity(Insertable<ModelTransportData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('transport_id')) {
      context.handle(
          _transportIdMeta,
          transportId.isAcceptableOrUnknown(
              data['transport_id']!, _transportIdMeta));
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
  Set<GeneratedColumn> get $primaryKey => {transportId};
  @override
  ModelTransportData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ModelTransportData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelTransportTable createAlias(String alias) {
    return $ModelTransportTable(attachedDatabase, alias);
  }
}

class ModelReturnOrderData extends DataClass
    implements Insertable<ModelReturnOrderData> {
  final int returnOrderId;
  final int orderId;
  final String returnStatus;
  final String paymentStatus;
  final double dueAmount;
  final String returnedBy;
  final DateTime startedAt;
  final DateTime lastUpdated;
  final bool isValid;
  ModelReturnOrderData(
      {required this.returnOrderId,
      required this.orderId,
      required this.returnStatus,
      required this.paymentStatus,
      required this.dueAmount,
      required this.returnedBy,
      required this.startedAt,
      required this.lastUpdated,
      required this.isValid});
  factory ModelReturnOrderData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelReturnOrderData(
      returnOrderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}return_order_id'])!,
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
    map['return_order_id'] = Variable<int>(returnOrderId);
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

  ModelReturnOrderCompanion toCompanion(bool nullToAbsent) {
    return ModelReturnOrderCompanion(
      returnOrderId: Value(returnOrderId),
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

  factory ModelReturnOrderData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelReturnOrderData(
      returnOrderId: serializer.fromJson<int>(json['returnOrderId']),
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
      'returnOrderId': serializer.toJson<int>(returnOrderId),
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

  ModelReturnOrderData copyWith(
          {int? returnOrderId,
          int? orderId,
          String? returnStatus,
          String? paymentStatus,
          double? dueAmount,
          String? returnedBy,
          DateTime? startedAt,
          DateTime? lastUpdated,
          bool? isValid}) =>
      ModelReturnOrderData(
        returnOrderId: returnOrderId ?? this.returnOrderId,
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
    return (StringBuffer('ModelReturnOrderData(')
          ..write('returnOrderId: $returnOrderId, ')
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
  int get hashCode => Object.hash(returnOrderId, orderId, returnStatus,
      paymentStatus, dueAmount, returnedBy, startedAt, lastUpdated, isValid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelReturnOrderData &&
          other.returnOrderId == this.returnOrderId &&
          other.orderId == this.orderId &&
          other.returnStatus == this.returnStatus &&
          other.paymentStatus == this.paymentStatus &&
          other.dueAmount == this.dueAmount &&
          other.returnedBy == this.returnedBy &&
          other.startedAt == this.startedAt &&
          other.lastUpdated == this.lastUpdated &&
          other.isValid == this.isValid);
}

class ModelReturnOrderCompanion extends UpdateCompanion<ModelReturnOrderData> {
  final Value<int> returnOrderId;
  final Value<int> orderId;
  final Value<String> returnStatus;
  final Value<String> paymentStatus;
  final Value<double> dueAmount;
  final Value<String> returnedBy;
  final Value<DateTime> startedAt;
  final Value<DateTime> lastUpdated;
  final Value<bool> isValid;
  const ModelReturnOrderCompanion({
    this.returnOrderId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.returnStatus = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.dueAmount = const Value.absent(),
    this.returnedBy = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isValid = const Value.absent(),
  });
  ModelReturnOrderCompanion.insert({
    this.returnOrderId = const Value.absent(),
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
  static Insertable<ModelReturnOrderData> custom({
    Expression<int>? returnOrderId,
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
      if (returnOrderId != null) 'return_order_id': returnOrderId,
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

  ModelReturnOrderCompanion copyWith(
      {Value<int>? returnOrderId,
      Value<int>? orderId,
      Value<String>? returnStatus,
      Value<String>? paymentStatus,
      Value<double>? dueAmount,
      Value<String>? returnedBy,
      Value<DateTime>? startedAt,
      Value<DateTime>? lastUpdated,
      Value<bool>? isValid}) {
    return ModelReturnOrderCompanion(
      returnOrderId: returnOrderId ?? this.returnOrderId,
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
    if (returnOrderId.present) {
      map['return_order_id'] = Variable<int>(returnOrderId.value);
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
    return (StringBuffer('ModelReturnOrderCompanion(')
          ..write('returnOrderId: $returnOrderId, ')
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

class $ModelReturnOrderTable extends ModelReturnOrder
    with TableInfo<$ModelReturnOrderTable, ModelReturnOrderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelReturnOrderTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _returnOrderIdMeta =
      const VerificationMeta('returnOrderId');
  @override
  late final GeneratedColumn<int?> returnOrderId = GeneratedColumn<int?>(
      'return_order_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _orderIdMeta = const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int?> orderId = GeneratedColumn<int?>(
      'order_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints:
          'REFERENCES model_delivery_order (delivery_order_id)');
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
        returnOrderId,
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
  String get aliasedName => _alias ?? 'model_return_order';
  @override
  String get actualTableName => 'model_return_order';
  @override
  VerificationContext validateIntegrity(
      Insertable<ModelReturnOrderData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('return_order_id')) {
      context.handle(
          _returnOrderIdMeta,
          returnOrderId.isAcceptableOrUnknown(
              data['return_order_id']!, _returnOrderIdMeta));
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
  Set<GeneratedColumn> get $primaryKey => {returnOrderId};
  @override
  ModelReturnOrderData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ModelReturnOrderData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelReturnOrderTable createAlias(String alias) {
    return $ModelReturnOrderTable(attachedDatabase, alias);
  }
}

class ModelPaymentData extends DataClass
    implements Insertable<ModelPaymentData> {
  final int paymentId;
  final int? deliveryOrderId;
  final int? returnOrderId;
  final double amount;
  final String paymentMode;
  final String paymentType;
  final String? paymentNote;
  final String receivedBy;
  final DateTime paymentDate;
  final DateTime createdAt;
  ModelPaymentData(
      {required this.paymentId,
      this.deliveryOrderId,
      this.returnOrderId,
      required this.amount,
      required this.paymentMode,
      required this.paymentType,
      this.paymentNote,
      required this.receivedBy,
      required this.paymentDate,
      required this.createdAt});
  factory ModelPaymentData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelPaymentData(
      paymentId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_id'])!,
      deliveryOrderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}delivery_order_id']),
      returnOrderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}return_order_id']),
      amount: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}amount'])!,
      paymentMode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_mode'])!,
      paymentType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_type'])!,
      paymentNote: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_note']),
      receivedBy: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}received_by'])!,
      paymentDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_date'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['payment_id'] = Variable<int>(paymentId);
    if (!nullToAbsent || deliveryOrderId != null) {
      map['delivery_order_id'] = Variable<int?>(deliveryOrderId);
    }
    if (!nullToAbsent || returnOrderId != null) {
      map['return_order_id'] = Variable<int?>(returnOrderId);
    }
    map['amount'] = Variable<double>(amount);
    map['payment_mode'] = Variable<String>(paymentMode);
    map['payment_type'] = Variable<String>(paymentType);
    if (!nullToAbsent || paymentNote != null) {
      map['payment_note'] = Variable<String?>(paymentNote);
    }
    map['received_by'] = Variable<String>(receivedBy);
    map['payment_date'] = Variable<DateTime>(paymentDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ModelPaymentCompanion toCompanion(bool nullToAbsent) {
    return ModelPaymentCompanion(
      paymentId: Value(paymentId),
      deliveryOrderId: deliveryOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryOrderId),
      returnOrderId: returnOrderId == null && nullToAbsent
          ? const Value.absent()
          : Value(returnOrderId),
      amount: Value(amount),
      paymentMode: Value(paymentMode),
      paymentType: Value(paymentType),
      paymentNote: paymentNote == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentNote),
      receivedBy: Value(receivedBy),
      paymentDate: Value(paymentDate),
      createdAt: Value(createdAt),
    );
  }

  factory ModelPaymentData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelPaymentData(
      paymentId: serializer.fromJson<int>(json['paymentId']),
      deliveryOrderId: serializer.fromJson<int?>(json['deliveryOrderId']),
      returnOrderId: serializer.fromJson<int?>(json['returnOrderId']),
      amount: serializer.fromJson<double>(json['amount']),
      paymentMode: serializer.fromJson<String>(json['paymentMode']),
      paymentType: serializer.fromJson<String>(json['paymentType']),
      paymentNote: serializer.fromJson<String?>(json['paymentNote']),
      receivedBy: serializer.fromJson<String>(json['receivedBy']),
      paymentDate: serializer.fromJson<DateTime>(json['paymentDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'paymentId': serializer.toJson<int>(paymentId),
      'deliveryOrderId': serializer.toJson<int?>(deliveryOrderId),
      'returnOrderId': serializer.toJson<int?>(returnOrderId),
      'amount': serializer.toJson<double>(amount),
      'paymentMode': serializer.toJson<String>(paymentMode),
      'paymentType': serializer.toJson<String>(paymentType),
      'paymentNote': serializer.toJson<String?>(paymentNote),
      'receivedBy': serializer.toJson<String>(receivedBy),
      'paymentDate': serializer.toJson<DateTime>(paymentDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ModelPaymentData copyWith(
          {int? paymentId,
          int? deliveryOrderId,
          int? returnOrderId,
          double? amount,
          String? paymentMode,
          String? paymentType,
          String? paymentNote,
          String? receivedBy,
          DateTime? paymentDate,
          DateTime? createdAt}) =>
      ModelPaymentData(
        paymentId: paymentId ?? this.paymentId,
        deliveryOrderId: deliveryOrderId ?? this.deliveryOrderId,
        returnOrderId: returnOrderId ?? this.returnOrderId,
        amount: amount ?? this.amount,
        paymentMode: paymentMode ?? this.paymentMode,
        paymentType: paymentType ?? this.paymentType,
        paymentNote: paymentNote ?? this.paymentNote,
        receivedBy: receivedBy ?? this.receivedBy,
        paymentDate: paymentDate ?? this.paymentDate,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('ModelPaymentData(')
          ..write('paymentId: $paymentId, ')
          ..write('deliveryOrderId: $deliveryOrderId, ')
          ..write('returnOrderId: $returnOrderId, ')
          ..write('amount: $amount, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('paymentType: $paymentType, ')
          ..write('paymentNote: $paymentNote, ')
          ..write('receivedBy: $receivedBy, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      paymentId,
      deliveryOrderId,
      returnOrderId,
      amount,
      paymentMode,
      paymentType,
      paymentNote,
      receivedBy,
      paymentDate,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelPaymentData &&
          other.paymentId == this.paymentId &&
          other.deliveryOrderId == this.deliveryOrderId &&
          other.returnOrderId == this.returnOrderId &&
          other.amount == this.amount &&
          other.paymentMode == this.paymentMode &&
          other.paymentType == this.paymentType &&
          other.paymentNote == this.paymentNote &&
          other.receivedBy == this.receivedBy &&
          other.paymentDate == this.paymentDate &&
          other.createdAt == this.createdAt);
}

class ModelPaymentCompanion extends UpdateCompanion<ModelPaymentData> {
  final Value<int> paymentId;
  final Value<int?> deliveryOrderId;
  final Value<int?> returnOrderId;
  final Value<double> amount;
  final Value<String> paymentMode;
  final Value<String> paymentType;
  final Value<String?> paymentNote;
  final Value<String> receivedBy;
  final Value<DateTime> paymentDate;
  final Value<DateTime> createdAt;
  const ModelPaymentCompanion({
    this.paymentId = const Value.absent(),
    this.deliveryOrderId = const Value.absent(),
    this.returnOrderId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.paymentType = const Value.absent(),
    this.paymentNote = const Value.absent(),
    this.receivedBy = const Value.absent(),
    this.paymentDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ModelPaymentCompanion.insert({
    this.paymentId = const Value.absent(),
    this.deliveryOrderId = const Value.absent(),
    this.returnOrderId = const Value.absent(),
    required double amount,
    required String paymentMode,
    required String paymentType,
    this.paymentNote = const Value.absent(),
    required String receivedBy,
    required DateTime paymentDate,
    this.createdAt = const Value.absent(),
  })  : amount = Value(amount),
        paymentMode = Value(paymentMode),
        paymentType = Value(paymentType),
        receivedBy = Value(receivedBy),
        paymentDate = Value(paymentDate);
  static Insertable<ModelPaymentData> custom({
    Expression<int>? paymentId,
    Expression<int?>? deliveryOrderId,
    Expression<int?>? returnOrderId,
    Expression<double>? amount,
    Expression<String>? paymentMode,
    Expression<String>? paymentType,
    Expression<String?>? paymentNote,
    Expression<String>? receivedBy,
    Expression<DateTime>? paymentDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (paymentId != null) 'payment_id': paymentId,
      if (deliveryOrderId != null) 'delivery_order_id': deliveryOrderId,
      if (returnOrderId != null) 'return_order_id': returnOrderId,
      if (amount != null) 'amount': amount,
      if (paymentMode != null) 'payment_mode': paymentMode,
      if (paymentType != null) 'payment_type': paymentType,
      if (paymentNote != null) 'payment_note': paymentNote,
      if (receivedBy != null) 'received_by': receivedBy,
      if (paymentDate != null) 'payment_date': paymentDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ModelPaymentCompanion copyWith(
      {Value<int>? paymentId,
      Value<int?>? deliveryOrderId,
      Value<int?>? returnOrderId,
      Value<double>? amount,
      Value<String>? paymentMode,
      Value<String>? paymentType,
      Value<String?>? paymentNote,
      Value<String>? receivedBy,
      Value<DateTime>? paymentDate,
      Value<DateTime>? createdAt}) {
    return ModelPaymentCompanion(
      paymentId: paymentId ?? this.paymentId,
      deliveryOrderId: deliveryOrderId ?? this.deliveryOrderId,
      returnOrderId: returnOrderId ?? this.returnOrderId,
      amount: amount ?? this.amount,
      paymentMode: paymentMode ?? this.paymentMode,
      paymentType: paymentType ?? this.paymentType,
      paymentNote: paymentNote ?? this.paymentNote,
      receivedBy: receivedBy ?? this.receivedBy,
      paymentDate: paymentDate ?? this.paymentDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (paymentId.present) {
      map['payment_id'] = Variable<int>(paymentId.value);
    }
    if (deliveryOrderId.present) {
      map['delivery_order_id'] = Variable<int?>(deliveryOrderId.value);
    }
    if (returnOrderId.present) {
      map['return_order_id'] = Variable<int?>(returnOrderId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paymentMode.present) {
      map['payment_mode'] = Variable<String>(paymentMode.value);
    }
    if (paymentType.present) {
      map['payment_type'] = Variable<String>(paymentType.value);
    }
    if (paymentNote.present) {
      map['payment_note'] = Variable<String?>(paymentNote.value);
    }
    if (receivedBy.present) {
      map['received_by'] = Variable<String>(receivedBy.value);
    }
    if (paymentDate.present) {
      map['payment_date'] = Variable<DateTime>(paymentDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelPaymentCompanion(')
          ..write('paymentId: $paymentId, ')
          ..write('deliveryOrderId: $deliveryOrderId, ')
          ..write('returnOrderId: $returnOrderId, ')
          ..write('amount: $amount, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('paymentType: $paymentType, ')
          ..write('paymentNote: $paymentNote, ')
          ..write('receivedBy: $receivedBy, ')
          ..write('paymentDate: $paymentDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ModelPaymentTable extends ModelPayment
    with TableInfo<$ModelPaymentTable, ModelPaymentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelPaymentTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _paymentIdMeta = const VerificationMeta('paymentId');
  @override
  late final GeneratedColumn<int?> paymentId = GeneratedColumn<int?>(
      'payment_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _deliveryOrderIdMeta =
      const VerificationMeta('deliveryOrderId');
  @override
  late final GeneratedColumn<int?> deliveryOrderId = GeneratedColumn<int?>(
      'delivery_order_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints:
          'REFERENCES model_delivery_order (delivery_order_id)');
  final VerificationMeta _returnOrderIdMeta =
      const VerificationMeta('returnOrderId');
  @override
  late final GeneratedColumn<int?> returnOrderId = GeneratedColumn<int?>(
      'return_order_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
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
  final VerificationMeta _paymentTypeMeta =
      const VerificationMeta('paymentType');
  @override
  late final GeneratedColumn<String?> paymentType = GeneratedColumn<String?>(
      'payment_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _paymentNoteMeta =
      const VerificationMeta('paymentNote');
  @override
  late final GeneratedColumn<String?> paymentNote = GeneratedColumn<String?>(
      'payment_note', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _receivedByMeta = const VerificationMeta('receivedBy');
  @override
  late final GeneratedColumn<String?> receivedBy = GeneratedColumn<String?>(
      'received_by', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _paymentDateMeta =
      const VerificationMeta('paymentDate');
  @override
  late final GeneratedColumn<DateTime?> paymentDate =
      GeneratedColumn<DateTime?>('payment_date', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now()));
  @override
  List<GeneratedColumn> get $columns => [
        paymentId,
        deliveryOrderId,
        returnOrderId,
        amount,
        paymentMode,
        paymentType,
        paymentNote,
        receivedBy,
        paymentDate,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? 'model_payment';
  @override
  String get actualTableName => 'model_payment';
  @override
  VerificationContext validateIntegrity(Insertable<ModelPaymentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('payment_id')) {
      context.handle(_paymentIdMeta,
          paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta));
    }
    if (data.containsKey('delivery_order_id')) {
      context.handle(
          _deliveryOrderIdMeta,
          deliveryOrderId.isAcceptableOrUnknown(
              data['delivery_order_id']!, _deliveryOrderIdMeta));
    }
    if (data.containsKey('return_order_id')) {
      context.handle(
          _returnOrderIdMeta,
          returnOrderId.isAcceptableOrUnknown(
              data['return_order_id']!, _returnOrderIdMeta));
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
    if (data.containsKey('payment_type')) {
      context.handle(
          _paymentTypeMeta,
          paymentType.isAcceptableOrUnknown(
              data['payment_type']!, _paymentTypeMeta));
    } else if (isInserting) {
      context.missing(_paymentTypeMeta);
    }
    if (data.containsKey('payment_note')) {
      context.handle(
          _paymentNoteMeta,
          paymentNote.isAcceptableOrUnknown(
              data['payment_note']!, _paymentNoteMeta));
    }
    if (data.containsKey('received_by')) {
      context.handle(
          _receivedByMeta,
          receivedBy.isAcceptableOrUnknown(
              data['received_by']!, _receivedByMeta));
    } else if (isInserting) {
      context.missing(_receivedByMeta);
    }
    if (data.containsKey('payment_date')) {
      context.handle(
          _paymentDateMeta,
          paymentDate.isAcceptableOrUnknown(
              data['payment_date']!, _paymentDateMeta));
    } else if (isInserting) {
      context.missing(_paymentDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {paymentId};
  @override
  ModelPaymentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ModelPaymentData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelPaymentTable createAlias(String alias) {
    return $ModelPaymentTable(attachedDatabase, alias);
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
  late final $ModelDeliveryOrderTable modelDeliveryOrder =
      $ModelDeliveryOrderTable(this);
  late final $ModelTransportTable modelTransport = $ModelTransportTable(this);
  late final $ModelReturnOrderTable modelReturnOrder =
      $ModelReturnOrderTable(this);
  late final $ModelPaymentTable modelPayment = $ModelPaymentTable(this);
  late final $ModelSurveyTable modelSurvey = $ModelSurveyTable(this);
  late final ClientTableQueries clientTableQueries =
      ClientTableQueries(this as AppDatabase);
  late final ItemTableQueries itemTableQueries =
      ItemTableQueries(this as AppDatabase);
  late final DeliveryOrderTableQueries deliveryOrderTableQueries =
      DeliveryOrderTableQueries(this as AppDatabase);
  late final TransportTableQueries transportTableQueries =
      TransportTableQueries(this as AppDatabase);
  late final ReturnOrderTableQueries returnOrderTableQueries =
      ReturnOrderTableQueries(this as AppDatabase);
  late final PaymentTableQueries paymentTableQueries =
      PaymentTableQueries(this as AppDatabase);
  late final SurveyTableQueries surveyTableQueries =
      SurveyTableQueries(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        modelClient,
        modelItem,
        modelDeliveryOrder,
        modelTransport,
        modelReturnOrder,
        modelPayment,
        modelSurvey
      ];
}
