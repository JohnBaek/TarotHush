import 'package:flutter/foundation.dart';

/// 타로 스프레드 enum 타입 
enum EnumCardSpreadType {
  // 1카드 스프레드
  oneCardSpread ,
  // 3카드 스프레드
  threeCardSpread ,
}

/// 공통 응답 결과 타입 [EnumCardSpreadType] 에 대한 확장
extension EnumSpreadTypeExtension on EnumCardSpreadType {
  /// [name] EnumResponseResult 에대한 describeEnum 을 리턴 한다.
  String get name => describeEnum(this);

  /// [displayName] 결과 값에 대한 화면에 표시될 내용을 표시 한다.
  String get displayName {
    switch(this) {
      case EnumCardSpreadType.oneCardSpread :
        return "1 카드 스프레드";
      case EnumCardSpreadType.threeCardSpread:
        return "3 카드 스프레드";
    }
  }
}