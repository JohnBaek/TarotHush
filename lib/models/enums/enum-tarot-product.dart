import 'package:hive/hive.dart';

/// 타로 제품 타입
enum EnumTarotProduct {
  // 라이더 웨이트
  riderWaited ,
  // 유니버셜 웨이트
  universalWaited ,
}

class HiveEnumTarotProductAdapter extends TypeAdapter<EnumTarotProduct> {
  @override
  final int typeId = 2; // Assign a unique typeId for your Enum

  @override
  EnumTarotProduct read(BinaryReader reader) {
    return EnumTarotProduct.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, EnumTarotProduct obj) {
    writer.writeByte(obj.index);
  }
}