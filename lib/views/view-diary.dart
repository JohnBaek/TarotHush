import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/components/component-button.dart';
import 'package:my_app/components/component-card-view.dart';
import '../../models/enums/enum-spread-type.dart';
import '../components/tarotcard/component-tarot-selector.dart';
import '../controllers/controller-tarot-card-list.dart';

/// 다이어리 뷰 페이지 
class ViewDiary extends StatelessWidget {
  const ViewDiary({Key? key}): super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: 
        Stack(
          children: [
            ListView(
              children: [
                ComponentCardView(child: Text("asdfasdfasdf"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ComponentButton(name: '3Card Spread', onTap: selectSpread(context,EnumSpreadType.threeCardSpread), color: Colors.blueAccent)
              ],
            )
          ],
        )
    );
  }

  /// 타로 카드 스프레드를 선택한다.
  selectSpread(BuildContext context, EnumSpreadType threeCardSpread) {
    // 카드를 셔플한다.
    Get.find<TarotCardListController>().shuffleCard();
    
    // 카드 셀렉터 화면을 부른다.
    // showDialog(
    //     context: context,
    //     barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
    //     builder: (BuildContext context) {
    //       return ComponentTarotSelector();
    //     }
    // );
  }
}
