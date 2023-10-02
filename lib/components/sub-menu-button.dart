import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:my_app/providers/side-button-controller.dart';

/// 사이드 서브 메뉴 버튼 
class SubMenuButton extends StatelessWidget {
  /// 버튼명 
  final String name;
  
  /// 아이콘 
  final IconData iconData;
  const SubMenuButton({super.key, required this.name, required this.iconData});

  @override
  Widget build(BuildContext context) {
      return GetBuilder<SideMenuButtonController>(builder: (controller){
        return
          GestureDetector(
            // 클릭범위를 행 전체로 확대하기 위한 설정
            behavior: HitTestBehavior.translucent, 
            // 클릭시 
            onTap: () {
              // 선택한 버튼의 이름을 추가한다.
              controller.click(name);
            },
            child: Container(
                margin: const EdgeInsets.only(top: 10),
                // 선택된 버튼이랑 일치하는 경우 선택 표시 
                decoration: (controller.selectedButtonName != name) ? null :
                BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5.0)
                ),
                padding: EdgeInsets.zero,
                height: 30,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(width: 15),
                    Icon(iconData,size: 20, color: Colors.blueAccent,),
                    Container(width: 6),
                    Text(name,
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.9)),
                    )
                  ],
                )
            )
          );
      });
  }
}
