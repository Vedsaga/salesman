// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompanyProfileAdapter extends TypeAdapter<CompanyProfile> {
  @override
  final int typeId = 1;

  @override
  CompanyProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyProfile(
      name: fields[0] as String,
      lastUpdated: fields[1] as DateTime,
      createdAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyProfile obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lastUpdated)
      ..writeByte(2)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
