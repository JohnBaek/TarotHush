import 'package:fluent_assertions/fluent_assertions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/models/enums/enum-response-result.dart';

/// enum 기본 기능에 대한 테스트 클래스
Future<void> main() async {
  /// 조회를 테스트한다.
  test('enum 으로부터 name 프러퍼티를 가져올수 있는지',() async {
    // 비어있지 않아야 한다.
    EnumResponseResult.success.name.shouldNotBeBlank();
    
    // "success" 를 반환해야한다.
    EnumResponseResult.success.name.shouldBe("success");
    
    // "성공" 을 반환 해야 한다.
    EnumResponseResult.success.displayName.shouldBe("성공");
  });
}