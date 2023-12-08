import 'package:flutter/foundation.dart';

/// 에러 핸들링 클래스 
class ErrorHandler {
  /// 에러 로그를 기록한다.
  static void log(Object ex) {
    // 디버그 모드일 경우 
    if (kDebugMode) {
      print(ex);
    }
  } 
}