import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';

TextStyle textStyle1 = const TextStyle(color: AppColors.primary,fontSize: 16);
TextStyle textStyle5 = const TextStyle(color: AppColors.primary,fontSize: 26,fontWeight: FontWeight.w600);
TextStyle textStyle2 = const TextStyle(color: AppColors.iconColor,fontSize: 13);
TextStyle textStyle3 = const TextStyle(color: AppColors.fontColor1,fontSize: 14);
TextStyle textStyle4 = const TextStyle(color: AppColors.fontColor1,fontSize: 12);

Divider divider = const Divider(
  thickness: 0.3,
  color: Color(0xff686c68),
);

Widget keyStatsContainer(context,String type, String teamName, String playerName, String points, String pointType){
  final height = MediaQuery.of(context).size.height;
  return Container(
    margin: const EdgeInsets.all(3),
    padding: const EdgeInsets.all(10),
    height: height * 0.3,
    decoration: BoxDecoration(
        color: AppColors.bottomsheetColor,
        borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(type, style: textStyle3),
        Row(children: [
          const CircleAvatar(),
          const SizedBox(width: 8,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(teamName, style: textStyle4),
              Text(playerName, style: textStyle1),
            ],
          ),
        ],),
        divider,
        Row(children: [
          Text(points,style: textStyle5,),
          const SizedBox(width: 5,),
          Text(pointType,style: textStyle1,),
        ],)
      ],),
  );

}

Widget keyStatsContainer2(context,String type, String teamName, String playerName, String points, String pointType){
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Container(
    margin: const EdgeInsets.all(3),
    padding: const EdgeInsets.symmetric(horizontal: 20,),
    width: width,
    height: height * 0.12,
    decoration: BoxDecoration(
        color: AppColors.bottomsheetColor,
        borderRadius: BorderRadius.circular(10)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(type, style: textStyle3),
            ),
            Row(
              children: [
                Text(playerName, style: textStyle1),
                const SizedBox(width: 10,),
                Text(teamName, style: textStyle4),
              ],)
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(points,style: textStyle5,),
            Text(pointType,style: textStyle1,),
          ],)
      ],),
  );

}
