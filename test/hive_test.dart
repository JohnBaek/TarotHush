import 'dart:io';

import 'package:fluent_assertions/fluent_assertions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:my_app/models/hive/hive-diary-detail.dart';
import 'package:my_app/models/hive/hive-diary.dart';
import 'package:uuid/uuid.dart';

/**
 * Hive 유닛 테스트
 */
Future<void> main() async {
  // Hive 로컬 데이터베이스 이니셜라이즈
  // /Users/john/Library/Containers/com.example.myApp/Data
  Hive
    ..init(Directory.current.path)
    // 어댑터를 등록 한다.
    ..registerAdapter(HiveDiaryAdapter())
    ..registerAdapter(HiveDiaryDetailAdapter());

  // 다이어리 테이블을 연다.
  Box<HiveDiary> diaryBox = await Hive.openBox<HiveDiary>('diary');
  
  /// 조회를 테스트한다.
  test('Can Retrieve From Diary',() async {
    //removeAll(diaryBox);
    
    // 더미로 데이터를 하나 추가한다.
    addDummyData(diaryBox);
    
    // 가장 위의 있는 데이터를 하나 가져온다.
    HiveDiary? item = diaryBox.getAt(0);
    item.shouldNotBeNull();
    
    // 모든 데이터를 가져온다.
    List<HiveDiary> items = diaryBox.values.toList(growable: true);
    print("items count : ${items.length}");
    
    // 한개이상의 리스트가 존재 해야한다.
    items.length.shouldBeGreaterOrEqualTo(0);
  });
  
  /// 박스로부터 데이터의 키를 모두 조회해 올수 있는지
  testWidgets('Can get Retrieve all keys from box', (WidgetTester widgetTester) async {
    // 더미로 데이터를 하나 추가한다.
    addDummyData(diaryBox);
    
    // 모든 키를 조회한다.
    List keys = diaryBox.keys.toList();
    
    // 한개이상 존재해야한다.
    keys.length.shouldBeGreaterOrEqualTo(0);
    
    // 모든 키를 조회한다.
    for(var key in keys) {
      print("key : ${key.toString()}");
    }
  });
  
  /// 박스로부터 하나의 데이터를 조회해 올수 있는지
  testWidgets('Can get Retrieve data from box', (WidgetTester widgetTester) async {
    // 더미로 데이터를 하나 추가한다.
    addDummyData(diaryBox);

    // 모든 키를 조회한다.
    List<HiveDiary> items = diaryBox.values.toList(growable: true);
    items.length.shouldBeGreaterOrEqualTo(0);
    
    // 조회해온 데이터로 부터 아이템을 하나 가져온다.
    HiveDiary item = items[0];
    item.shouldNotBeNull();

    // 키를 이용해 데이터를 가져온다.
    HiveDiary? found = diaryBox.get(item.id);
    found.shouldNotBeNull();
    
    if(found != null) {
      print("found regDate is ${found.regDate}");
    }
  });
  
  // 박스로부터 하나의 데이터를 지울수 있는지
  test('Can remove data from box', () async {

    // diaryBox.keys.forEach((element) { 
    //   print(element);
    //   List<String> keys = [element.toString()];
    //   diaryBox.deleteAll(keys);
    // });
    
    // 더미로 데이터를 하나 추가한다.
    String id = addDummyDataWithReturn(diaryBox);
    id.shouldNotBeNull();
    id.shouldNotBeBlank();

    // 데이터를 조회한다.
    HiveDiary? item = diaryBox.get(id);
    item.shouldNotBeNull();

    // 데이터가 존재하지 않을경우 
    if(item == null)
      return;

    // 데이터를 지운다.
    print("Current Count : ${ diaryBox.keys.length }");
    await diaryBox.delete(id);
    print("Delete successed Current Count : ${ diaryBox.keys.length }");
    await diaryBox.close();
  });
}

/// 테스트를 위해 더미 데이터를 하나 추가한다.
void addDummyData(Box<HiveDiary> box) {
  // 사용할 아이디를 입력한다.
  String id = const Uuid().v4();

  // 데이터를 추가한다.
  box.put(id,HiveDiary(id:id,regDate: DateTime.now()));
}

/// 테스트를 위해 더미 데이터를 하나 추가한다.
String addDummyDataWithReturn(Box<HiveDiary> box) {
  // 사용할 아이디를 입력한다.
  String id = const Uuid().v4();

  // 데이터를 추가한다.
  box.put(id,HiveDiary(id:id,regDate: DateTime.now()));
  return id;
}

/// 데이터를 초기화 한다.
void removeAll(Box<HiveDiary> box) {
  // 전체 숫자를 가져온다.
  int totalCount = box.values.toList().length;
  
  // 진행 숫자
  int processCount = 0;
  
  print("Remove all datas ..");
  box.deleteAll(box.keys);
  //
  //
  // // 가져온 모든 데이터에 대해 처리한다
  // box.values.toList().forEach((element) async {
  //   // 데이터를 삭제한다
  //   element.delete;
  // });
  
}

 