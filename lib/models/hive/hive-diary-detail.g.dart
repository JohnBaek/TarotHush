// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive-diary-detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveDiaryDetailAdapter extends TypeAdapter<HiveDiaryDetail> {
  @override
  final int typeId = 1;

  @override
  HiveDiaryDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveDiaryDetail(
      id: fields[0] as String,
      diaryId: fields[1] as String,
      imagePath: fields[2] as String,
      sequence: fields[3] as int,
      regDate: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, HiveDiaryDetail obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.diaryId)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.sequence)
      ..writeByte(4)
      ..write(obj.regDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveDiaryDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
