import 'package:hive/hive.dart';

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
  
  // 카드 이미지 경로
  @HiveField(2)
  String imagePath;

  // 카드 시퀀스 번호
  @HiveField(3)
  int sequence;
  
  // 카드 등록시간
  @HiveField(4)
  DateTime regDate;

  /// 생성자
  HiveDiaryDetail({
      required this.id
    , required this.diaryId
    , required this.imagePath
    , required this.sequence
    , required this.regDate});
}