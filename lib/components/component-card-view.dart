import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'component-button.dart';

/// 화면에 표시될 다이어리 위젯
class ComponentDiaryItem extends StatelessWidget {
  // 컨텐츠 위젯
  final Widget child;
  
  // 좌상단 위젯 
  final Widget? leftTopChild;
  
  // 날짜 정보 
  final DateTime? dateTime; 
  const ComponentDiaryItem({super.key, required this.child, required this.dateTime, this.leftTopChild});

  @override
  Widget build(BuildContext context) {
    return
      /// 컨텐츠 영역
     Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0.5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        children: [
          // 상단 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 좌상단 위젯이 존재하는 경우 
              if(leftTopChild != null)
                Container(
                  alignment: Alignment.topLeft,
                  child: leftTopChild,
                ),

              // 좌상단 위젯이 존재하지 않는 경우 
              if(leftTopChild == null)
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(""),
                ),

              // 시간표시를 해야하는 경우 
              if(dateTime != null)
                Container(
                  alignment: Alignment.topRight,
                  child: Text(DateFormat('HH:mm:ss').format(dateTime!)),
                ),
            ],
          ),
          // 컨텐츠 위젯
          child,
        ],
      )
    );
  }
}
