// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HivePhotoAdapter extends TypeAdapter<HivePhoto> {
  @override
  final int typeId = 0;

  @override
  HivePhoto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HivePhoto(
      image: fields[1] as File,
      id: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HivePhoto obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HivePhotoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
