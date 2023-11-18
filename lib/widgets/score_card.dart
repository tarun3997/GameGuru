import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';

class ScoreCard extends StatelessWidget {
  final String matchStadium;
  final String team1;
  final String team2;
  final String startTime;

  const ScoreCard({super.key,
    required this.matchStadium,
    required this.team1,
    required this.team2,
    required this.startTime,
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
                    child: Text(
                      matchStadium,
                      style: const TextStyle(
                        color: Color(0xffc9c2c2),
                        fontSize: 11,
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.notifications_none_outlined,
                    size: 20,
                    color: Color(0xffc9c2c2),
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.3,
                    height: MediaQuery.of(context).size.height * 0.09,
                    color: Colors.white,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        const Text(
                          "Start at:",
                          style: TextStyle(color: Color(0xffc9c2c2)),
                        ),
                        Text(
                          startTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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

class ScoreCardWithDate extends StatelessWidget {
  final String matchStadium;
  final String team1;
  final String team2;
  final String startTime;

  const ScoreCardWithDate({super.key,
    required this.matchStadium,
    required this.team1,
    required this.team2,
    required this.startTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text("Today, 10 October",style: TextStyle(color: AppColors.primary),),
        ),
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
                    child: Text(
                      matchStadium,
                      style: const TextStyle(
                        color: Color(0xffc9c2c2),
                        fontSize: 11,
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.notifications_none_outlined,
                    size: 20,
                    color: Color(0xffc9c2c2),
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 0.3,
                    height: MediaQuery.of(context).size.height * 0.09,
                    color: Colors.white,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        const Text(
                          "Start at:",
                          style: TextStyle(color: Color(0xffc9c2c2)),
                        ),
                        Text(
                          startTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
