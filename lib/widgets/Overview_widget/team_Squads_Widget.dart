import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';

Widget teamSquadsWidget(context){
  TextStyle textStyle3 = const TextStyle(color: AppColors.fontColor1,fontSize: 14);
  return Container(
    margin: const EdgeInsets.only(right: 6),
    width: MediaQuery.of(context).size.width * 0.35,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: AppColors.bottomsheetColor
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const CircleAvatar(
        radius: 32,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text("IND",style: textStyle3,),
      )
    ],),
  );
}