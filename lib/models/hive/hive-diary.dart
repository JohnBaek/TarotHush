import 'package:hive/hive.dart';

part "hive-diary.g.dart";

/// 다이어리 저장된 요소들상위 테이블
@HiveType(typeId: 0)
class HiveDiary {
  // 아이디 값 
  @HiveField(1)
  String id;
  
  // 카드 등록시간
  @HiveField(2)
  DateTime regDate;

  /// 생성자
  HiveDiary({
    required this.id, 
    required this.regDate
  });
}