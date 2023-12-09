import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_app/components/component-button.dart';
import 'package:my_app/components/component-card-view.dart';
import 'package:my_app/models/enums/enum-response-result.dart';
import 'package:my_app/views/view-diary-controller.dart';

import '../../models/enums/enum-spread-type.dart';
import '../components/tarotcard/component-tarot-card-front.dart';
import '../components/tarotcard/component-tarot-selector.dart';
import '../controllers/controller-tarot-card-list.dart';
import '../models/responses/ResponseDiary.dart';
import '../models/responses/ResponseList.dart';
import '../providers/tarot-card-provider.dart';

/// 다이어리 뷰 페이지 
class ViewDiary extends StatelessWidget {
  const ViewDiary({Key? key}): super(key:key);
  @override
  Widget build(BuildContext context) {
    // 뷰 다이어리 컨트롤러 등록
    Get.put(ViewDiaryController());
    return
    GetBuilder<ViewDiaryController>(builder: (controller) {
      // 기존에 저장되어있던 정보를 불러온다.
      loadData(controller);
      return
        Container(
            margin: const EdgeInsets.only(top: 30),
            child:
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 70),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.diaryCards.length,
                    itemBuilder: (context,index){
                      ResponseDiary item = controller.diaryCards[index];
                      return
                        ComponentCardView(
                          dateTime:item.regDate,
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // 모든 카드에 대해 처리한다.
                              for(ResponseDiaryDetail detail in item.diaryDetails.orderBy((item) => item.sequence))
                                Column(
                                  children: [
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () async {
                                        showTarotScreen(context,detail.imagePath);
                                      },
                                      child:
                                      MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child:Container(
                                              margin: const EdgeInsets.fromLTRB(20,20,20,10),
                                              child: ComponentTarotCardFront(cardImagePath: detail.imagePath,width: 100,height: 180)
                                          )
                                      ),
                                    ),
                                    // 선택된 카드의 번호
                                    Text(detail.sequence.toString())
                                  ],
                                )
                            ],
                          ),
                        );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // 3카드 스프레드 버튼
                      ComponentButton(name: '3Card Spread',
                          width: 120,
                          height: 40,
                          onTap:(){
                            selectSpread(context,EnumSpreadType.threeCardSpread);
                          } , color: Colors.blueAccent),
                      // 1카드 스프레드 버튼
                      ComponentButton(name: '1Card Spread',
                          width: 120,
                          height: 40,
                          onTap:(){
                            selectSpread(context,EnumSpreadType.oneCardSpread);
                          } , color: Colors.blueAccent)
                    ],
                  )
                )
              ],
            )
        );
    });
  }

  /// 타로 카드 스프레드를 선택한다.
  selectSpread(BuildContext context, EnumSpreadType enumSpreadType) async {
    // 타로 카드 셀렉터 컨트롤러를 가져온다.
    TarotCardSelectorController controller = Get.find<TarotCardSelectorController>();

    // 카드를 셔플한다.
    controller.shuffleCard();
    // 카드 선택 갯수를 세팅한다.
    controller.setCompleteCount(enumSpreadType);
    // 선택된 카드를 초기화한다.
    controller.clearSelectedCards();

    // 카드 셀렉터 화면을 부른다.
    await showDialog(
      context: context,
      // 선택한 카드 갯수와 , 완료해야하는 타로 개수가 일치하는경우 
      barrierDismissible: controller.isCompleted(),
      builder: (BuildContext context) {
        controller.setContext(context);
        return const ComponentTarotSelector();
      },
    );
  }
  
  /// 기존 정보를 가져온다.
  void loadData(ViewDiaryController controller) {
    // 프로바이더를 가져온다.
    HiveDiaryProvider diaryProvider = Get.find<HiveDiaryProvider>();
    
    // 데이터를 가져온다.
    ResponseList<ResponseDiary> response = diaryProvider.getDiaryList();
    
    // 데이터 조회에 실패한경우
    if(response.result != EnumResponseResult.Success) {
      EasyLoading.showError(response.message);
      return;
    }
    controller.addItems(response.items);
  }

  void showTarotScreen(BuildContext context, String imagePath) {
    showDialog(
        context: context,
        barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
        builder: (buildContext) {
          return
            GetBuilder<TarotCardSelectorController>(
                builder: (TarotCardSelectorController controller) {
                  return
                    Dialog(
                        backgroundColor: Colors.transparent,
                        child: ComponentTarotCardFront(
                          width: 300,
                          height: 500,
                          cardImagePath: imagePath,
                        )
                    );
                }
            );
        }
    );
  }
}
