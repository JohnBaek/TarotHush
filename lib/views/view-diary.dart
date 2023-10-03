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
                // 3카드 스프레드 버튼
                ComponentButton(name: '3Card Spread', 
                    onTap:(){
                      selectSpread(context,EnumSpreadType.threeCardSpread);
                    } , color: Colors.blueAccent)
              ],
            )
          ],
        )
    );
  }

  /// 타로 카드 스프레드를 선택한다.
  selectSpread(BuildContext context, EnumSpreadType enumSpreadType) {
    // 타로 카드 셀렉터 컨트롤러를 가져온다.
    TarotCardSelectorController controller = Get.find<TarotCardSelectorController>();
    
    // 카드를 셔플한다.
    controller.shuffleCard();
    
    // 카드 선택 갯수를 세팅한다.
    controller.setCompleteCount(enumSpreadType);
    
    // 카드 셀렉터 화면을 부른다.
    showDialog(
        context: context,
        // 선택한 카드 갯수와 , 완료해야하는 타로 개수가 일치하는경우 
        barrierDismissible: false, 
        builder: (BuildContext context) {
          
          // 컨텍스트가 바인딩되기 전인경우 
          if(controller.tarotSelectorContext == null) {
            controller.setContext(context);
          }
          
          return const ComponentTarotSelector();
        },
    );
  }
}
