import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/widgets/Overview_widget/key_stats_container.dart';

Widget matchCompleteAppbar({required String team1,required String team1Runs, required String team1Wkts, required String team1Overs,required String status,
  required String team2, required String team2Runs, required String team2Wkts, required String team2Overs}){
  TextStyle textStyle1 = const TextStyle(color: AppColors.fontColor1,fontSize: 12);
  TextStyle textStyle3 = const TextStyle(color: AppColors.fontColor1,fontSize: 9);
  TextStyle textStyle2 = const TextStyle(color: AppColors.primary,fontSize: 14);
  TextStyle textStyle4 = const TextStyle(color: Color(0xffdeaf65),fontSize: 12);
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 17,),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(team1,style: textStyle1,),
                    Row(children: [
                      Text("$team1Runs-$team1Wkts",style: textStyle2,),
                      const SizedBox(width: 5,),

                      Text("($team1Overs)",style: textStyle3,),
                    ],)
                  ],),
              ],
            ),
            const Icon(Icons.bolt_rounded,size: 34,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(team2,style: textStyle1,),
                    Row(children: [
                      Text("($team2Overs)",style: textStyle3,),
                      const SizedBox(width: 5,),
                      Text("$team2Runs-$team2Wkts",style: textStyle2,),

                    ],)
                  ],),
                const SizedBox(width: 10,),
                const CircleAvatar(radius: 17,),

              ],
            ),
          ],),
      ),
      divider,
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(status,style: textStyle4),
      )
    ],
  );
}