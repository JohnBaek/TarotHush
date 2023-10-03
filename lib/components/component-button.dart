import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 버튼 텍스트 컴포넌트
class ComponentButton extends StatelessWidget {
  /// 버튼명
  final String name;
  
  /// 버튼 컬러
  final Color color;

  /// 클릭시 콜백 메서드 
  final VoidCallback? onTap;

  /// 생성자
  const ComponentButton({super.key,required this.name, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        // 클릭범위를 행 전체로 확대하기 위한 설정
        behavior: HitTestBehavior.translucent,
        // 클릭시 
        onTap: () {
          // 콜백을 전달한다.
          // onTap();
        },
        child: 
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              margin: const EdgeInsets.all(10) ,
              width: 150,
              height: 60,
              alignment: Alignment.center,
              decoration:
              BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                name,
                style:
                const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.white),
              ),
            ),
          )
    );
  }
}
