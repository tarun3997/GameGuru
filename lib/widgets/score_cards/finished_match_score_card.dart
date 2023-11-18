import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';

class FinishedMatchScoreCard extends StatelessWidget {
  final String matchStadium;
  final String team1;
  final String team1Score;
  final String team1Wickets;
  final String team1Overs;
  final String team2;
  final String team2Score;
  final String team2Wickets;
  final String team2Overs;
  final String wonTeam;
  final String winBy;

  const FinishedMatchScoreCard({super.key,
    required this.matchStadium,
    required this.team1,
    required this.team2,
    required this.wonTeam,
    required this.winBy, required this.team1Score, required this.team1Wickets, required this.team1Overs, required this.team2Score, required this.team2Wickets, required this.team2Overs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.168,
          decoration: BoxDecoration(
            color: const Color(0xff141d24),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Text(
                      matchStadium,
                      style: const TextStyle(
                          color: Color(0xffc9c2c2),
                          fontSize: 11,
                          overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Icon(
                      Icons.notifications_none_outlined,
                      size: 20,
                      color: Color(0xffc9c2c2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 6,
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
                                Text(" $team1Overs" ,style: const TextStyle(color: AppColors.fontColor1,fontSize: 11)),
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
                    flex: 4,
                    child: Column(
                      children: [
                        Text(
                          "$wonTeam Won",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "by $winBy",
                          style: const TextStyle(color: Color(0xffc9c2c2),fontSize: 10),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
