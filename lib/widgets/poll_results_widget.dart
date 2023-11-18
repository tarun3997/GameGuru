import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/widgets/Overview_widget/key_stats_container.dart';

Widget pollResultWidget(context, teamA, teamB){
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Container(
    padding: const EdgeInsets.all(12),
    width: width,
    height: height * 0.14,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.buttonBoxColor2
    ),
    child:  Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Poll Results",style: textStyle1,),
          const Text("Total Votes: 14,37,235",style: TextStyle(color: AppColors.fontColor1,fontSize: 10),),
        ],),
      const SizedBox(height: 18,),
      Row(children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.5,color: AppColors.fontColor1)
            ),
            child: Center(child: Text("$teamA : 28%",style: TextStyle(color: AppColors.primary,fontSize: 14))),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 5),
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.5,color: AppColors.fontColor1)
            ),
            child:  Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_events_rounded,color: Colors.yellowAccent,size: 16,),
                Text(" $teamB : 72%",style: TextStyle(color: AppColors.primary,fontSize: 14)),
              ],
            )),
          ),
        ),
      ],),

    ],),
  );

}