// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_features_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActiveFeaturesModelAdapter extends TypeAdapter<ActiveFeaturesModel> {
  @override
  final int typeId = 3;

  @override
  ActiveFeaturesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActiveFeaturesModel(
      disableDetails: fields[0] as bool,
      disableClient: fields[1] as bool,
      disableItem: fields[2] as bool,
      disableTrade: fields[3] as bool,
      disableOrder: fields[4] as bool,
      disableDelivery: fields[5] as bool,
      disableReturn: fields[6] as bool,
      disableRecords: fields[7] as bool,
      disablePayment: fields[8] as bool,
      disableReceive: fields[9] as bool,
      disableHistory: fields[10] as bool,
      disableReport: fields[11] as bool,
      disableSurvey: fields[12] as bool,
      disableStats: fields[13] as bool,
      disableSend: fields[14] as bool,
      disableVehicle: fields[15] as bool,
      disableTrip: fields[16] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ActiveFeaturesModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.disableDetails)
      ..writeByte(1)
      ..write(obj.disableClient)
      ..writeByte(2)
      ..write(obj.disableItem)
      ..writeByte(3)
      ..write(obj.disableTrade)
      ..writeByte(4)
      ..write(obj.disableOrder)
      ..writeByte(5)
      ..write(obj.disableDelivery)
      ..writeByte(6)
      ..write(obj.disableReturn)
      ..writeByte(7)
      ..write(obj.disableRecords)
      ..writeByte(8)
      ..write(obj.disablePayment)
      ..writeByte(9)
      ..write(obj.disableReceive)
      ..writeByte(10)
      ..write(obj.disableHistory)
      ..writeByte(11)
      ..write(obj.disableReport)
      ..writeByte(12)
      ..write(obj.disableSurvey)
      ..writeByte(13)
      ..write(obj.disableStats)
      ..writeByte(14)
      ..write(obj.disableSend)
      ..writeByte(15)
      ..write(obj.disableVehicle)
      ..writeByte(16)
      ..write(obj.disableTrip);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveFeaturesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
