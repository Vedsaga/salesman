// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_profile_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompanyProfileModelAdapter extends TypeAdapter<CompanyProfileModel> {
  @override
  final int typeId = 1;

  @override
  CompanyProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyProfileModel(
      name: fields[0] as String,
      lastUpdated: fields[1] as DateTime,
      createdAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyProfileModel obj) {
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
      other is CompanyProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
