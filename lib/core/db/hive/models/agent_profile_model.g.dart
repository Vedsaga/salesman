// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgentProfileModelAdapter extends TypeAdapter<AgentProfileModel> {
  @override
  final int typeId = 0;

  @override
  AgentProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AgentProfileModel(
      name: fields[0] as String,
      phone: fields[1] as String,
      username: fields[2] as String,
      lastUpdated: fields[3] as DateTime,
      createdAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AgentProfileModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.lastUpdated)
      ..writeByte(4)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgentProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
