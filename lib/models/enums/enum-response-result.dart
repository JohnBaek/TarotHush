import 'package:flutter/foundation.dart';

/// 공통 응답 결과 enum 타입
enum EnumResponseResult {
  // 응답 성공
  success ,
  // 응답 에러 
  error ,
  // 응답 경고
  warning ,
}

/// 공통 응답 결과 타입 [EnumResponseResult] 에 대한 확장
extension EnumResponseResultExtension on EnumResponseResult {
  /// [name] EnumResponseResult 에대한 describeEnum 을 리턴한다.
  String get name => describeEnum(this);
  
  /// [displayName] 결과 값에 대한 화면에 표시될 내용을 표시 한다.
  String get displayName {
    switch(this) {
      case EnumResponseResult.success :
        return "성공";
      case EnumResponseResult.error:
        return "에러";
      case EnumResponseResult.warning:
        return "경고";
    }
  }
}