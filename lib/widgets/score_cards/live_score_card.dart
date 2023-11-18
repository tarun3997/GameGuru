import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';

class LiveScoreCard extends StatelessWidget {
  final String matchStadium;
  final String team1;
  final String team1Score;
  final String team1Wickets;
  final String team1Overs;
  final String team2;
  final String team2Score;
  final String team2Wickets;
  final String team2Overs;
  final String matchStatus;
  final String currentState;
  final bool isTeam1Batting;
  final bool isTeam2Batting;
  final bool isLive;

  const LiveScoreCard({super.key,
    required this.matchStadium,
    required this.team1,
    required this.team2, required this.team1Score, required this.team1Wickets, required this.team1Overs, required this.team2Score, required this.team2Wickets, required this.team2Overs,  required this.isTeam1Batting, required this.isTeam2Batting, required this.matchStatus, required this.currentState, required this.isLive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: const Color(0xff141d24),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 9,
                    child: Text(
                      matchStadium,
                      style: const TextStyle(
                          color: Color(0xffc9c2c2),
                          fontSize: 11,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Transform.rotate(
                      angle: 45,
                      child: const Icon(
                        Icons.push_pin,
                        size: 16,
                        color: AppColors.fontColor1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 18,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              team1,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 7),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("$team1Score-$team1Wickets",style: const TextStyle(color: AppColors.fontColor1,fontSize: 16),),
                                Text(" $team1Overs",style: const TextStyle(color: AppColors.fontColor1,fontSize: 11)),
                                const SizedBox(width: 7),

                                isTeam1Batting ? Transform.rotate(
                                    angle: 55,
                                    child: const Icon(Icons.sports_cricket_sharp,size: 14,color: Color(0xffeaaf55),)) : const Text('')
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 18,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              team2,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(width: 7),
                             Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("$team2Score-$team2Wickets",style: const TextStyle(color: AppColors.fontColor1,fontSize: 16),),
                                Text(" $team2Overs",style: const TextStyle(color: AppColors.fontColor1,fontSize: 11)),
                                const SizedBox(width: 7),

                                isTeam2Batting ? Transform.rotate(
                                  angle: 55,
                                    child: const Icon(Icons.sports_cricket_sharp,size: 14,color: Color(0xffeaaf55),)) : const Text('')
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.1,
                    height: MediaQuery.of(context).size.height * 0.09,
                    color: Colors.white,
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isLive ? Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.redAccent,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffea1277),
                                blurRadius: 5,
                                offset: Offset(0,0),
                                spreadRadius: 2
                              )
                            ]
                          ),
                        ) : const Text(''),
                        const SizedBox(width: 10,),
                        Flexible(
                          child: Text(
                            currentState,
                            style: const TextStyle(
                              color: Color(0xfff57a7b),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(matchStatus,style: const TextStyle(color: Color(0xffdeaf65),fontSize: 11),),
              )
            ],
          ),
        ),
      ],
    );
  }
}
