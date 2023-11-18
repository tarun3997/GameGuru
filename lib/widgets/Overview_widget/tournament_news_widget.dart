import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';

Widget newsBox(context){
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text("[Watch] Kusal Mendis Get To His 65-Ball Century With Massive Six Against Hasan Ali",style: TextStyle(color: Colors.white,fontSize: 16),),
      ),
      const Text("49 minutes ago",style: TextStyle(color: AppColors.fontColor1),)
    ],),
  );
}

Widget headlines(context){
  return Container(
    margin: const EdgeInsets.only(right: 14),
    width: MediaQuery.of(context).size.width * 0.65,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text("[Watch] Kusal Mendis Get To His 65-Ball Century With Massive Six Against Hasan Ali",style: TextStyle(color: Colors.white,fontSize: 16),
          maxLines: 2,overflow: TextOverflow.ellipsis),
        ),
      ],),
  );
}