import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';

Widget matchStatusLive(BuildContext context, String team1, String team2){
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.1,
    decoration: BoxDecoration(
      color: AppColors.bottomsheetColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Row(
        children: [
          const CircleAvatar(
            radius: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(team1,style: const TextStyle(color: AppColors.fontColor1,fontSize: 18),),
          ),
        ],
      ),
        const Text("Live",style: TextStyle(color: Colors.red),),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(team2,style: const TextStyle(color: AppColors.fontColor1,fontSize: 18),),
            ),
            const CircleAvatar(
              radius: 16,
            ),
          ],
        ),
      ],),
  );
}


Widget upcomingMatch(BuildContext context, String team1, String team2){
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.1,
    decoration: BoxDecoration(
      color: AppColors.bottomsheetColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Row(
        children: [
          const CircleAvatar(
            radius: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(team1,style: const TextStyle(color: AppColors.fontColor1,fontSize: 18),),
          ),
        ],
      ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("02:00 PM",style: TextStyle(color: AppColors.fontColor1,fontSize: 10),),
            Text("Tomorrow",style: TextStyle(color: AppColors.fontColor1,fontSize: 16),),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(team2,style: const TextStyle(color: AppColors.fontColor1,fontSize: 18),),
            ),
            const CircleAvatar(
              radius: 16,
            ),
          ],
        ),
      ],),
  );
}

Widget matchResult(BuildContext context, String team1, String team2){
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.1,
    decoration: BoxDecoration(
      color: AppColors.bottomsheetColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Row(
        children: [
          const CircleAvatar(
            radius: 16,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(team1,style: const TextStyle(color: AppColors.fontColor1,fontSize: 18),),
          ),
        ],
      ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BAN Won",style: TextStyle(color: AppColors.fontColor1,fontSize: 16,fontWeight: FontWeight.w600),),
            Text("by 6 wickets",style: TextStyle(color: AppColors.fontColor1,fontSize: 10),),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(team2,style: const TextStyle(color: AppColors.fontColor1,fontSize: 18),),
            ),
            const CircleAvatar(
              radius: 16,
            ),
          ],
        ),
      ],),
  );
}