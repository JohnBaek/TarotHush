import 'package:flutter/foundation.dart';

/// 로거 클래스
class Logger {
  /// 에러 로그를 기록 한다.
  /// [ex] Exception 객체
  static void error(Object ex) {
    // 디버그 모드일 경우 
    if (kDebugMode) {
      print(ex);
    }
  } 
  
  /// 로그를 기록한다.
  /// [message] 로그 메세지 
  static void log(String message) {
    // 디버그 모드일 경우 
    if (kDebugMode) {
      print(message);
    }
  }
}