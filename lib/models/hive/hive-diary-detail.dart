import 'package:hive/hive.dart';

import '../enums/enum-tarot-product.dart';
import 'hive-tarot-card-metadata.dart';

part "hive-diary-detail.g.dart";

/// 스프레드에서 타롯을 선택 후 로컬 데이터베이스에 저장하기위한 모델
@HiveType(typeId: 1)
class HiveDiaryDetail {
  // 아이디 값 
  @HiveField(0)
  String id;
  
  // 다이어리 아이디 값 
  @HiveField(1)
  String diaryId;
  
  // 선택한 카드 데이터
  @HiveField(2)
  HiveTarotCardMetadata metadata;

  // 카드 시퀀스 번호
  @HiveField(3)
  int sequence;
  
  // 카드 등록시간
  @HiveField(4)
  DateTime regDate;

  // 카드 종류
  @HiveField(5)
  EnumTarotProduct enumTarotProduct;

  HiveDiaryDetail({
    required this.id
    , required this.diaryId
    , required this.metadata
    , required this.sequence
    , required this.regDate
    , required this.enumTarotProduct
    });
}