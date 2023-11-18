import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';

Widget SeriesWidget(BuildContext context){
  Divider divider = const Divider(
    thickness: 0.3,
    color: Color(0xff686c68),
  );
  return Column(
    children: [
      const ListTile(
        leading: CircleAvatar(),
        title: Text("Men's T20 World Cup America Region Final 2023",style: TextStyle(color: AppColors.primary,fontSize: 14),),
        subtitle: Text("30 September - 7 October",style: TextStyle(color: AppColors.fontColor1,fontSize: 11),),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: divider,
      )
    ],
  );
}