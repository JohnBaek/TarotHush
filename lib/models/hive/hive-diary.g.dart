// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive-diary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDiaryAdapter extends TypeAdapter<HiveDiary> {
  @override
  final int typeId = 0;

  @override
  HiveDiary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDiary(
      id: fields[0] as String,
      regDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDiary obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.regDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDiaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
