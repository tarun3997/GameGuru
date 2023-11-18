
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/services/server/live_score_api.dart';

class LiveMatchAppbar extends StatefulWidget {
  final int matchId;
  const LiveMatchAppbar({super.key, required this.matchId});


  @override
  State<LiveMatchAppbar> createState() => _LiveMatchAppbarState();
}

class _LiveMatchAppbarState extends State<LiveMatchAppbar> {

  late Future<Map<String, dynamic>> futureData;
  @override
  void initState() {
    super.initState();
    futureData = liveScore(widget.matchId);
  }
  bool isVolumeOff = false;
  TextStyle textStyle1 = const TextStyle(color: AppColors.fontColor1,fontSize: 12);
  TextStyle textStyle3 = const TextStyle(color: AppColors.fontColor1,fontSize: 9);
  TextStyle textStyle2 = const TextStyle(color: AppColors.primary,fontSize: 14);
  TextStyle textStyle4 = const TextStyle(color: Color(0xffdeaf65),fontSize: 12);
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Map<String , dynamic>>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
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
                            Text("",style: textStyle2,),
                            const SizedBox(height: 3,),
                            Row(children: [
                              Text("",style: textStyle2,),
                              const SizedBox(width: 7,),

                              Text("",style: textStyle1,),
                            ],)
                          ],),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: Transform.rotate(
                        angle: 192,
                        child: const VerticalDivider(
                          color: Color(0xff686c68),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                            width: 50,
                            child: Center(child: Text("",style: TextStyle(color: Color(0xffe8df90,),fontSize: 24,fontWeight: FontWeight.bold),))),
                        const SizedBox(width: 16,),
                        GestureDetector(onTap: (){
                          setState(() {
                            isVolumeOff = !isVolumeOff;
                          });
                        },
                          child: isVolumeOff ? const Icon(Icons.volume_off_rounded,color: AppColors.fontColor1,size: 18,) : const Icon(Icons.volume_up_rounded,color: AppColors.fontColor1,size: 18,),
                        ),
                      ],
                    )
                  ],),
              ),

            ],
          );
        }
        else if (snapshot.hasError){
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
                            Text("",style: textStyle2,),
                            const SizedBox(height: 3,),
                            Row(children: [
                              Text("",style: textStyle2,),
                              const SizedBox(width: 7,),

                              Text("",style: textStyle1,),
                            ],)
                          ],),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: Transform.rotate(
                        angle: 192,
                        child: const VerticalDivider(
                          color: Color(0xff686c68),
                        ),
                      ),
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 50,
                            child: Center(child: Text("",style: TextStyle(color: Color(0xffe8df90,),fontSize: 24,fontWeight: FontWeight.bold),))),
                        SizedBox(width: 16,),
                      ],
                    )
                  ],),
              ),

            ],
          );
        } else if(snapshot.hasData){
          final liveData = snapshot.data!;
          final matchScore = liveData['matchScoreDetails']['inningsScoreList'][0];
          final batTeamName = matchScore['batTeamName'];
          final runs = matchScore['score'];
          final wickets = matchScore['wickets'];
          final overs = matchScore['overs'];

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
                            Text(batTeamName,style: textStyle2,),
                            const SizedBox(height: 3,),
                            Row(children: [
                              Text("$runs-$wickets",style: textStyle2,),
                              const SizedBox(width: 7,),
                              Text('$overs',style: textStyle1,),
                            ],)
                          ],),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                      child: Transform.rotate(
                        angle: 192,
                        child: const VerticalDivider(
                          color: Color(0xff686c68),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                            width: 50,
                            child: Center(child: Text("Ball",style: TextStyle(color: Color(0xffe8df90,),fontSize: 24,fontWeight: FontWeight.bold),))),
                        const SizedBox(width: 16,),
                        GestureDetector(onTap: (){
                          setState(() {
                            isVolumeOff = !isVolumeOff;
                          });
                        },
                          child: isVolumeOff ? const Icon(Icons.volume_off_rounded,color: AppColors.fontColor1,size: 18,) : const Icon(Icons.volume_up_rounded,color: AppColors.fontColor1,size: 18,),
                        ),
                      ],
                    )
                  ],),
              ),

            ],
          );

        }
        else {
          return Text('No data available.',style: textStyle2,);
        }
      },
    );

  }
}

