import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../controllers/controller-side-button.dart';

/// 사이드 서브 메뉴 버튼
class ComponentSubMenuButton extends StatelessWidget {
  /// 버튼명
  final String name;

  /// 아이콘
  final IconData iconData;

  /// 클릭시 콜백 메서드
  final VoidCallback onTap;
  const ComponentSubMenuButton(
      {super.key,
      required this.name,
      required this.iconData,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideMenuButtonController>(builder: (controller) {
      return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              // 클릭범위를 행 전체로 확대하기 위한 설정
              behavior: HitTestBehavior.translucent,
              // 클릭시
              onTap: () {
                // 클릭 이벤트를 전달해야 하는 경우
                if(controller.shouldInvoke(name)) {
                  onTap();
                }
              },
              child: Container(
                  // 선택된 버튼이랑 일치하는 경우 선택 표시
                  decoration: (controller.selectedButtonName != name)
                      ? null
                      : BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5.0)),
                  padding: EdgeInsets.zero,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(width: 15),
                      Icon(
                        iconData,
                        size: 15,
                        color: Colors.blueAccent,
                      ),
                      Container(width: 6),
                      Text(
                        name,
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.black.withOpacity(0.6)),
                      )
                    ],
                  ))));
    });
  }
}
