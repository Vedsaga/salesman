// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryOrderList _$DeliveryOrderListFromJson(Map<String, dynamic> json) =>
    DeliveryOrderList(
      deliveryList: (json['deliveryList'] as List<dynamic>)
          .map((e) => OrderMap.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeliveryOrderListToJson(DeliveryOrderList instance) =>
    <String, dynamic>{
      'deliveryList': instance.deliveryList,
    };

ReturnOrderList _$ReturnOrderListFromJson(Map<String, dynamic> json) =>
    ReturnOrderList(
      returnList: (json['returnList'] as List<dynamic>)
          .map((e) => OrderMap.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReturnOrderListToJson(ReturnOrderList instance) =>
    <String, dynamic>{
      'returnList': instance.returnList,
    };

ItemList _$ItemListFromJson(Map<String, dynamic> json) => ItemList(
      itemList: (json['itemList'] as List<dynamic>)
          .map((e) => ItemMap.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemListToJson(ItemList instance) => <String, dynamic>{
      'itemList': instance.itemList,
    };

SurveyItemList _$SurveyItemListFromJson(Map<String, dynamic> json) =>
    SurveyItemList(
      surveyItemList: (json['surveyItemList'] as List<dynamic>)
          .map((e) => SurveyItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurveyItemListToJson(SurveyItemList instance) =>
    <String, dynamic>{
      'surveyItemList': instance.surveyItemList,
    };

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ModelClientData extends DataClass implements Insertable<ModelClientData> {
  final int clientId;
  final String clientName;
  final String clientPhone;
  final double totalAmountReceived;
  final double totalAmountSent;
  final double pendingDue;
  final double pendingRefund;
  final int noOfPendingOrder;
  final bool isActive;
  final DateTime? lastTradeOn;
  final DateTime? lastPaymentOn;
  final DateTime? lastUpdatedOn;
  ModelClientData(
      {required this.clientId,
      required this.clientName,
      required this.clientPhone,
      required this.totalAmountReceived,
      required this.totalAmountSent,
      required this.pendingDue,
      required this.pendingRefund,
      required this.noOfPendingOrder,
      required this.isActive,
      this.lastTradeOn,
      this.lastPaymentOn,
      this.lastUpdatedOn});
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
      totalAmountReceived: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}total_amount_received'])!,
      totalAmountSent: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}total_amount_sent'])!,
      pendingDue: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pending_due'])!,
      pendingRefund: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}pending_refund'])!,
      noOfPendingOrder: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}no_of_pending_order'])!,
      isActive: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_active'])!,
      lastTradeOn: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_trade_on']),
      lastPaymentOn: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_payment_on']),
      lastUpdatedOn: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated_on']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_id'] = Variable<int>(clientId);
    map['client_name'] = Variable<String>(clientName);
    map['client_phone'] = Variable<String>(clientPhone);
    map['total_amount_received'] = Variable<double>(totalAmountReceived);
    map['total_amount_sent'] = Variable<double>(totalAmountSent);
    map['pending_due'] = Variable<double>(pendingDue);
    map['pending_refund'] = Variable<double>(pendingRefund);
    map['no_of_pending_order'] = Variable<int>(noOfPendingOrder);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastTradeOn != null) {
      map['last_trade_on'] = Variable<DateTime?>(lastTradeOn);
    }
    if (!nullToAbsent || lastPaymentOn != null) {
      map['last_payment_on'] = Variable<DateTime?>(lastPaymentOn);
    }
    if (!nullToAbsent || lastUpdatedOn != null) {
      map['last_updated_on'] = Variable<DateTime?>(lastUpdatedOn);
    }
    return map;
  }

  ModelClientCompanion toCompanion(bool nullToAbsent) {
    return ModelClientCompanion(
      clientId: Value(clientId),
      clientName: Value(clientName),
      clientPhone: Value(clientPhone),
      totalAmountReceived: Value(totalAmountReceived),
      totalAmountSent: Value(totalAmountSent),
      pendingDue: Value(pendingDue),
      pendingRefund: Value(pendingRefund),
      noOfPendingOrder: Value(noOfPendingOrder),
      isActive: Value(isActive),
      lastTradeOn: lastTradeOn == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTradeOn),
      lastPaymentOn: lastPaymentOn == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPaymentOn),
      lastUpdatedOn: lastUpdatedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdatedOn),
    );
  }

  factory ModelClientData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelClientData(
      clientId: serializer.fromJson<int>(json['clientId']),
      clientName: serializer.fromJson<String>(json['clientName']),
      clientPhone: serializer.fromJson<String>(json['clientPhone']),
      totalAmountReceived:
          serializer.fromJson<double>(json['totalAmountReceived']),
      totalAmountSent: serializer.fromJson<double>(json['totalAmountSent']),
      pendingDue: serializer.fromJson<double>(json['pendingDue']),
      pendingRefund: serializer.fromJson<double>(json['pendingRefund']),
      noOfPendingOrder: serializer.fromJson<int>(json['noOfPendingOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastTradeOn: serializer.fromJson<DateTime?>(json['lastTradeOn']),
      lastPaymentOn: serializer.fromJson<DateTime?>(json['lastPaymentOn']),
      lastUpdatedOn: serializer.fromJson<DateTime?>(json['lastUpdatedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientId': serializer.toJson<int>(clientId),
      'clientName': serializer.toJson<String>(clientName),
      'clientPhone': serializer.toJson<String>(clientPhone),
      'totalAmountReceived': serializer.toJson<double>(totalAmountReceived),
      'totalAmountSent': serializer.toJson<double>(totalAmountSent),
      'pendingDue': serializer.toJson<double>(pendingDue),
      'pendingRefund': serializer.toJson<double>(pendingRefund),
      'noOfPendingOrder': serializer.toJson<int>(noOfPendingOrder),
      'isActive': serializer.toJson<bool>(isActive),
      'lastTradeOn': serializer.toJson<DateTime?>(lastTradeOn),
      'lastPaymentOn': serializer.toJson<DateTime?>(lastPaymentOn),
      'lastUpdatedOn': serializer.toJson<DateTime?>(lastUpdatedOn),
    };
  }

  ModelClientData copyWith(
          {int? clientId,
          String? clientName,
          String? clientPhone,
          double? totalAmountReceived,
          double? totalAmountSent,
          double? pendingDue,
          double? pendingRefund,
          int? noOfPendingOrder,
          bool? isActive,
          DateTime? lastTradeOn,
          DateTime? lastPaymentOn,
          DateTime? lastUpdatedOn}) =>
      ModelClientData(
        clientId: clientId ?? this.clientId,
        clientName: clientName ?? this.clientName,
        clientPhone: clientPhone ?? this.clientPhone,
        totalAmountReceived: totalAmountReceived ?? this.totalAmountReceived,
        totalAmountSent: totalAmountSent ?? this.totalAmountSent,
        pendingDue: pendingDue ?? this.pendingDue,
        pendingRefund: pendingRefund ?? this.pendingRefund,
        noOfPendingOrder: noOfPendingOrder ?? this.noOfPendingOrder,
        isActive: isActive ?? this.isActive,
        lastTradeOn: lastTradeOn ?? this.lastTradeOn,
        lastPaymentOn: lastPaymentOn ?? this.lastPaymentOn,
        lastUpdatedOn: lastUpdatedOn ?? this.lastUpdatedOn,
      );
  @override
  String toString() {
    return (StringBuffer('ModelClientData(')
          ..write('clientId: $clientId, ')
          ..write('clientName: $clientName, ')
          ..write('clientPhone: $clientPhone, ')
          ..write('totalAmountReceived: $totalAmountReceived, ')
          ..write('totalAmountSent: $totalAmountSent, ')
          ..write('pendingDue: $pendingDue, ')
          ..write('pendingRefund: $pendingRefund, ')
          ..write('noOfPendingOrder: $noOfPendingOrder, ')
          ..write('isActive: $isActive, ')
          ..write('lastTradeOn: $lastTradeOn, ')
          ..write('lastPaymentOn: $lastPaymentOn, ')
          ..write('lastUpdatedOn: $lastUpdatedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      clientId,
      clientName,
      clientPhone,
      totalAmountReceived,
      totalAmountSent,
      pendingDue,
      pendingRefund,
      noOfPendingOrder,
      isActive,
      lastTradeOn,
      lastPaymentOn,
      lastUpdatedOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelClientData &&
          other.clientId == this.clientId &&
          other.clientName == this.clientName &&
          other.clientPhone == this.clientPhone &&
          other.totalAmountReceived == this.totalAmountReceived &&
          other.totalAmountSent == this.totalAmountSent &&
          other.pendingDue == this.pendingDue &&
          other.pendingRefund == this.pendingRefund &&
          other.noOfPendingOrder == this.noOfPendingOrder &&
          other.isActive == this.isActive &&
          other.lastTradeOn == this.lastTradeOn &&
          other.lastPaymentOn == this.lastPaymentOn &&
          other.lastUpdatedOn == this.lastUpdatedOn);
}

class ModelClientCompanion extends UpdateCompanion<ModelClientData> {
  final Value<int> clientId;
  final Value<String> clientName;
  final Value<String> clientPhone;
  final Value<double> totalAmountReceived;
  final Value<double> totalAmountSent;
  final Value<double> pendingDue;
  final Value<double> pendingRefund;
  final Value<int> noOfPendingOrder;
  final Value<bool> isActive;
  final Value<DateTime?> lastTradeOn;
  final Value<DateTime?> lastPaymentOn;
  final Value<DateTime?> lastUpdatedOn;
  const ModelClientCompanion({
    this.clientId = const Value.absent(),
    this.clientName = const Value.absent(),
    this.clientPhone = const Value.absent(),
    this.totalAmountReceived = const Value.absent(),
    this.totalAmountSent = const Value.absent(),
    this.pendingDue = const Value.absent(),
    this.pendingRefund = const Value.absent(),
    this.noOfPendingOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastTradeOn = const Value.absent(),
    this.lastPaymentOn = const Value.absent(),
    this.lastUpdatedOn = const Value.absent(),
  });
  ModelClientCompanion.insert({
    this.clientId = const Value.absent(),
    required String clientName,
    required String clientPhone,
    this.totalAmountReceived = const Value.absent(),
    this.totalAmountSent = const Value.absent(),
    this.pendingDue = const Value.absent(),
    this.pendingRefund = const Value.absent(),
    this.noOfPendingOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastTradeOn = const Value.absent(),
    this.lastPaymentOn = const Value.absent(),
    this.lastUpdatedOn = const Value.absent(),
  })  : clientName = Value(clientName),
        clientPhone = Value(clientPhone);
  static Insertable<ModelClientData> custom({
    Expression<int>? clientId,
    Expression<String>? clientName,
    Expression<String>? clientPhone,
    Expression<double>? totalAmountReceived,
    Expression<double>? totalAmountSent,
    Expression<double>? pendingDue,
    Expression<double>? pendingRefund,
    Expression<int>? noOfPendingOrder,
    Expression<bool>? isActive,
    Expression<DateTime?>? lastTradeOn,
    Expression<DateTime?>? lastPaymentOn,
    Expression<DateTime?>? lastUpdatedOn,
  }) {
    return RawValuesInsertable({
      if (clientId != null) 'client_id': clientId,
      if (clientName != null) 'client_name': clientName,
      if (clientPhone != null) 'client_phone': clientPhone,
      if (totalAmountReceived != null)
        'total_amount_received': totalAmountReceived,
      if (totalAmountSent != null) 'total_amount_sent': totalAmountSent,
      if (pendingDue != null) 'pending_due': pendingDue,
      if (pendingRefund != null) 'pending_refund': pendingRefund,
      if (noOfPendingOrder != null) 'no_of_pending_order': noOfPendingOrder,
      if (isActive != null) 'is_active': isActive,
      if (lastTradeOn != null) 'last_trade_on': lastTradeOn,
      if (lastPaymentOn != null) 'last_payment_on': lastPaymentOn,
      if (lastUpdatedOn != null) 'last_updated_on': lastUpdatedOn,
    });
  }

  ModelClientCompanion copyWith(
      {Value<int>? clientId,
      Value<String>? clientName,
      Value<String>? clientPhone,
      Value<double>? totalAmountReceived,
      Value<double>? totalAmountSent,
      Value<double>? pendingDue,
      Value<double>? pendingRefund,
      Value<int>? noOfPendingOrder,
      Value<bool>? isActive,
      Value<DateTime?>? lastTradeOn,
      Value<DateTime?>? lastPaymentOn,
      Value<DateTime?>? lastUpdatedOn}) {
    return ModelClientCompanion(
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientPhone: clientPhone ?? this.clientPhone,
      totalAmountReceived: totalAmountReceived ?? this.totalAmountReceived,
      totalAmountSent: totalAmountSent ?? this.totalAmountSent,
      pendingDue: pendingDue ?? this.pendingDue,
      pendingRefund: pendingRefund ?? this.pendingRefund,
      noOfPendingOrder: noOfPendingOrder ?? this.noOfPendingOrder,
      isActive: isActive ?? this.isActive,
      lastTradeOn: lastTradeOn ?? this.lastTradeOn,
      lastPaymentOn: lastPaymentOn ?? this.lastPaymentOn,
      lastUpdatedOn: lastUpdatedOn ?? this.lastUpdatedOn,
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
    if (totalAmountReceived.present) {
      map['total_amount_received'] =
          Variable<double>(totalAmountReceived.value);
    }
    if (totalAmountSent.present) {
      map['total_amount_sent'] = Variable<double>(totalAmountSent.value);
    }
    if (pendingDue.present) {
      map['pending_due'] = Variable<double>(pendingDue.value);
    }
    if (pendingRefund.present) {
      map['pending_refund'] = Variable<double>(pendingRefund.value);
    }
    if (noOfPendingOrder.present) {
      map['no_of_pending_order'] = Variable<int>(noOfPendingOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastTradeOn.present) {
      map['last_trade_on'] = Variable<DateTime?>(lastTradeOn.value);
    }
    if (lastPaymentOn.present) {
      map['last_payment_on'] = Variable<DateTime?>(lastPaymentOn.value);
    }
    if (lastUpdatedOn.present) {
      map['last_updated_on'] = Variable<DateTime?>(lastUpdatedOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelClientCompanion(')
          ..write('clientId: $clientId, ')
          ..write('clientName: $clientName, ')
          ..write('clientPhone: $clientPhone, ')
          ..write('totalAmountReceived: $totalAmountReceived, ')
          ..write('totalAmountSent: $totalAmountSent, ')
          ..write('pendingDue: $pendingDue, ')
          ..write('pendingRefund: $pendingRefund, ')
          ..write('noOfPendingOrder: $noOfPendingOrder, ')
          ..write('isActive: $isActive, ')
          ..write('lastTradeOn: $lastTradeOn, ')
          ..write('lastPaymentOn: $lastPaymentOn, ')
          ..write('lastUpdatedOn: $lastUpdatedOn')
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
  final VerificationMeta _totalAmountReceivedMeta =
      const VerificationMeta('totalAmountReceived');
  @override
  late final GeneratedColumn<double?> totalAmountReceived =
      GeneratedColumn<double?>('total_amount_received', aliasedName, false,
          type: const RealType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  final VerificationMeta _totalAmountSentMeta =
      const VerificationMeta('totalAmountSent');
  @override
  late final GeneratedColumn<double?> totalAmountSent =
      GeneratedColumn<double?>('total_amount_sent', aliasedName, false,
          type: const RealType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  final VerificationMeta _pendingDueMeta = const VerificationMeta('pendingDue');
  @override
  late final GeneratedColumn<double?> pendingDue = GeneratedColumn<double?>(
      'pending_due', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  final VerificationMeta _pendingRefundMeta =
      const VerificationMeta('pendingRefund');
  @override
  late final GeneratedColumn<double?> pendingRefund = GeneratedColumn<double?>(
      'pending_refund', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  final VerificationMeta _noOfPendingOrderMeta =
      const VerificationMeta('noOfPendingOrder');
  @override
  late final GeneratedColumn<int?> noOfPendingOrder = GeneratedColumn<int?>(
      'no_of_pending_order', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
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
  final VerificationMeta _lastPaymentOnMeta =
      const VerificationMeta('lastPaymentOn');
  @override
  late final GeneratedColumn<DateTime?> lastPaymentOn =
      GeneratedColumn<DateTime?>('last_payment_on', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _lastUpdatedOnMeta =
      const VerificationMeta('lastUpdatedOn');
  @override
  late final GeneratedColumn<DateTime?> lastUpdatedOn =
      GeneratedColumn<DateTime?>('last_updated_on', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        clientId,
        clientName,
        clientPhone,
        totalAmountReceived,
        totalAmountSent,
        pendingDue,
        pendingRefund,
        noOfPendingOrder,
        isActive,
        lastTradeOn,
        lastPaymentOn,
        lastUpdatedOn
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
    if (data.containsKey('total_amount_received')) {
      context.handle(
          _totalAmountReceivedMeta,
          totalAmountReceived.isAcceptableOrUnknown(
              data['total_amount_received']!, _totalAmountReceivedMeta));
    }
    if (data.containsKey('total_amount_sent')) {
      context.handle(
          _totalAmountSentMeta,
          totalAmountSent.isAcceptableOrUnknown(
              data['total_amount_sent']!, _totalAmountSentMeta));
    }
    if (data.containsKey('pending_due')) {
      context.handle(
          _pendingDueMeta,
          pendingDue.isAcceptableOrUnknown(
              data['pending_due']!, _pendingDueMeta));
    }
    if (data.containsKey('pending_refund')) {
      context.handle(
          _pendingRefundMeta,
          pendingRefund.isAcceptableOrUnknown(
              data['pending_refund']!, _pendingRefundMeta));
    }
    if (data.containsKey('no_of_pending_order')) {
      context.handle(
          _noOfPendingOrderMeta,
          noOfPendingOrder.isAcceptableOrUnknown(
              data['no_of_pending_order']!, _noOfPendingOrderMeta));
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
    if (data.containsKey('last_payment_on')) {
      context.handle(
          _lastPaymentOnMeta,
          lastPaymentOn.isAcceptableOrUnknown(
              data['last_payment_on']!, _lastPaymentOnMeta));
    }
    if (data.containsKey('last_updated_on')) {
      context.handle(
          _lastUpdatedOnMeta,
          lastUpdatedOn.isAcceptableOrUnknown(
              data['last_updated_on']!, _lastUpdatedOnMeta));
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
  final double minStockAlert;
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
      required this.minStockAlert,
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
      minStockAlert: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}min_stock_alert'])!,
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
    map['min_stock_alert'] = Variable<double>(minStockAlert);
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
      minStockAlert: Value(minStockAlert),
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
      minStockAlert: serializer.fromJson<double>(json['minStockAlert']),
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
      'minStockAlert': serializer.toJson<double>(minStockAlert),
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
          double? minStockAlert,
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
        minStockAlert: minStockAlert ?? this.minStockAlert,
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
          ..write('minStockAlert: $minStockAlert, ')
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
      minStockAlert,
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
          other.minStockAlert == this.minStockAlert &&
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
  final Value<double> minStockAlert;
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
    this.minStockAlert = const Value.absent(),
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
    this.minStockAlert = const Value.absent(),
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
    Expression<double>? minStockAlert,
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
      if (minStockAlert != null) 'min_stock_alert': minStockAlert,
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
      Value<double>? minStockAlert,
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
      minStockAlert: minStockAlert ?? this.minStockAlert,
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
    if (minStockAlert.present) {
      map['min_stock_alert'] = Variable<double>(minStockAlert.value);
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
          ..write('minStockAlert: $minStockAlert, ')
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
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
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
  final VerificationMeta _minStockAlertMeta =
      const VerificationMeta('minStockAlert');
  @override
  late final GeneratedColumn<double?> minStockAlert = GeneratedColumn<double?>(
      'min_stock_alert', aliasedName, false,
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
        minStockAlert,
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
    if (data.containsKey('min_stock_alert')) {
      context.handle(
          _minStockAlertMeta,
          minStockAlert.isAcceptableOrUnknown(
              data['min_stock_alert']!, _minStockAlertMeta));
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

class ModelVehicleData extends DataClass
    implements Insertable<ModelVehicleData> {
  final int vehicleId;
  final String vehicleName;
  final String vehicleType;
  final String vehicleNumber;
  final String vehicleFuelType;
  final String vehicleStatus;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final bool isActive;
  ModelVehicleData(
      {required this.vehicleId,
      required this.vehicleName,
      required this.vehicleType,
      required this.vehicleNumber,
      required this.vehicleFuelType,
      required this.vehicleStatus,
      required this.createdAt,
      required this.lastUpdated,
      required this.isActive});
  factory ModelVehicleData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelVehicleData(
      vehicleId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vehicle_id'])!,
      vehicleName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vehicle_name'])!,
      vehicleType: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vehicle_type'])!,
      vehicleNumber: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vehicle_number'])!,
      vehicleFuelType: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}vehicle_fuel_type'])!,
      vehicleStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vehicle_status'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      lastUpdated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated'])!,
      isActive: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_active'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['vehicle_name'] = Variable<String>(vehicleName);
    map['vehicle_type'] = Variable<String>(vehicleType);
    map['vehicle_number'] = Variable<String>(vehicleNumber);
    map['vehicle_fuel_type'] = Variable<String>(vehicleFuelType);
    map['vehicle_status'] = Variable<String>(vehicleStatus);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  ModelVehicleCompanion toCompanion(bool nullToAbsent) {
    return ModelVehicleCompanion(
      vehicleId: Value(vehicleId),
      vehicleName: Value(vehicleName),
      vehicleType: Value(vehicleType),
      vehicleNumber: Value(vehicleNumber),
      vehicleFuelType: Value(vehicleFuelType),
      vehicleStatus: Value(vehicleStatus),
      createdAt: Value(createdAt),
      lastUpdated: Value(lastUpdated),
      isActive: Value(isActive),
    );
  }

  factory ModelVehicleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelVehicleData(
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      vehicleName: serializer.fromJson<String>(json['vehicleName']),
      vehicleType: serializer.fromJson<String>(json['vehicleType']),
      vehicleNumber: serializer.fromJson<String>(json['vehicleNumber']),
      vehicleFuelType: serializer.fromJson<String>(json['vehicleFuelType']),
      vehicleStatus: serializer.fromJson<String>(json['vehicleStatus']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vehicleId': serializer.toJson<int>(vehicleId),
      'vehicleName': serializer.toJson<String>(vehicleName),
      'vehicleType': serializer.toJson<String>(vehicleType),
      'vehicleNumber': serializer.toJson<String>(vehicleNumber),
      'vehicleFuelType': serializer.toJson<String>(vehicleFuelType),
      'vehicleStatus': serializer.toJson<String>(vehicleStatus),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  ModelVehicleData copyWith(
          {int? vehicleId,
          String? vehicleName,
          String? vehicleType,
          String? vehicleNumber,
          String? vehicleFuelType,
          String? vehicleStatus,
          DateTime? createdAt,
          DateTime? lastUpdated,
          bool? isActive}) =>
      ModelVehicleData(
        vehicleId: vehicleId ?? this.vehicleId,
        vehicleName: vehicleName ?? this.vehicleName,
        vehicleType: vehicleType ?? this.vehicleType,
        vehicleNumber: vehicleNumber ?? this.vehicleNumber,
        vehicleFuelType: vehicleFuelType ?? this.vehicleFuelType,
        vehicleStatus: vehicleStatus ?? this.vehicleStatus,
        createdAt: createdAt ?? this.createdAt,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        isActive: isActive ?? this.isActive,
      );
  @override
  String toString() {
    return (StringBuffer('ModelVehicleData(')
          ..write('vehicleId: $vehicleId, ')
          ..write('vehicleName: $vehicleName, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('vehicleNumber: $vehicleNumber, ')
          ..write('vehicleFuelType: $vehicleFuelType, ')
          ..write('vehicleStatus: $vehicleStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      vehicleId,
      vehicleName,
      vehicleType,
      vehicleNumber,
      vehicleFuelType,
      vehicleStatus,
      createdAt,
      lastUpdated,
      isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelVehicleData &&
          other.vehicleId == this.vehicleId &&
          other.vehicleName == this.vehicleName &&
          other.vehicleType == this.vehicleType &&
          other.vehicleNumber == this.vehicleNumber &&
          other.vehicleFuelType == this.vehicleFuelType &&
          other.vehicleStatus == this.vehicleStatus &&
          other.createdAt == this.createdAt &&
          other.lastUpdated == this.lastUpdated &&
          other.isActive == this.isActive);
}

class ModelVehicleCompanion extends UpdateCompanion<ModelVehicleData> {
  final Value<int> vehicleId;
  final Value<String> vehicleName;
  final Value<String> vehicleType;
  final Value<String> vehicleNumber;
  final Value<String> vehicleFuelType;
  final Value<String> vehicleStatus;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastUpdated;
  final Value<bool> isActive;
  const ModelVehicleCompanion({
    this.vehicleId = const Value.absent(),
    this.vehicleName = const Value.absent(),
    this.vehicleType = const Value.absent(),
    this.vehicleNumber = const Value.absent(),
    this.vehicleFuelType = const Value.absent(),
    this.vehicleStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  ModelVehicleCompanion.insert({
    this.vehicleId = const Value.absent(),
    required String vehicleName,
    required String vehicleType,
    required String vehicleNumber,
    required String vehicleFuelType,
    this.vehicleStatus = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.isActive = const Value.absent(),
  })  : vehicleName = Value(vehicleName),
        vehicleType = Value(vehicleType),
        vehicleNumber = Value(vehicleNumber),
        vehicleFuelType = Value(vehicleFuelType);
  static Insertable<ModelVehicleData> custom({
    Expression<int>? vehicleId,
    Expression<String>? vehicleName,
    Expression<String>? vehicleType,
    Expression<String>? vehicleNumber,
    Expression<String>? vehicleFuelType,
    Expression<String>? vehicleStatus,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdated,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (vehicleName != null) 'vehicle_name': vehicleName,
      if (vehicleType != null) 'vehicle_type': vehicleType,
      if (vehicleNumber != null) 'vehicle_number': vehicleNumber,
      if (vehicleFuelType != null) 'vehicle_fuel_type': vehicleFuelType,
      if (vehicleStatus != null) 'vehicle_status': vehicleStatus,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (isActive != null) 'is_active': isActive,
    });
  }

  ModelVehicleCompanion copyWith(
      {Value<int>? vehicleId,
      Value<String>? vehicleName,
      Value<String>? vehicleType,
      Value<String>? vehicleNumber,
      Value<String>? vehicleFuelType,
      Value<String>? vehicleStatus,
      Value<DateTime>? createdAt,
      Value<DateTime>? lastUpdated,
      Value<bool>? isActive}) {
    return ModelVehicleCompanion(
      vehicleId: vehicleId ?? this.vehicleId,
      vehicleName: vehicleName ?? this.vehicleName,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      vehicleFuelType: vehicleFuelType ?? this.vehicleFuelType,
      vehicleStatus: vehicleStatus ?? this.vehicleStatus,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (vehicleName.present) {
      map['vehicle_name'] = Variable<String>(vehicleName.value);
    }
    if (vehicleType.present) {
      map['vehicle_type'] = Variable<String>(vehicleType.value);
    }
    if (vehicleNumber.present) {
      map['vehicle_number'] = Variable<String>(vehicleNumber.value);
    }
    if (vehicleFuelType.present) {
      map['vehicle_fuel_type'] = Variable<String>(vehicleFuelType.value);
    }
    if (vehicleStatus.present) {
      map['vehicle_status'] = Variable<String>(vehicleStatus.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelVehicleCompanion(')
          ..write('vehicleId: $vehicleId, ')
          ..write('vehicleName: $vehicleName, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('vehicleNumber: $vehicleNumber, ')
          ..write('vehicleFuelType: $vehicleFuelType, ')
          ..write('vehicleStatus: $vehicleStatus, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $ModelVehicleTable extends ModelVehicle
    with TableInfo<$ModelVehicleTable, ModelVehicleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelVehicleTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _vehicleIdMeta = const VerificationMeta('vehicleId');
  @override
  late final GeneratedColumn<int?> vehicleId = GeneratedColumn<int?>(
      'vehicle_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _vehicleNameMeta =
      const VerificationMeta('vehicleName');
  @override
  late final GeneratedColumn<String?> vehicleName = GeneratedColumn<String?>(
      'vehicle_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _vehicleTypeMeta =
      const VerificationMeta('vehicleType');
  @override
  late final GeneratedColumn<String?> vehicleType = GeneratedColumn<String?>(
      'vehicle_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _vehicleNumberMeta =
      const VerificationMeta('vehicleNumber');
  @override
  late final GeneratedColumn<String?> vehicleNumber = GeneratedColumn<String?>(
      'vehicle_number', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _vehicleFuelTypeMeta =
      const VerificationMeta('vehicleFuelType');
  @override
  late final GeneratedColumn<String?> vehicleFuelType =
      GeneratedColumn<String?>('vehicle_fuel_type', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
              minTextLength: 3, maxTextLength: 20),
          type: const StringType(),
          requiredDuringInsert: true);
  final VerificationMeta _vehicleStatusMeta =
      const VerificationMeta('vehicleStatus');
  @override
  late final GeneratedColumn<String?> vehicleStatus = GeneratedColumn<String?>(
      'vehicle_status', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('available'));
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime?> lastUpdated =
      GeneratedColumn<DateTime?>('last_updated', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
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
        vehicleId,
        vehicleName,
        vehicleType,
        vehicleNumber,
        vehicleFuelType,
        vehicleStatus,
        createdAt,
        lastUpdated,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? 'model_vehicle';
  @override
  String get actualTableName => 'model_vehicle';
  @override
  VerificationContext validateIntegrity(Insertable<ModelVehicleData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vehicle_id')) {
      context.handle(_vehicleIdMeta,
          vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta));
    }
    if (data.containsKey('vehicle_name')) {
      context.handle(
          _vehicleNameMeta,
          vehicleName.isAcceptableOrUnknown(
              data['vehicle_name']!, _vehicleNameMeta));
    } else if (isInserting) {
      context.missing(_vehicleNameMeta);
    }
    if (data.containsKey('vehicle_type')) {
      context.handle(
          _vehicleTypeMeta,
          vehicleType.isAcceptableOrUnknown(
              data['vehicle_type']!, _vehicleTypeMeta));
    } else if (isInserting) {
      context.missing(_vehicleTypeMeta);
    }
    if (data.containsKey('vehicle_number')) {
      context.handle(
          _vehicleNumberMeta,
          vehicleNumber.isAcceptableOrUnknown(
              data['vehicle_number']!, _vehicleNumberMeta));
    } else if (isInserting) {
      context.missing(_vehicleNumberMeta);
    }
    if (data.containsKey('vehicle_fuel_type')) {
      context.handle(
          _vehicleFuelTypeMeta,
          vehicleFuelType.isAcceptableOrUnknown(
              data['vehicle_fuel_type']!, _vehicleFuelTypeMeta));
    } else if (isInserting) {
      context.missing(_vehicleFuelTypeMeta);
    }
    if (data.containsKey('vehicle_status')) {
      context.handle(
          _vehicleStatusMeta,
          vehicleStatus.isAcceptableOrUnknown(
              data['vehicle_status']!, _vehicleStatusMeta));
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
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vehicleId};
  @override
  ModelVehicleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ModelVehicleData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelVehicleTable createAlias(String alias) {
    return $ModelVehicleTable(attachedDatabase, alias);
  }
}

class ModelTransportData extends DataClass
    implements Insertable<ModelTransportData> {
  final int transportId;
  final int? vehicleId;
  final DeliveryOrderList? deliveryOrderList;
  final ReturnOrderList? returnOrderList;
  final String transportStatus;
  final String? transportBy;
  final DateTime scheduleDate;
  final DateTime? startedAt;
  final DateTime createdAt;
  final DateTime lastUpdated;
  ModelTransportData(
      {required this.transportId,
      this.vehicleId,
      this.deliveryOrderList,
      this.returnOrderList,
      required this.transportStatus,
      this.transportBy,
      required this.scheduleDate,
      this.startedAt,
      required this.createdAt,
      required this.lastUpdated});
  factory ModelTransportData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelTransportData(
      transportId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transport_id'])!,
      vehicleId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}vehicle_id']),
      deliveryOrderList: $ModelTransportTable.$converter0.mapToDart(
          const StringType().mapFromDatabaseResponse(
              data['${effectivePrefix}delivery_order_list'])),
      returnOrderList: $ModelTransportTable.$converter1.mapToDart(
          const StringType().mapFromDatabaseResponse(
              data['${effectivePrefix}return_order_list'])),
      transportStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transport_status'])!,
      transportBy: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transport_by']),
      scheduleDate: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}schedule_date'])!,
      startedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}started_at']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      lastUpdated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['transport_id'] = Variable<int>(transportId);
    if (!nullToAbsent || vehicleId != null) {
      map['vehicle_id'] = Variable<int?>(vehicleId);
    }
    if (!nullToAbsent || deliveryOrderList != null) {
      final converter = $ModelTransportTable.$converter0;
      map['delivery_order_list'] =
          Variable<String?>(converter.mapToSql(deliveryOrderList));
    }
    if (!nullToAbsent || returnOrderList != null) {
      final converter = $ModelTransportTable.$converter1;
      map['return_order_list'] =
          Variable<String?>(converter.mapToSql(returnOrderList));
    }
    map['transport_status'] = Variable<String>(transportStatus);
    if (!nullToAbsent || transportBy != null) {
      map['transport_by'] = Variable<String?>(transportBy);
    }
    map['schedule_date'] = Variable<DateTime>(scheduleDate);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime?>(startedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  ModelTransportCompanion toCompanion(bool nullToAbsent) {
    return ModelTransportCompanion(
      transportId: Value(transportId),
      vehicleId: vehicleId == null && nullToAbsent
          ? const Value.absent()
          : Value(vehicleId),
      deliveryOrderList: deliveryOrderList == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryOrderList),
      returnOrderList: returnOrderList == null && nullToAbsent
          ? const Value.absent()
          : Value(returnOrderList),
      transportStatus: Value(transportStatus),
      transportBy: transportBy == null && nullToAbsent
          ? const Value.absent()
          : Value(transportBy),
      scheduleDate: Value(scheduleDate),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      createdAt: Value(createdAt),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory ModelTransportData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelTransportData(
      transportId: serializer.fromJson<int>(json['transportId']),
      vehicleId: serializer.fromJson<int?>(json['vehicleId']),
      deliveryOrderList:
          serializer.fromJson<DeliveryOrderList?>(json['deliveryOrderList']),
      returnOrderList:
          serializer.fromJson<ReturnOrderList?>(json['returnOrderList']),
      transportStatus: serializer.fromJson<String>(json['transportStatus']),
      transportBy: serializer.fromJson<String?>(json['transportBy']),
      scheduleDate: serializer.fromJson<DateTime>(json['scheduleDate']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'transportId': serializer.toJson<int>(transportId),
      'vehicleId': serializer.toJson<int?>(vehicleId),
      'deliveryOrderList':
          serializer.toJson<DeliveryOrderList?>(deliveryOrderList),
      'returnOrderList': serializer.toJson<ReturnOrderList?>(returnOrderList),
      'transportStatus': serializer.toJson<String>(transportStatus),
      'transportBy': serializer.toJson<String?>(transportBy),
      'scheduleDate': serializer.toJson<DateTime>(scheduleDate),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  ModelTransportData copyWith(
          {int? transportId,
          int? vehicleId,
          DeliveryOrderList? deliveryOrderList,
          ReturnOrderList? returnOrderList,
          String? transportStatus,
          String? transportBy,
          DateTime? scheduleDate,
          DateTime? startedAt,
          DateTime? createdAt,
          DateTime? lastUpdated}) =>
      ModelTransportData(
        transportId: transportId ?? this.transportId,
        vehicleId: vehicleId ?? this.vehicleId,
        deliveryOrderList: deliveryOrderList ?? this.deliveryOrderList,
        returnOrderList: returnOrderList ?? this.returnOrderList,
        transportStatus: transportStatus ?? this.transportStatus,
        transportBy: transportBy ?? this.transportBy,
        scheduleDate: scheduleDate ?? this.scheduleDate,
        startedAt: startedAt ?? this.startedAt,
        createdAt: createdAt ?? this.createdAt,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('ModelTransportData(')
          ..write('transportId: $transportId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('deliveryOrderList: $deliveryOrderList, ')
          ..write('returnOrderList: $returnOrderList, ')
          ..write('transportStatus: $transportStatus, ')
          ..write('transportBy: $transportBy, ')
          ..write('scheduleDate: $scheduleDate, ')
          ..write('startedAt: $startedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      transportId,
      vehicleId,
      deliveryOrderList,
      returnOrderList,
      transportStatus,
      transportBy,
      scheduleDate,
      startedAt,
      createdAt,
      lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelTransportData &&
          other.transportId == this.transportId &&
          other.vehicleId == this.vehicleId &&
          other.deliveryOrderList == this.deliveryOrderList &&
          other.returnOrderList == this.returnOrderList &&
          other.transportStatus == this.transportStatus &&
          other.transportBy == this.transportBy &&
          other.scheduleDate == this.scheduleDate &&
          other.startedAt == this.startedAt &&
          other.createdAt == this.createdAt &&
          other.lastUpdated == this.lastUpdated);
}

class ModelTransportCompanion extends UpdateCompanion<ModelTransportData> {
  final Value<int> transportId;
  final Value<int?> vehicleId;
  final Value<DeliveryOrderList?> deliveryOrderList;
  final Value<ReturnOrderList?> returnOrderList;
  final Value<String> transportStatus;
  final Value<String?> transportBy;
  final Value<DateTime> scheduleDate;
  final Value<DateTime?> startedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastUpdated;
  const ModelTransportCompanion({
    this.transportId = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.deliveryOrderList = const Value.absent(),
    this.returnOrderList = const Value.absent(),
    this.transportStatus = const Value.absent(),
    this.transportBy = const Value.absent(),
    this.scheduleDate = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  ModelTransportCompanion.insert({
    this.transportId = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.deliveryOrderList = const Value.absent(),
    this.returnOrderList = const Value.absent(),
    this.transportStatus = const Value.absent(),
    this.transportBy = const Value.absent(),
    required DateTime scheduleDate,
    this.startedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  }) : scheduleDate = Value(scheduleDate);
  static Insertable<ModelTransportData> custom({
    Expression<int>? transportId,
    Expression<int?>? vehicleId,
    Expression<DeliveryOrderList?>? deliveryOrderList,
    Expression<ReturnOrderList?>? returnOrderList,
    Expression<String>? transportStatus,
    Expression<String?>? transportBy,
    Expression<DateTime>? scheduleDate,
    Expression<DateTime?>? startedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (transportId != null) 'transport_id': transportId,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (deliveryOrderList != null) 'delivery_order_list': deliveryOrderList,
      if (returnOrderList != null) 'return_order_list': returnOrderList,
      if (transportStatus != null) 'transport_status': transportStatus,
      if (transportBy != null) 'transport_by': transportBy,
      if (scheduleDate != null) 'schedule_date': scheduleDate,
      if (startedAt != null) 'started_at': startedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  ModelTransportCompanion copyWith(
      {Value<int>? transportId,
      Value<int?>? vehicleId,
      Value<DeliveryOrderList?>? deliveryOrderList,
      Value<ReturnOrderList?>? returnOrderList,
      Value<String>? transportStatus,
      Value<String?>? transportBy,
      Value<DateTime>? scheduleDate,
      Value<DateTime?>? startedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? lastUpdated}) {
    return ModelTransportCompanion(
      transportId: transportId ?? this.transportId,
      vehicleId: vehicleId ?? this.vehicleId,
      deliveryOrderList: deliveryOrderList ?? this.deliveryOrderList,
      returnOrderList: returnOrderList ?? this.returnOrderList,
      transportStatus: transportStatus ?? this.transportStatus,
      transportBy: transportBy ?? this.transportBy,
      scheduleDate: scheduleDate ?? this.scheduleDate,
      startedAt: startedAt ?? this.startedAt,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (transportId.present) {
      map['transport_id'] = Variable<int>(transportId.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int?>(vehicleId.value);
    }
    if (deliveryOrderList.present) {
      final converter = $ModelTransportTable.$converter0;
      map['delivery_order_list'] =
          Variable<String?>(converter.mapToSql(deliveryOrderList.value));
    }
    if (returnOrderList.present) {
      final converter = $ModelTransportTable.$converter1;
      map['return_order_list'] =
          Variable<String?>(converter.mapToSql(returnOrderList.value));
    }
    if (transportStatus.present) {
      map['transport_status'] = Variable<String>(transportStatus.value);
    }
    if (transportBy.present) {
      map['transport_by'] = Variable<String?>(transportBy.value);
    }
    if (scheduleDate.present) {
      map['schedule_date'] = Variable<DateTime>(scheduleDate.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime?>(startedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelTransportCompanion(')
          ..write('transportId: $transportId, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('deliveryOrderList: $deliveryOrderList, ')
          ..write('returnOrderList: $returnOrderList, ')
          ..write('transportStatus: $transportStatus, ')
          ..write('transportBy: $transportBy, ')
          ..write('scheduleDate: $scheduleDate, ')
          ..write('startedAt: $startedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated')
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
  final VerificationMeta _vehicleIdMeta = const VerificationMeta('vehicleId');
  @override
  late final GeneratedColumn<int?> vehicleId = GeneratedColumn<int?>(
      'vehicle_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES model_vehicle (vehicle_id)');
  final VerificationMeta _deliveryOrderListMeta =
      const VerificationMeta('deliveryOrderList');
  @override
  late final GeneratedColumnWithTypeConverter<DeliveryOrderList, String?>
      deliveryOrderList = GeneratedColumn<String?>(
              'delivery_order_list', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<DeliveryOrderList>($ModelTransportTable.$converter0);
  final VerificationMeta _returnOrderListMeta =
      const VerificationMeta('returnOrderList');
  @override
  late final GeneratedColumnWithTypeConverter<ReturnOrderList, String?>
      returnOrderList = GeneratedColumn<String?>(
              'return_order_list', aliasedName, true,
              type: const StringType(), requiredDuringInsert: false)
          .withConverter<ReturnOrderList>($ModelTransportTable.$converter1);
  final VerificationMeta _transportStatusMeta =
      const VerificationMeta('transportStatus');
  @override
  late final GeneratedColumn<String?> transportStatus =
      GeneratedColumn<String?>('transport_status', aliasedName, false,
          type: const StringType(),
          requiredDuringInsert: false,
          defaultValue: const Constant('pending'));
  final VerificationMeta _transportByMeta =
      const VerificationMeta('transportBy');
  @override
  late final GeneratedColumn<String?> transportBy = GeneratedColumn<String?>(
      'transport_by', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _scheduleDateMeta =
      const VerificationMeta('scheduleDate');
  @override
  late final GeneratedColumn<DateTime?> scheduleDate =
      GeneratedColumn<DateTime?>('schedule_date', aliasedName, false,
          type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _startedAtMeta = const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime?> startedAt = GeneratedColumn<DateTime?>(
      'started_at', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime?> lastUpdated =
      GeneratedColumn<DateTime?>('last_updated', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        transportId,
        vehicleId,
        deliveryOrderList,
        returnOrderList,
        transportStatus,
        transportBy,
        scheduleDate,
        startedAt,
        createdAt,
        lastUpdated
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
    if (data.containsKey('vehicle_id')) {
      context.handle(_vehicleIdMeta,
          vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta));
    }
    context.handle(_deliveryOrderListMeta, const VerificationResult.success());
    context.handle(_returnOrderListMeta, const VerificationResult.success());
    if (data.containsKey('transport_status')) {
      context.handle(
          _transportStatusMeta,
          transportStatus.isAcceptableOrUnknown(
              data['transport_status']!, _transportStatusMeta));
    }
    if (data.containsKey('transport_by')) {
      context.handle(
          _transportByMeta,
          transportBy.isAcceptableOrUnknown(
              data['transport_by']!, _transportByMeta));
    }
    if (data.containsKey('schedule_date')) {
      context.handle(
          _scheduleDateMeta,
          scheduleDate.isAcceptableOrUnknown(
              data['schedule_date']!, _scheduleDateMeta));
    } else if (isInserting) {
      context.missing(_scheduleDateMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
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

  static TypeConverter<DeliveryOrderList, String> $converter0 =
      const DeliveryOrderListConverter();
  static TypeConverter<ReturnOrderList, String> $converter1 =
      const ReturnOrderListConverter();
}

class ModelDeliveryOrderData extends DataClass
    implements Insertable<ModelDeliveryOrderData> {
  final int deliveryOrderId;
  final int clientId;
  final int? transportId;
  final ItemList itemList;
  final double netTotal;
  final double totalReceivedAmount;
  final String paymentStatus;
  final String orderStatus;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final DateTime? expectedDeliveryDate;
  ModelDeliveryOrderData(
      {required this.deliveryOrderId,
      required this.clientId,
      this.transportId,
      required this.itemList,
      required this.netTotal,
      required this.totalReceivedAmount,
      required this.paymentStatus,
      required this.orderStatus,
      this.createdBy,
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
      transportId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transport_id']),
      itemList: $ModelDeliveryOrderTable.$converter0.mapToDart(
          const StringType()
              .mapFromDatabaseResponse(data['${effectivePrefix}item_list']))!,
      netTotal: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}net_total'])!,
      totalReceivedAmount: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}total_received_amount'])!,
      paymentStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_status'])!,
      orderStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_status'])!,
      createdBy: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_by']),
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
    if (!nullToAbsent || transportId != null) {
      map['transport_id'] = Variable<int?>(transportId);
    }
    {
      final converter = $ModelDeliveryOrderTable.$converter0;
      map['item_list'] = Variable<String>(converter.mapToSql(itemList)!);
    }
    map['net_total'] = Variable<double>(netTotal);
    map['total_received_amount'] = Variable<double>(totalReceivedAmount);
    map['payment_status'] = Variable<String>(paymentStatus);
    map['order_status'] = Variable<String>(orderStatus);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String?>(createdBy);
    }
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
      transportId: transportId == null && nullToAbsent
          ? const Value.absent()
          : Value(transportId),
      itemList: Value(itemList),
      netTotal: Value(netTotal),
      totalReceivedAmount: Value(totalReceivedAmount),
      paymentStatus: Value(paymentStatus),
      orderStatus: Value(orderStatus),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
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
      transportId: serializer.fromJson<int?>(json['transportId']),
      itemList: serializer.fromJson<ItemList>(json['itemList']),
      netTotal: serializer.fromJson<double>(json['netTotal']),
      totalReceivedAmount:
          serializer.fromJson<double>(json['totalReceivedAmount']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      orderStatus: serializer.fromJson<String>(json['orderStatus']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
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
      'transportId': serializer.toJson<int?>(transportId),
      'itemList': serializer.toJson<ItemList>(itemList),
      'netTotal': serializer.toJson<double>(netTotal),
      'totalReceivedAmount': serializer.toJson<double>(totalReceivedAmount),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'orderStatus': serializer.toJson<String>(orderStatus),
      'createdBy': serializer.toJson<String?>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'expectedDeliveryDate':
          serializer.toJson<DateTime?>(expectedDeliveryDate),
    };
  }

  ModelDeliveryOrderData copyWith(
          {int? deliveryOrderId,
          int? clientId,
          int? transportId,
          ItemList? itemList,
          double? netTotal,
          double? totalReceivedAmount,
          String? paymentStatus,
          String? orderStatus,
          String? createdBy,
          DateTime? createdAt,
          DateTime? lastUpdated,
          DateTime? expectedDeliveryDate}) =>
      ModelDeliveryOrderData(
        deliveryOrderId: deliveryOrderId ?? this.deliveryOrderId,
        clientId: clientId ?? this.clientId,
        transportId: transportId ?? this.transportId,
        itemList: itemList ?? this.itemList,
        netTotal: netTotal ?? this.netTotal,
        totalReceivedAmount: totalReceivedAmount ?? this.totalReceivedAmount,
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
          ..write('transportId: $transportId, ')
          ..write('itemList: $itemList, ')
          ..write('netTotal: $netTotal, ')
          ..write('totalReceivedAmount: $totalReceivedAmount, ')
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
      transportId,
      itemList,
      netTotal,
      totalReceivedAmount,
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
          other.transportId == this.transportId &&
          other.itemList == this.itemList &&
          other.netTotal == this.netTotal &&
          other.totalReceivedAmount == this.totalReceivedAmount &&
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
  final Value<int?> transportId;
  final Value<ItemList> itemList;
  final Value<double> netTotal;
  final Value<double> totalReceivedAmount;
  final Value<String> paymentStatus;
  final Value<String> orderStatus;
  final Value<String?> createdBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastUpdated;
  final Value<DateTime?> expectedDeliveryDate;
  const ModelDeliveryOrderCompanion({
    this.deliveryOrderId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.transportId = const Value.absent(),
    this.itemList = const Value.absent(),
    this.netTotal = const Value.absent(),
    this.totalReceivedAmount = const Value.absent(),
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
    this.transportId = const Value.absent(),
    required ItemList itemList,
    required double netTotal,
    this.totalReceivedAmount = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    required String orderStatus,
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.expectedDeliveryDate = const Value.absent(),
  })  : clientId = Value(clientId),
        itemList = Value(itemList),
        netTotal = Value(netTotal),
        orderStatus = Value(orderStatus);
  static Insertable<ModelDeliveryOrderData> custom({
    Expression<int>? deliveryOrderId,
    Expression<int>? clientId,
    Expression<int?>? transportId,
    Expression<ItemList>? itemList,
    Expression<double>? netTotal,
    Expression<double>? totalReceivedAmount,
    Expression<String>? paymentStatus,
    Expression<String>? orderStatus,
    Expression<String?>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdated,
    Expression<DateTime?>? expectedDeliveryDate,
  }) {
    return RawValuesInsertable({
      if (deliveryOrderId != null) 'delivery_order_id': deliveryOrderId,
      if (clientId != null) 'client_id': clientId,
      if (transportId != null) 'transport_id': transportId,
      if (itemList != null) 'item_list': itemList,
      if (netTotal != null) 'net_total': netTotal,
      if (totalReceivedAmount != null)
        'total_received_amount': totalReceivedAmount,
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
      Value<int?>? transportId,
      Value<ItemList>? itemList,
      Value<double>? netTotal,
      Value<double>? totalReceivedAmount,
      Value<String>? paymentStatus,
      Value<String>? orderStatus,
      Value<String?>? createdBy,
      Value<DateTime>? createdAt,
      Value<DateTime>? lastUpdated,
      Value<DateTime?>? expectedDeliveryDate}) {
    return ModelDeliveryOrderCompanion(
      deliveryOrderId: deliveryOrderId ?? this.deliveryOrderId,
      clientId: clientId ?? this.clientId,
      transportId: transportId ?? this.transportId,
      itemList: itemList ?? this.itemList,
      netTotal: netTotal ?? this.netTotal,
      totalReceivedAmount: totalReceivedAmount ?? this.totalReceivedAmount,
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
    if (transportId.present) {
      map['transport_id'] = Variable<int?>(transportId.value);
    }
    if (itemList.present) {
      final converter = $ModelDeliveryOrderTable.$converter0;
      map['item_list'] = Variable<String>(converter.mapToSql(itemList.value)!);
    }
    if (netTotal.present) {
      map['net_total'] = Variable<double>(netTotal.value);
    }
    if (totalReceivedAmount.present) {
      map['total_received_amount'] =
          Variable<double>(totalReceivedAmount.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(paymentStatus.value);
    }
    if (orderStatus.present) {
      map['order_status'] = Variable<String>(orderStatus.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String?>(createdBy.value);
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
          ..write('transportId: $transportId, ')
          ..write('itemList: $itemList, ')
          ..write('netTotal: $netTotal, ')
          ..write('totalReceivedAmount: $totalReceivedAmount, ')
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
  final VerificationMeta _transportIdMeta =
      const VerificationMeta('transportId');
  @override
  late final GeneratedColumn<int?> transportId = GeneratedColumn<int?>(
      'transport_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES model_transport (transport_id)');
  final VerificationMeta _itemListMeta = const VerificationMeta('itemList');
  @override
  late final GeneratedColumnWithTypeConverter<ItemList, String?> itemList =
      GeneratedColumn<String?>('item_list', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<ItemList>($ModelDeliveryOrderTable.$converter0);
  final VerificationMeta _netTotalMeta = const VerificationMeta('netTotal');
  @override
  late final GeneratedColumn<double?> netTotal = GeneratedColumn<double?>(
      'net_total', aliasedName, false,
      type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _totalReceivedAmountMeta =
      const VerificationMeta('totalReceivedAmount');
  @override
  late final GeneratedColumn<double?> totalReceivedAmount =
      GeneratedColumn<double?>('total_received_amount', aliasedName, false,
          type: const RealType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  final VerificationMeta _paymentStatusMeta =
      const VerificationMeta('paymentStatus');
  @override
  late final GeneratedColumn<String?> paymentStatus = GeneratedColumn<String?>(
      'payment_status', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('unpaid'));
  final VerificationMeta _orderStatusMeta =
      const VerificationMeta('orderStatus');
  @override
  late final GeneratedColumn<String?> orderStatus = GeneratedColumn<String?>(
      'order_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _createdByMeta = const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String?> createdBy = GeneratedColumn<String?>(
      'created_by', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime?> lastUpdated =
      GeneratedColumn<DateTime?>('last_updated', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
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
        transportId,
        itemList,
        netTotal,
        totalReceivedAmount,
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
    if (data.containsKey('transport_id')) {
      context.handle(
          _transportIdMeta,
          transportId.isAcceptableOrUnknown(
              data['transport_id']!, _transportIdMeta));
    }
    context.handle(_itemListMeta, const VerificationResult.success());
    if (data.containsKey('net_total')) {
      context.handle(_netTotalMeta,
          netTotal.isAcceptableOrUnknown(data['net_total']!, _netTotalMeta));
    } else if (isInserting) {
      context.missing(_netTotalMeta);
    }
    if (data.containsKey('total_received_amount')) {
      context.handle(
          _totalReceivedAmountMeta,
          totalReceivedAmount.isAcceptableOrUnknown(
              data['total_received_amount']!, _totalReceivedAmountMeta));
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

  static TypeConverter<ItemList, String> $converter0 =
      const ItemListConverter();
}

class ModelReturnOrderData extends DataClass
    implements Insertable<ModelReturnOrderData> {
  final int returnOrderId;
  final int orderId;
  final int? transportId;
  final int clientId;
  final ItemList itemList;
  final String returnStatus;
  final double totalSendAmount;
  final double netRefund;
  final String refundStatus;
  final String? returnedBy;
  final String returnReason;
  final DateTime lastUpdated;
  final DateTime createdAt;
  final DateTime? expectedPickupDate;
  ModelReturnOrderData(
      {required this.returnOrderId,
      required this.orderId,
      this.transportId,
      required this.clientId,
      required this.itemList,
      required this.returnStatus,
      required this.totalSendAmount,
      required this.netRefund,
      required this.refundStatus,
      this.returnedBy,
      required this.returnReason,
      required this.lastUpdated,
      required this.createdAt,
      this.expectedPickupDate});
  factory ModelReturnOrderData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelReturnOrderData(
      returnOrderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}return_order_id'])!,
      orderId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}order_id'])!,
      transportId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}transport_id']),
      clientId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_id'])!,
      itemList: $ModelReturnOrderTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_list']))!,
      returnStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}return_status'])!,
      totalSendAmount: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}total_send_amount'])!,
      netRefund: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}net_refund'])!,
      refundStatus: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}refund_status'])!,
      returnedBy: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}returned_by']),
      returnReason: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}return_reason'])!,
      lastUpdated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      expectedPickupDate: const DateTimeType().mapFromDatabaseResponse(
          data['${effectivePrefix}expected_pickup_date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['return_order_id'] = Variable<int>(returnOrderId);
    map['order_id'] = Variable<int>(orderId);
    if (!nullToAbsent || transportId != null) {
      map['transport_id'] = Variable<int?>(transportId);
    }
    map['client_id'] = Variable<int>(clientId);
    {
      final converter = $ModelReturnOrderTable.$converter0;
      map['item_list'] = Variable<String>(converter.mapToSql(itemList)!);
    }
    map['return_status'] = Variable<String>(returnStatus);
    map['total_send_amount'] = Variable<double>(totalSendAmount);
    map['net_refund'] = Variable<double>(netRefund);
    map['refund_status'] = Variable<String>(refundStatus);
    if (!nullToAbsent || returnedBy != null) {
      map['returned_by'] = Variable<String?>(returnedBy);
    }
    map['return_reason'] = Variable<String>(returnReason);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || expectedPickupDate != null) {
      map['expected_pickup_date'] = Variable<DateTime?>(expectedPickupDate);
    }
    return map;
  }

  ModelReturnOrderCompanion toCompanion(bool nullToAbsent) {
    return ModelReturnOrderCompanion(
      returnOrderId: Value(returnOrderId),
      orderId: Value(orderId),
      transportId: transportId == null && nullToAbsent
          ? const Value.absent()
          : Value(transportId),
      clientId: Value(clientId),
      itemList: Value(itemList),
      returnStatus: Value(returnStatus),
      totalSendAmount: Value(totalSendAmount),
      netRefund: Value(netRefund),
      refundStatus: Value(refundStatus),
      returnedBy: returnedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(returnedBy),
      returnReason: Value(returnReason),
      lastUpdated: Value(lastUpdated),
      createdAt: Value(createdAt),
      expectedPickupDate: expectedPickupDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedPickupDate),
    );
  }

  factory ModelReturnOrderData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelReturnOrderData(
      returnOrderId: serializer.fromJson<int>(json['returnOrderId']),
      orderId: serializer.fromJson<int>(json['orderId']),
      transportId: serializer.fromJson<int?>(json['transportId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      itemList: serializer.fromJson<ItemList>(json['itemList']),
      returnStatus: serializer.fromJson<String>(json['returnStatus']),
      totalSendAmount: serializer.fromJson<double>(json['totalSendAmount']),
      netRefund: serializer.fromJson<double>(json['netRefund']),
      refundStatus: serializer.fromJson<String>(json['refundStatus']),
      returnedBy: serializer.fromJson<String?>(json['returnedBy']),
      returnReason: serializer.fromJson<String>(json['returnReason']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      expectedPickupDate:
          serializer.fromJson<DateTime?>(json['expectedPickupDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'returnOrderId': serializer.toJson<int>(returnOrderId),
      'orderId': serializer.toJson<int>(orderId),
      'transportId': serializer.toJson<int?>(transportId),
      'clientId': serializer.toJson<int>(clientId),
      'itemList': serializer.toJson<ItemList>(itemList),
      'returnStatus': serializer.toJson<String>(returnStatus),
      'totalSendAmount': serializer.toJson<double>(totalSendAmount),
      'netRefund': serializer.toJson<double>(netRefund),
      'refundStatus': serializer.toJson<String>(refundStatus),
      'returnedBy': serializer.toJson<String?>(returnedBy),
      'returnReason': serializer.toJson<String>(returnReason),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'expectedPickupDate': serializer.toJson<DateTime?>(expectedPickupDate),
    };
  }

  ModelReturnOrderData copyWith(
          {int? returnOrderId,
          int? orderId,
          int? transportId,
          int? clientId,
          ItemList? itemList,
          String? returnStatus,
          double? totalSendAmount,
          double? netRefund,
          String? refundStatus,
          String? returnedBy,
          String? returnReason,
          DateTime? lastUpdated,
          DateTime? createdAt,
          DateTime? expectedPickupDate}) =>
      ModelReturnOrderData(
        returnOrderId: returnOrderId ?? this.returnOrderId,
        orderId: orderId ?? this.orderId,
        transportId: transportId ?? this.transportId,
        clientId: clientId ?? this.clientId,
        itemList: itemList ?? this.itemList,
        returnStatus: returnStatus ?? this.returnStatus,
        totalSendAmount: totalSendAmount ?? this.totalSendAmount,
        netRefund: netRefund ?? this.netRefund,
        refundStatus: refundStatus ?? this.refundStatus,
        returnedBy: returnedBy ?? this.returnedBy,
        returnReason: returnReason ?? this.returnReason,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        createdAt: createdAt ?? this.createdAt,
        expectedPickupDate: expectedPickupDate ?? this.expectedPickupDate,
      );
  @override
  String toString() {
    return (StringBuffer('ModelReturnOrderData(')
          ..write('returnOrderId: $returnOrderId, ')
          ..write('orderId: $orderId, ')
          ..write('transportId: $transportId, ')
          ..write('clientId: $clientId, ')
          ..write('itemList: $itemList, ')
          ..write('returnStatus: $returnStatus, ')
          ..write('totalSendAmount: $totalSendAmount, ')
          ..write('netRefund: $netRefund, ')
          ..write('refundStatus: $refundStatus, ')
          ..write('returnedBy: $returnedBy, ')
          ..write('returnReason: $returnReason, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('createdAt: $createdAt, ')
          ..write('expectedPickupDate: $expectedPickupDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      returnOrderId,
      orderId,
      transportId,
      clientId,
      itemList,
      returnStatus,
      totalSendAmount,
      netRefund,
      refundStatus,
      returnedBy,
      returnReason,
      lastUpdated,
      createdAt,
      expectedPickupDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelReturnOrderData &&
          other.returnOrderId == this.returnOrderId &&
          other.orderId == this.orderId &&
          other.transportId == this.transportId &&
          other.clientId == this.clientId &&
          other.itemList == this.itemList &&
          other.returnStatus == this.returnStatus &&
          other.totalSendAmount == this.totalSendAmount &&
          other.netRefund == this.netRefund &&
          other.refundStatus == this.refundStatus &&
          other.returnedBy == this.returnedBy &&
          other.returnReason == this.returnReason &&
          other.lastUpdated == this.lastUpdated &&
          other.createdAt == this.createdAt &&
          other.expectedPickupDate == this.expectedPickupDate);
}

class ModelReturnOrderCompanion extends UpdateCompanion<ModelReturnOrderData> {
  final Value<int> returnOrderId;
  final Value<int> orderId;
  final Value<int?> transportId;
  final Value<int> clientId;
  final Value<ItemList> itemList;
  final Value<String> returnStatus;
  final Value<double> totalSendAmount;
  final Value<double> netRefund;
  final Value<String> refundStatus;
  final Value<String?> returnedBy;
  final Value<String> returnReason;
  final Value<DateTime> lastUpdated;
  final Value<DateTime> createdAt;
  final Value<DateTime?> expectedPickupDate;
  const ModelReturnOrderCompanion({
    this.returnOrderId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.transportId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.itemList = const Value.absent(),
    this.returnStatus = const Value.absent(),
    this.totalSendAmount = const Value.absent(),
    this.netRefund = const Value.absent(),
    this.refundStatus = const Value.absent(),
    this.returnedBy = const Value.absent(),
    this.returnReason = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expectedPickupDate = const Value.absent(),
  });
  ModelReturnOrderCompanion.insert({
    this.returnOrderId = const Value.absent(),
    required int orderId,
    this.transportId = const Value.absent(),
    required int clientId,
    required ItemList itemList,
    this.returnStatus = const Value.absent(),
    this.totalSendAmount = const Value.absent(),
    this.netRefund = const Value.absent(),
    this.refundStatus = const Value.absent(),
    this.returnedBy = const Value.absent(),
    required String returnReason,
    this.lastUpdated = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expectedPickupDate = const Value.absent(),
  })  : orderId = Value(orderId),
        clientId = Value(clientId),
        itemList = Value(itemList),
        returnReason = Value(returnReason);
  static Insertable<ModelReturnOrderData> custom({
    Expression<int>? returnOrderId,
    Expression<int>? orderId,
    Expression<int?>? transportId,
    Expression<int>? clientId,
    Expression<ItemList>? itemList,
    Expression<String>? returnStatus,
    Expression<double>? totalSendAmount,
    Expression<double>? netRefund,
    Expression<String>? refundStatus,
    Expression<String?>? returnedBy,
    Expression<String>? returnReason,
    Expression<DateTime>? lastUpdated,
    Expression<DateTime>? createdAt,
    Expression<DateTime?>? expectedPickupDate,
  }) {
    return RawValuesInsertable({
      if (returnOrderId != null) 'return_order_id': returnOrderId,
      if (orderId != null) 'order_id': orderId,
      if (transportId != null) 'transport_id': transportId,
      if (clientId != null) 'client_id': clientId,
      if (itemList != null) 'item_list': itemList,
      if (returnStatus != null) 'return_status': returnStatus,
      if (totalSendAmount != null) 'total_send_amount': totalSendAmount,
      if (netRefund != null) 'net_refund': netRefund,
      if (refundStatus != null) 'refund_status': refundStatus,
      if (returnedBy != null) 'returned_by': returnedBy,
      if (returnReason != null) 'return_reason': returnReason,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (createdAt != null) 'created_at': createdAt,
      if (expectedPickupDate != null)
        'expected_pickup_date': expectedPickupDate,
    });
  }

  ModelReturnOrderCompanion copyWith(
      {Value<int>? returnOrderId,
      Value<int>? orderId,
      Value<int?>? transportId,
      Value<int>? clientId,
      Value<ItemList>? itemList,
      Value<String>? returnStatus,
      Value<double>? totalSendAmount,
      Value<double>? netRefund,
      Value<String>? refundStatus,
      Value<String?>? returnedBy,
      Value<String>? returnReason,
      Value<DateTime>? lastUpdated,
      Value<DateTime>? createdAt,
      Value<DateTime?>? expectedPickupDate}) {
    return ModelReturnOrderCompanion(
      returnOrderId: returnOrderId ?? this.returnOrderId,
      orderId: orderId ?? this.orderId,
      transportId: transportId ?? this.transportId,
      clientId: clientId ?? this.clientId,
      itemList: itemList ?? this.itemList,
      returnStatus: returnStatus ?? this.returnStatus,
      totalSendAmount: totalSendAmount ?? this.totalSendAmount,
      netRefund: netRefund ?? this.netRefund,
      refundStatus: refundStatus ?? this.refundStatus,
      returnedBy: returnedBy ?? this.returnedBy,
      returnReason: returnReason ?? this.returnReason,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      createdAt: createdAt ?? this.createdAt,
      expectedPickupDate: expectedPickupDate ?? this.expectedPickupDate,
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
    if (transportId.present) {
      map['transport_id'] = Variable<int?>(transportId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (itemList.present) {
      final converter = $ModelReturnOrderTable.$converter0;
      map['item_list'] = Variable<String>(converter.mapToSql(itemList.value)!);
    }
    if (returnStatus.present) {
      map['return_status'] = Variable<String>(returnStatus.value);
    }
    if (totalSendAmount.present) {
      map['total_send_amount'] = Variable<double>(totalSendAmount.value);
    }
    if (netRefund.present) {
      map['net_refund'] = Variable<double>(netRefund.value);
    }
    if (refundStatus.present) {
      map['refund_status'] = Variable<String>(refundStatus.value);
    }
    if (returnedBy.present) {
      map['returned_by'] = Variable<String?>(returnedBy.value);
    }
    if (returnReason.present) {
      map['return_reason'] = Variable<String>(returnReason.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (expectedPickupDate.present) {
      map['expected_pickup_date'] =
          Variable<DateTime?>(expectedPickupDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelReturnOrderCompanion(')
          ..write('returnOrderId: $returnOrderId, ')
          ..write('orderId: $orderId, ')
          ..write('transportId: $transportId, ')
          ..write('clientId: $clientId, ')
          ..write('itemList: $itemList, ')
          ..write('returnStatus: $returnStatus, ')
          ..write('totalSendAmount: $totalSendAmount, ')
          ..write('netRefund: $netRefund, ')
          ..write('refundStatus: $refundStatus, ')
          ..write('returnedBy: $returnedBy, ')
          ..write('returnReason: $returnReason, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('createdAt: $createdAt, ')
          ..write('expectedPickupDate: $expectedPickupDate')
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
  final VerificationMeta _transportIdMeta =
      const VerificationMeta('transportId');
  @override
  late final GeneratedColumn<int?> transportId = GeneratedColumn<int?>(
      'transport_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES model_transport (transport_id)');
  final VerificationMeta _clientIdMeta = const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<int?> clientId = GeneratedColumn<int?>(
      'client_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES model_client (client_id)');
  final VerificationMeta _itemListMeta = const VerificationMeta('itemList');
  @override
  late final GeneratedColumnWithTypeConverter<ItemList, String?> itemList =
      GeneratedColumn<String?>('item_list', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<ItemList>($ModelReturnOrderTable.$converter0);
  final VerificationMeta _returnStatusMeta =
      const VerificationMeta('returnStatus');
  @override
  late final GeneratedColumn<String?> returnStatus = GeneratedColumn<String?>(
      'return_status', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  final VerificationMeta _totalSendAmountMeta =
      const VerificationMeta('totalSendAmount');
  @override
  late final GeneratedColumn<double?> totalSendAmount =
      GeneratedColumn<double?>('total_send_amount', aliasedName, false,
          type: const RealType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0.0));
  final VerificationMeta _netRefundMeta = const VerificationMeta('netRefund');
  @override
  late final GeneratedColumn<double?> netRefund = GeneratedColumn<double?>(
      'net_refund', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  final VerificationMeta _refundStatusMeta =
      const VerificationMeta('refundStatus');
  @override
  late final GeneratedColumn<String?> refundStatus = GeneratedColumn<String?>(
      'refund_status', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('unpaid'));
  final VerificationMeta _returnedByMeta = const VerificationMeta('returnedBy');
  @override
  late final GeneratedColumn<String?> returnedBy = GeneratedColumn<String?>(
      'returned_by', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _returnReasonMeta =
      const VerificationMeta('returnReason');
  @override
  late final GeneratedColumn<String?> returnReason = GeneratedColumn<String?>(
      'return_reason', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime?> lastUpdated =
      GeneratedColumn<DateTime?>('last_updated', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _expectedPickupDateMeta =
      const VerificationMeta('expectedPickupDate');
  @override
  late final GeneratedColumn<DateTime?> expectedPickupDate =
      GeneratedColumn<DateTime?>('expected_pickup_date', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        returnOrderId,
        orderId,
        transportId,
        clientId,
        itemList,
        returnStatus,
        totalSendAmount,
        netRefund,
        refundStatus,
        returnedBy,
        returnReason,
        lastUpdated,
        createdAt,
        expectedPickupDate
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
    if (data.containsKey('transport_id')) {
      context.handle(
          _transportIdMeta,
          transportId.isAcceptableOrUnknown(
              data['transport_id']!, _transportIdMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    context.handle(_itemListMeta, const VerificationResult.success());
    if (data.containsKey('return_status')) {
      context.handle(
          _returnStatusMeta,
          returnStatus.isAcceptableOrUnknown(
              data['return_status']!, _returnStatusMeta));
    }
    if (data.containsKey('total_send_amount')) {
      context.handle(
          _totalSendAmountMeta,
          totalSendAmount.isAcceptableOrUnknown(
              data['total_send_amount']!, _totalSendAmountMeta));
    }
    if (data.containsKey('net_refund')) {
      context.handle(_netRefundMeta,
          netRefund.isAcceptableOrUnknown(data['net_refund']!, _netRefundMeta));
    }
    if (data.containsKey('refund_status')) {
      context.handle(
          _refundStatusMeta,
          refundStatus.isAcceptableOrUnknown(
              data['refund_status']!, _refundStatusMeta));
    }
    if (data.containsKey('returned_by')) {
      context.handle(
          _returnedByMeta,
          returnedBy.isAcceptableOrUnknown(
              data['returned_by']!, _returnedByMeta));
    }
    if (data.containsKey('return_reason')) {
      context.handle(
          _returnReasonMeta,
          returnReason.isAcceptableOrUnknown(
              data['return_reason']!, _returnReasonMeta));
    } else if (isInserting) {
      context.missing(_returnReasonMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
          _lastUpdatedMeta,
          lastUpdated.isAcceptableOrUnknown(
              data['last_updated']!, _lastUpdatedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('expected_pickup_date')) {
      context.handle(
          _expectedPickupDateMeta,
          expectedPickupDate.isAcceptableOrUnknown(
              data['expected_pickup_date']!, _expectedPickupDateMeta));
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

  static TypeConverter<ItemList, String> $converter0 =
      const ItemListConverter();
}

class ModelPaymentData extends DataClass
    implements Insertable<ModelPaymentData> {
  final int paymentId;
  final int? deliveryOrderId;
  final int? returnOrderId;
  final double amount;
  final String paymentMode;
  final String paymentType;
  final String paymentFor;
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
      required this.paymentFor,
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
      paymentFor: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}payment_for'])!,
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
    map['payment_for'] = Variable<String>(paymentFor);
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
      paymentFor: Value(paymentFor),
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
      paymentFor: serializer.fromJson<String>(json['paymentFor']),
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
      'paymentFor': serializer.toJson<String>(paymentFor),
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
          String? paymentFor,
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
        paymentFor: paymentFor ?? this.paymentFor,
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
          ..write('paymentFor: $paymentFor, ')
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
      paymentFor,
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
          other.paymentFor == this.paymentFor &&
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
  final Value<String> paymentFor;
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
    this.paymentFor = const Value.absent(),
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
    required String paymentFor,
    this.paymentNote = const Value.absent(),
    required String receivedBy,
    required DateTime paymentDate,
    this.createdAt = const Value.absent(),
  })  : amount = Value(amount),
        paymentMode = Value(paymentMode),
        paymentType = Value(paymentType),
        paymentFor = Value(paymentFor),
        receivedBy = Value(receivedBy),
        paymentDate = Value(paymentDate);
  static Insertable<ModelPaymentData> custom({
    Expression<int>? paymentId,
    Expression<int?>? deliveryOrderId,
    Expression<int?>? returnOrderId,
    Expression<double>? amount,
    Expression<String>? paymentMode,
    Expression<String>? paymentType,
    Expression<String>? paymentFor,
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
      if (paymentFor != null) 'payment_for': paymentFor,
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
      Value<String>? paymentFor,
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
      paymentFor: paymentFor ?? this.paymentFor,
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
    if (paymentFor.present) {
      map['payment_for'] = Variable<String>(paymentFor.value);
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
          ..write('paymentFor: $paymentFor, ')
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
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'REFERENCES model_return_order (return_order_id)');
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
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _paymentTypeMeta =
      const VerificationMeta('paymentType');
  @override
  late final GeneratedColumn<String?> paymentType = GeneratedColumn<String?>(
      'payment_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _paymentForMeta = const VerificationMeta('paymentFor');
  @override
  late final GeneratedColumn<String?> paymentFor = GeneratedColumn<String?>(
      'payment_for', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
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
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        paymentId,
        deliveryOrderId,
        returnOrderId,
        amount,
        paymentMode,
        paymentType,
        paymentFor,
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
    if (data.containsKey('payment_for')) {
      context.handle(
          _paymentForMeta,
          paymentFor.isAcceptableOrUnknown(
              data['payment_for']!, _paymentForMeta));
    } else if (isInserting) {
      context.missing(_paymentForMeta);
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
  final SurveyItemList itemList;
  final String conductedBy;
  final DateTime createdAt;
  final DateTime lastUpdated;
  ModelSurveyData(
      {required this.surveyId,
      required this.clientId,
      required this.itemList,
      required this.conductedBy,
      required this.createdAt,
      required this.lastUpdated});
  factory ModelSurveyData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelSurveyData(
      surveyId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}survey_id'])!,
      clientId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_id'])!,
      itemList: $ModelSurveyTable.$converter0.mapToDart(const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_list']))!,
      conductedBy: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}conducted_by'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      lastUpdated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['survey_id'] = Variable<int>(surveyId);
    map['client_id'] = Variable<int>(clientId);
    {
      final converter = $ModelSurveyTable.$converter0;
      map['item_list'] = Variable<String>(converter.mapToSql(itemList)!);
    }
    map['conducted_by'] = Variable<String>(conductedBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  ModelSurveyCompanion toCompanion(bool nullToAbsent) {
    return ModelSurveyCompanion(
      surveyId: Value(surveyId),
      clientId: Value(clientId),
      itemList: Value(itemList),
      conductedBy: Value(conductedBy),
      createdAt: Value(createdAt),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory ModelSurveyData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelSurveyData(
      surveyId: serializer.fromJson<int>(json['surveyId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      itemList: serializer.fromJson<SurveyItemList>(json['itemList']),
      conductedBy: serializer.fromJson<String>(json['conductedBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surveyId': serializer.toJson<int>(surveyId),
      'clientId': serializer.toJson<int>(clientId),
      'itemList': serializer.toJson<SurveyItemList>(itemList),
      'conductedBy': serializer.toJson<String>(conductedBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  ModelSurveyData copyWith(
          {int? surveyId,
          int? clientId,
          SurveyItemList? itemList,
          String? conductedBy,
          DateTime? createdAt,
          DateTime? lastUpdated}) =>
      ModelSurveyData(
        surveyId: surveyId ?? this.surveyId,
        clientId: clientId ?? this.clientId,
        itemList: itemList ?? this.itemList,
        conductedBy: conductedBy ?? this.conductedBy,
        createdAt: createdAt ?? this.createdAt,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  @override
  String toString() {
    return (StringBuffer('ModelSurveyData(')
          ..write('surveyId: $surveyId, ')
          ..write('clientId: $clientId, ')
          ..write('itemList: $itemList, ')
          ..write('conductedBy: $conductedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      surveyId, clientId, itemList, conductedBy, createdAt, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelSurveyData &&
          other.surveyId == this.surveyId &&
          other.clientId == this.clientId &&
          other.itemList == this.itemList &&
          other.conductedBy == this.conductedBy &&
          other.createdAt == this.createdAt &&
          other.lastUpdated == this.lastUpdated);
}

class ModelSurveyCompanion extends UpdateCompanion<ModelSurveyData> {
  final Value<int> surveyId;
  final Value<int> clientId;
  final Value<SurveyItemList> itemList;
  final Value<String> conductedBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> lastUpdated;
  const ModelSurveyCompanion({
    this.surveyId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.itemList = const Value.absent(),
    this.conductedBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  ModelSurveyCompanion.insert({
    this.surveyId = const Value.absent(),
    required int clientId,
    required SurveyItemList itemList,
    required String conductedBy,
    this.createdAt = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  })  : clientId = Value(clientId),
        itemList = Value(itemList),
        conductedBy = Value(conductedBy);
  static Insertable<ModelSurveyData> custom({
    Expression<int>? surveyId,
    Expression<int>? clientId,
    Expression<SurveyItemList>? itemList,
    Expression<String>? conductedBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (surveyId != null) 'survey_id': surveyId,
      if (clientId != null) 'client_id': clientId,
      if (itemList != null) 'item_list': itemList,
      if (conductedBy != null) 'conducted_by': conductedBy,
      if (createdAt != null) 'created_at': createdAt,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  ModelSurveyCompanion copyWith(
      {Value<int>? surveyId,
      Value<int>? clientId,
      Value<SurveyItemList>? itemList,
      Value<String>? conductedBy,
      Value<DateTime>? createdAt,
      Value<DateTime>? lastUpdated}) {
    return ModelSurveyCompanion(
      surveyId: surveyId ?? this.surveyId,
      clientId: clientId ?? this.clientId,
      itemList: itemList ?? this.itemList,
      conductedBy: conductedBy ?? this.conductedBy,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,
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
    if (itemList.present) {
      final converter = $ModelSurveyTable.$converter0;
      map['item_list'] = Variable<String>(converter.mapToSql(itemList.value)!);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelSurveyCompanion(')
          ..write('surveyId: $surveyId, ')
          ..write('clientId: $clientId, ')
          ..write('itemList: $itemList, ')
          ..write('conductedBy: $conductedBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastUpdated: $lastUpdated')
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
  final VerificationMeta _itemListMeta = const VerificationMeta('itemList');
  @override
  late final GeneratedColumnWithTypeConverter<SurveyItemList, String?>
      itemList = GeneratedColumn<String?>('item_list', aliasedName, false,
              type: const StringType(), requiredDuringInsert: true)
          .withConverter<SurveyItemList>($ModelSurveyTable.$converter0);
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
      defaultValue: currentDateAndTime);
  final VerificationMeta _lastUpdatedMeta =
      const VerificationMeta('lastUpdated');
  @override
  late final GeneratedColumn<DateTime?> lastUpdated =
      GeneratedColumn<DateTime?>('last_updated', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [surveyId, clientId, itemList, conductedBy, createdAt, lastUpdated];
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
    context.handle(_itemListMeta, const VerificationResult.success());
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

  static TypeConverter<SurveyItemList, String> $converter0 =
      const SurveyItemListConverter();
}

class ModelStatusGroupData extends DataClass
    implements Insertable<ModelStatusGroupData> {
  final int statusGroupId;
  final String value;
  final String groupName;
  ModelStatusGroupData(
      {required this.statusGroupId,
      required this.value,
      required this.groupName});
  factory ModelStatusGroupData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelStatusGroupData(
      statusGroupId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status_group_id'])!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
      groupName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}group_name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['status_group_id'] = Variable<int>(statusGroupId);
    map['value'] = Variable<String>(value);
    map['group_name'] = Variable<String>(groupName);
    return map;
  }

  ModelStatusGroupCompanion toCompanion(bool nullToAbsent) {
    return ModelStatusGroupCompanion(
      statusGroupId: Value(statusGroupId),
      value: Value(value),
      groupName: Value(groupName),
    );
  }

  factory ModelStatusGroupData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelStatusGroupData(
      statusGroupId: serializer.fromJson<int>(json['statusGroupId']),
      value: serializer.fromJson<String>(json['value']),
      groupName: serializer.fromJson<String>(json['groupName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'statusGroupId': serializer.toJson<int>(statusGroupId),
      'value': serializer.toJson<String>(value),
      'groupName': serializer.toJson<String>(groupName),
    };
  }

  ModelStatusGroupData copyWith(
          {int? statusGroupId, String? value, String? groupName}) =>
      ModelStatusGroupData(
        statusGroupId: statusGroupId ?? this.statusGroupId,
        value: value ?? this.value,
        groupName: groupName ?? this.groupName,
      );
  @override
  String toString() {
    return (StringBuffer('ModelStatusGroupData(')
          ..write('statusGroupId: $statusGroupId, ')
          ..write('value: $value, ')
          ..write('groupName: $groupName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(statusGroupId, value, groupName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelStatusGroupData &&
          other.statusGroupId == this.statusGroupId &&
          other.value == this.value &&
          other.groupName == this.groupName);
}

class ModelStatusGroupCompanion extends UpdateCompanion<ModelStatusGroupData> {
  final Value<int> statusGroupId;
  final Value<String> value;
  final Value<String> groupName;
  const ModelStatusGroupCompanion({
    this.statusGroupId = const Value.absent(),
    this.value = const Value.absent(),
    this.groupName = const Value.absent(),
  });
  ModelStatusGroupCompanion.insert({
    this.statusGroupId = const Value.absent(),
    required String value,
    required String groupName,
  })  : value = Value(value),
        groupName = Value(groupName);
  static Insertable<ModelStatusGroupData> custom({
    Expression<int>? statusGroupId,
    Expression<String>? value,
    Expression<String>? groupName,
  }) {
    return RawValuesInsertable({
      if (statusGroupId != null) 'status_group_id': statusGroupId,
      if (value != null) 'value': value,
      if (groupName != null) 'group_name': groupName,
    });
  }

  ModelStatusGroupCompanion copyWith(
      {Value<int>? statusGroupId,
      Value<String>? value,
      Value<String>? groupName}) {
    return ModelStatusGroupCompanion(
      statusGroupId: statusGroupId ?? this.statusGroupId,
      value: value ?? this.value,
      groupName: groupName ?? this.groupName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (statusGroupId.present) {
      map['status_group_id'] = Variable<int>(statusGroupId.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (groupName.present) {
      map['group_name'] = Variable<String>(groupName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelStatusGroupCompanion(')
          ..write('statusGroupId: $statusGroupId, ')
          ..write('value: $value, ')
          ..write('groupName: $groupName')
          ..write(')'))
        .toString();
  }
}

class $ModelStatusGroupTable extends ModelStatusGroup
    with TableInfo<$ModelStatusGroupTable, ModelStatusGroupData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelStatusGroupTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _statusGroupIdMeta =
      const VerificationMeta('statusGroupId');
  @override
  late final GeneratedColumn<int?> statusGroupId = GeneratedColumn<int?>(
      'status_group_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _groupNameMeta = const VerificationMeta('groupName');
  @override
  late final GeneratedColumn<String?> groupName = GeneratedColumn<String?>(
      'group_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [statusGroupId, value, groupName];
  @override
  String get aliasedName => _alias ?? 'model_status_group';
  @override
  String get actualTableName => 'model_status_group';
  @override
  VerificationContext validateIntegrity(
      Insertable<ModelStatusGroupData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('status_group_id')) {
      context.handle(
          _statusGroupIdMeta,
          statusGroupId.isAcceptableOrUnknown(
              data['status_group_id']!, _statusGroupIdMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('group_name')) {
      context.handle(_groupNameMeta,
          groupName.isAcceptableOrUnknown(data['group_name']!, _groupNameMeta));
    } else if (isInserting) {
      context.missing(_groupNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {statusGroupId};
  @override
  ModelStatusGroupData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ModelStatusGroupData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelStatusGroupTable createAlias(String alias) {
    return $ModelStatusGroupTable(attachedDatabase, alias);
  }
}

class ModelClientItemRecordData extends DataClass
    implements Insertable<ModelClientItemRecordData> {
  final int clientId;
  final int itemId;
  final String itemName;
  final String unit;
  final double availableQuantity;
  final DateTime lastUpdatedOn;
  final DateTime lastSurveyedOn;
  ModelClientItemRecordData(
      {required this.clientId,
      required this.itemId,
      required this.itemName,
      required this.unit,
      required this.availableQuantity,
      required this.lastUpdatedOn,
      required this.lastSurveyedOn});
  factory ModelClientItemRecordData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ModelClientItemRecordData(
      clientId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}client_id'])!,
      itemId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_id'])!,
      itemName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_name'])!,
      unit: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}unit'])!,
      availableQuantity: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}available_quantity'])!,
      lastUpdatedOn: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_updated_on'])!,
      lastSurveyedOn: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_surveyed_on'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_id'] = Variable<int>(clientId);
    map['item_id'] = Variable<int>(itemId);
    map['item_name'] = Variable<String>(itemName);
    map['unit'] = Variable<String>(unit);
    map['available_quantity'] = Variable<double>(availableQuantity);
    map['last_updated_on'] = Variable<DateTime>(lastUpdatedOn);
    map['last_surveyed_on'] = Variable<DateTime>(lastSurveyedOn);
    return map;
  }

  ModelClientItemRecordCompanion toCompanion(bool nullToAbsent) {
    return ModelClientItemRecordCompanion(
      clientId: Value(clientId),
      itemId: Value(itemId),
      itemName: Value(itemName),
      unit: Value(unit),
      availableQuantity: Value(availableQuantity),
      lastUpdatedOn: Value(lastUpdatedOn),
      lastSurveyedOn: Value(lastSurveyedOn),
    );
  }

  factory ModelClientItemRecordData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelClientItemRecordData(
      clientId: serializer.fromJson<int>(json['clientId']),
      itemId: serializer.fromJson<int>(json['itemId']),
      itemName: serializer.fromJson<String>(json['itemName']),
      unit: serializer.fromJson<String>(json['unit']),
      availableQuantity: serializer.fromJson<double>(json['availableQuantity']),
      lastUpdatedOn: serializer.fromJson<DateTime>(json['lastUpdatedOn']),
      lastSurveyedOn: serializer.fromJson<DateTime>(json['lastSurveyedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientId': serializer.toJson<int>(clientId),
      'itemId': serializer.toJson<int>(itemId),
      'itemName': serializer.toJson<String>(itemName),
      'unit': serializer.toJson<String>(unit),
      'availableQuantity': serializer.toJson<double>(availableQuantity),
      'lastUpdatedOn': serializer.toJson<DateTime>(lastUpdatedOn),
      'lastSurveyedOn': serializer.toJson<DateTime>(lastSurveyedOn),
    };
  }

  ModelClientItemRecordData copyWith(
          {int? clientId,
          int? itemId,
          String? itemName,
          String? unit,
          double? availableQuantity,
          DateTime? lastUpdatedOn,
          DateTime? lastSurveyedOn}) =>
      ModelClientItemRecordData(
        clientId: clientId ?? this.clientId,
        itemId: itemId ?? this.itemId,
        itemName: itemName ?? this.itemName,
        unit: unit ?? this.unit,
        availableQuantity: availableQuantity ?? this.availableQuantity,
        lastUpdatedOn: lastUpdatedOn ?? this.lastUpdatedOn,
        lastSurveyedOn: lastSurveyedOn ?? this.lastSurveyedOn,
      );
  @override
  String toString() {
    return (StringBuffer('ModelClientItemRecordData(')
          ..write('clientId: $clientId, ')
          ..write('itemId: $itemId, ')
          ..write('itemName: $itemName, ')
          ..write('unit: $unit, ')
          ..write('availableQuantity: $availableQuantity, ')
          ..write('lastUpdatedOn: $lastUpdatedOn, ')
          ..write('lastSurveyedOn: $lastSurveyedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clientId, itemId, itemName, unit,
      availableQuantity, lastUpdatedOn, lastSurveyedOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelClientItemRecordData &&
          other.clientId == this.clientId &&
          other.itemId == this.itemId &&
          other.itemName == this.itemName &&
          other.unit == this.unit &&
          other.availableQuantity == this.availableQuantity &&
          other.lastUpdatedOn == this.lastUpdatedOn &&
          other.lastSurveyedOn == this.lastSurveyedOn);
}

class ModelClientItemRecordCompanion
    extends UpdateCompanion<ModelClientItemRecordData> {
  final Value<int> clientId;
  final Value<int> itemId;
  final Value<String> itemName;
  final Value<String> unit;
  final Value<double> availableQuantity;
  final Value<DateTime> lastUpdatedOn;
  final Value<DateTime> lastSurveyedOn;
  const ModelClientItemRecordCompanion({
    this.clientId = const Value.absent(),
    this.itemId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.unit = const Value.absent(),
    this.availableQuantity = const Value.absent(),
    this.lastUpdatedOn = const Value.absent(),
    this.lastSurveyedOn = const Value.absent(),
  });
  ModelClientItemRecordCompanion.insert({
    required int clientId,
    required int itemId,
    required String itemName,
    required String unit,
    required double availableQuantity,
    this.lastUpdatedOn = const Value.absent(),
    this.lastSurveyedOn = const Value.absent(),
  })  : clientId = Value(clientId),
        itemId = Value(itemId),
        itemName = Value(itemName),
        unit = Value(unit),
        availableQuantity = Value(availableQuantity);
  static Insertable<ModelClientItemRecordData> custom({
    Expression<int>? clientId,
    Expression<int>? itemId,
    Expression<String>? itemName,
    Expression<String>? unit,
    Expression<double>? availableQuantity,
    Expression<DateTime>? lastUpdatedOn,
    Expression<DateTime>? lastSurveyedOn,
  }) {
    return RawValuesInsertable({
      if (clientId != null) 'client_id': clientId,
      if (itemId != null) 'item_id': itemId,
      if (itemName != null) 'item_name': itemName,
      if (unit != null) 'unit': unit,
      if (availableQuantity != null) 'available_quantity': availableQuantity,
      if (lastUpdatedOn != null) 'last_updated_on': lastUpdatedOn,
      if (lastSurveyedOn != null) 'last_surveyed_on': lastSurveyedOn,
    });
  }

  ModelClientItemRecordCompanion copyWith(
      {Value<int>? clientId,
      Value<int>? itemId,
      Value<String>? itemName,
      Value<String>? unit,
      Value<double>? availableQuantity,
      Value<DateTime>? lastUpdatedOn,
      Value<DateTime>? lastSurveyedOn}) {
    return ModelClientItemRecordCompanion(
      clientId: clientId ?? this.clientId,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      unit: unit ?? this.unit,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      lastUpdatedOn: lastUpdatedOn ?? this.lastUpdatedOn,
      lastSurveyedOn: lastSurveyedOn ?? this.lastSurveyedOn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (availableQuantity.present) {
      map['available_quantity'] = Variable<double>(availableQuantity.value);
    }
    if (lastUpdatedOn.present) {
      map['last_updated_on'] = Variable<DateTime>(lastUpdatedOn.value);
    }
    if (lastSurveyedOn.present) {
      map['last_surveyed_on'] = Variable<DateTime>(lastSurveyedOn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelClientItemRecordCompanion(')
          ..write('clientId: $clientId, ')
          ..write('itemId: $itemId, ')
          ..write('itemName: $itemName, ')
          ..write('unit: $unit, ')
          ..write('availableQuantity: $availableQuantity, ')
          ..write('lastUpdatedOn: $lastUpdatedOn, ')
          ..write('lastSurveyedOn: $lastSurveyedOn')
          ..write(')'))
        .toString();
  }
}

class $ModelClientItemRecordTable extends ModelClientItemRecord
    with TableInfo<$ModelClientItemRecordTable, ModelClientItemRecordData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelClientItemRecordTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _clientIdMeta = const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<int?> clientId = GeneratedColumn<int?>(
      'client_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int?> itemId = GeneratedColumn<int?>(
      'item_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _itemNameMeta = const VerificationMeta('itemName');
  @override
  late final GeneratedColumn<String?> itemName = GeneratedColumn<String?>(
      'item_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String?> unit = GeneratedColumn<String?>(
      'unit', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _availableQuantityMeta =
      const VerificationMeta('availableQuantity');
  @override
  late final GeneratedColumn<double?> availableQuantity =
      GeneratedColumn<double?>('available_quantity', aliasedName, false,
          type: const RealType(), requiredDuringInsert: true);
  final VerificationMeta _lastUpdatedOnMeta =
      const VerificationMeta('lastUpdatedOn');
  @override
  late final GeneratedColumn<DateTime?> lastUpdatedOn =
      GeneratedColumn<DateTime?>('last_updated_on', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  final VerificationMeta _lastSurveyedOnMeta =
      const VerificationMeta('lastSurveyedOn');
  @override
  late final GeneratedColumn<DateTime?> lastSurveyedOn =
      GeneratedColumn<DateTime?>('last_surveyed_on', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        clientId,
        itemId,
        itemName,
        unit,
        availableQuantity,
        lastUpdatedOn,
        lastSurveyedOn
      ];
  @override
  String get aliasedName => _alias ?? 'model_client_item_record';
  @override
  String get actualTableName => 'model_client_item_record';
  @override
  VerificationContext validateIntegrity(
      Insertable<ModelClientItemRecordData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('available_quantity')) {
      context.handle(
          _availableQuantityMeta,
          availableQuantity.isAcceptableOrUnknown(
              data['available_quantity']!, _availableQuantityMeta));
    } else if (isInserting) {
      context.missing(_availableQuantityMeta);
    }
    if (data.containsKey('last_updated_on')) {
      context.handle(
          _lastUpdatedOnMeta,
          lastUpdatedOn.isAcceptableOrUnknown(
              data['last_updated_on']!, _lastUpdatedOnMeta));
    }
    if (data.containsKey('last_surveyed_on')) {
      context.handle(
          _lastSurveyedOnMeta,
          lastSurveyedOn.isAcceptableOrUnknown(
              data['last_surveyed_on']!, _lastSurveyedOnMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientId, itemId};
  @override
  ModelClientItemRecordData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return ModelClientItemRecordData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ModelClientItemRecordTable createAlias(String alias) {
    return $ModelClientItemRecordTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ModelClientTable modelClient = $ModelClientTable(this);
  late final $ModelItemTable modelItem = $ModelItemTable(this);
  late final $ModelVehicleTable modelVehicle = $ModelVehicleTable(this);
  late final $ModelTransportTable modelTransport = $ModelTransportTable(this);
  late final $ModelDeliveryOrderTable modelDeliveryOrder =
      $ModelDeliveryOrderTable(this);
  late final $ModelReturnOrderTable modelReturnOrder =
      $ModelReturnOrderTable(this);
  late final $ModelPaymentTable modelPayment = $ModelPaymentTable(this);
  late final $ModelSurveyTable modelSurvey = $ModelSurveyTable(this);
  late final $ModelStatusGroupTable modelStatusGroup =
      $ModelStatusGroupTable(this);
  late final $ModelClientItemRecordTable modelClientItemRecord =
      $ModelClientItemRecordTable(this);
  late final ClientTableQueries clientTableQueries =
      ClientTableQueries(this as AppDatabase);
  late final ItemTableQueries itemTableQueries =
      ItemTableQueries(this as AppDatabase);
  late final VehicleTableQueries vehicleTableQueries =
      VehicleTableQueries(this as AppDatabase);
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
  late final StatusGroupTableQueries statusGroupTableQueries =
      StatusGroupTableQueries(this as AppDatabase);
  late final ClientItemTableQueries clientItemTableQueries =
      ClientItemTableQueries(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        modelClient,
        modelItem,
        modelVehicle,
        modelTransport,
        modelDeliveryOrder,
        modelReturnOrder,
        modelPayment,
        modelSurvey,
        modelStatusGroup,
        modelClientItemRecord
      ];
}
