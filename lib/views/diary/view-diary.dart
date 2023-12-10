import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_app/components/component-button.dart';
import 'package:my_app/components/component-card-view.dart';
import 'package:my_app/models/enums/enum-response-result.dart';
import 'package:my_app/models/responses/cards/response-tarot-metadata.dart';
import 'package:my_app/utils/logger.dart';
import 'package:my_app/views/diary/view-diary-controller.dart';

import '../../../models/enums/enum-card-spread-type.dart';
import '../../components/tarotcard/component-tarot-card-front.dart';
import '../../components/tarotcard/component-tarot-selector.dart';
import '../../components/tarotcard/component-tarot-card-controller.dart';
import '../../models/responses/diary/response-diary.dart';
import '../../models/responses/response-list.dart';

/// 다이어리 뷰 페이지 
class ViewDiary extends StatelessWidget {
  const ViewDiary({Key? key}): super(key:key);
  @override
  Widget build(BuildContext context) {
    Get.put(ViewDiaryController());
    fetchDiary();
    return
      GetBuilder<ViewDiaryController>(builder: (controller) {
        return
          Container(
            margin: const EdgeInsets.only(top: 30),
            child:
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 70),
                  child:
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.diaryList.length,
                        itemBuilder: (context,index){
                          ResponseDiary item = controller.diaryList[index];
                          return
                            ComponentDiaryItem(
                              dateTime:item.regDate,
                              child:
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // 모든 카드에 대해 처리한다.
                                  for(ResponseDiaryDetail detail in item.items.orderBy((item) => item.sequence))
                                    Column(
                                      children: [
                                        MouseRegion(
                                            cursor: SystemMouseCursors.click,
                                            child:Container(
                                                margin: const EdgeInsets.fromLTRB(20,20,20,10),
                                                child: ComponentTarotCardFront(metadata: detail.metadata, width: 100,height: 180, onTap: (ResponseTarotCardMetadata metadata) {
                                                  showTarotScreen(context,metadata);
                                                },)
                                            )
                                        ),
                                        // 선택된 카드의 번호
                                        Text(detail.sequence.toString())
                                      ],
                                    )
                                ],
                              ),
                            );
                        },
                      )
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
                            selectSpread(context,EnumCardSpreadType.threeCardSpread);
                          } , color: Colors.blueAccent),
                      // 1카드 스프레드 버튼
                      ComponentButton(name: '1Card Spread',
                          width: 120,
                          height: 40,
                          onTap:(){
                            selectSpread(context,EnumCardSpreadType.oneCardSpread);
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
  /// [context] 컨텍스트 값
  /// [spreadType] 스프레드 타입 
  selectSpread(BuildContext context, EnumCardSpreadType spreadType) async {
    // 타로 카드 셀렉터 컨트롤러를 가져온다.
    ComponentTarotCardController controller = Get.find<ComponentTarotCardController>();

    // 카드를 셔플한다.
    controller.shuffleCard();
    // 카드 선택 갯수를 세팅 한다.
    controller.setCompleteCount(spreadType);
    // 선택된 카드를 초기화 한다.
    controller.clearSelectedCards();

    // 카드 셀렉터 화면을 부른다.
    await showDialog(
      context: context,
      // 선택한 카드 갯수와 , 완료 해야하는 타로 개수가 일치하는 경우 
      barrierDismissible: controller.selectedCompleted(),
      builder: (BuildContext context) {
        // 컨텍스트를 보관한다.
        controller.setContext(context);
        return const ComponentTarotSelector();
      },
    );
  }

  /// 다이어리 데이터를 가져온다.
  Future<void> fetchDiary() async {
    try {
      // 컨트롤러를 가져온다.
      ViewDiaryController controller = Get.find<ViewDiaryController>();
      
      // 이미 패치 한경우
      if(controller.getHasFetched()) {
        return;
      }
      
      // 데이터를 조회한다.
      ResponseList<ResponseDiary> response = await controller.getDiaryAsync();
      
      // 조회에 실패한경우 
      if(response.result != EnumResponseResult.success) {
        EasyLoading.showError(response.message);
        return;
      }
      
      // 데이터를 추가한다.
      controller.addDiaryList(response.items);
      // 패치 여부를 업데이트한다.
      controller.updateFetch(true);
    }
    catch(ex){
      Logger.error(ex);
      EasyLoading.showError("데이터를 가져오는중 예외가 발생했습니다.");
    }
  }

  /// 확대된 타로카드를 출력한다.
  showTarotScreen(BuildContext buildContext, ResponseTarotCardMetadata metadata)  {
    showDialog(
        context: buildContext,
        barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
        builder: (buildContext) {
          return
            GetBuilder<ComponentTarotCardController>(
                builder: (ComponentTarotCardController controller) {
                  return
                    Dialog(
                        backgroundColor: Colors.transparent,
                        child: ComponentTarotCardFront(
                          width: 300,
                          height: 500,
                          metadata: metadata,
                          onTap: (ResponseTarotCardMetadata metadata) {},
                        )
                    );
                }
            );
        }
    );
  }

}
