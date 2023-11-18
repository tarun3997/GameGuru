import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/models/local_model/keystats.dart';
import 'package:gameguru/models/local_model/statsTypes.dart';
import 'package:gameguru/services/server/series_server/series_news_api.dart';
import 'package:gameguru/services/server/series_server/series_squads_api.dart';
import 'package:gameguru/services/server/series_server/series_stats_api.dart';
import 'package:gameguru/widgets/Overview_widget/key_stats_container.dart';
import 'package:gameguru/widgets/Overview_widget/team_Squads_Widget.dart';
import 'package:gameguru/widgets/Overview_widget/tournament_news_widget.dart';
import 'package:gameguru/widgets/matches_status.dart';

class OverViewWidget extends StatefulWidget {
  final Function(int) goToThiTab;
  const OverViewWidget({super.key, required this.goToThiTab});

  @override
  State<OverViewWidget> createState() => _OverViewWidgetState();
}

class _OverViewWidgetState extends State<OverViewWidget> {
  TextStyle textStyle1 =
      const TextStyle(color: AppColors.primary, fontSize: 16);
  TextStyle textStyle5 = const TextStyle(
      color: AppColors.primary, fontSize: 26, fontWeight: FontWeight.w600);
  TextStyle textStyle2 =
      const TextStyle(color: AppColors.iconColor, fontSize: 13);
  TextStyle textStyle3 =
      const TextStyle(color: AppColors.fontColor1, fontSize: 14);
  TextStyle textStyle4 =
      const TextStyle(color: AppColors.fontColor1, fontSize: 12);

  final PageController _pageController = PageController();
  int _currentPage = 0;
  List<StatsType> statsType = [
    StatsType(statsType: 'mostRuns'),
    StatsType(statsType: 'highestSr'),
    StatsType(statsType: 'lowestEcon'),
    StatsType(statsType: 'mostHundreds'),
    StatsType(statsType: 'mostWickets'),
    StatsType(statsType: 'bestBowlingInnings'),
    StatsType(statsType: 'highestScores'),
    StatsType(statsType: 'mostSixes'),
  ];

  late Future<Map<String, dynamic>> seriesStat;
  late Future<Map<String, dynamic>> seriesNew;
  late Future<Map<String, dynamic>> seriesSquad;
  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });

    seriesStat = seriesStats(6732, 'mostRuns');
    seriesNew = seriesNews(6732);
    seriesSquad = seriesSquads(6732);

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Divider divider = const Divider(
    thickness: 0.2,
    color: Color(0xff686c68),
  );
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
          future: seriesStat,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text(
                "Error : ${snapshot.hasError}",
                style: const TextStyle(color: Colors.white),
              );
            } else if (snapshot.hasData) {
              final statsData = snapshot.data!;
              final values = statsData['odiStatsList']['values'][0]['values'];
              final mostRunName = values[1];
              final mostRuns = values[4];

              List<KeyStats> keyStates = [
                KeyStats(
                    statsType: 'mostRuns',
                    type: 'Most Runs',
                    playerName: mostRunName,
                    teamName: 'New Zealand',
                    points: mostRuns,
                    pointsType: 'Runs'),
                KeyStats(
                    statsType: 'highestSr',
                    type: 'Best Strike Rate',
                    playerName: 'A Markram',
                    teamName: 'South Africa',
                    points: '196.30',
                    pointsType: ''),
                KeyStats(
                    statsType: 'lowestEcon',
                    type: 'Best Economy',
                    playerName: 'J Bumrah',
                    teamName: 'India',
                    points: '2.78',
                    pointsType: ''),
                KeyStats(
                    statsType: 'mostHundreds',
                    type: 'Most Fantasy Points',
                    playerName: 'B de Leede',
                    teamName: 'Netherlands',
                    points: '213',
                    pointsType: 'Points'),
                KeyStats(
                    statsType: 'mostWickets',
                    type: 'Most Wickets',
                    playerName: 'B de Leede',
                    teamName: 'NED',
                    points: '4',
                    pointsType: 'Wickets'),
                KeyStats(
                    statsType: 'bestBowlingInnings',
                    type: 'Best Figures',
                    playerName: 'B de Leede',
                    teamName: 'NED',
                    points: '62-4',
                    pointsType: ''),
                KeyStats(
                    statsType: 'highestScores',
                    type: 'Highest Score',
                    playerName: 'Virat Kohli',
                    teamName: 'IND',
                    points: '85',
                    pointsType: 'Runs'),
                KeyStats(
                    statsType: 'mostSixes',
                    type: 'Most Sixes',
                    playerName: 'K Mendis',
                    teamName: 'SL',
                    points: '8',
                    pointsType: 'Sixes'),
              ];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Featured Matches",
                        style: textStyle1,
                      ),
                      GestureDetector(
                          onTap: () {
                            widget.goToThiTab(1);
                          },
                          child: Text(
                            "All Matches",
                            style: textStyle2,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  matchStatusLive(context, 'SA', 'SL'),
                  upcomingMatch(context, 'IND', 'AUS'),
                  matchResult(context, 'BAN', 'AFG'),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Key Stats",
                        style: textStyle1,
                      ),
                      Text(
                        "See All",
                        style: textStyle2,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.18,
                        child: PageView.builder(
                            controller: _pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.all(15),
                                  width: width,
                                  height: height * 0.18,
                                  decoration: BoxDecoration(
                                    color: AppColors.bottomsheetColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${keyStates[index].type}',
                                          style: textStyle3),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center, // Center the row vertically
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center, // Center the row vertically
                                                children: [
                                                  const CircleAvatar(),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start, // Align text to start (left)
                                                    children: [
                                                      Text(
                                                          "${keyStates[index].playerName}",
                                                          style: textStyle1),
                                                      Text(
                                                          "${keyStates[index].teamName}",
                                                          style: textStyle3),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .end, // Align text to end (right)
                                                children: [
                                                  Text(
                                                      "${keyStates[index].points}",
                                                      style: textStyle1),
                                                  Text(
                                                      "${keyStates[index].pointsType}",
                                                      style: textStyle3),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      buildIndicators(context),
                      Row(
                        children: [
                          Expanded(
                            child: keyStatsContainer(
                              context,
                              '${keyStates[4].type}',
                              '${keyStates[4].teamName}',
                              '${keyStates[4].playerName}',
                              '${keyStates[4].points}',
                              '${keyStates[4].pointsType}',
                            ),
                          ),
                          Expanded(
                            child: keyStatsContainer(
                              context,
                              '${keyStates[5].type}',
                              '${keyStates[5].teamName}',
                              '${keyStates[5].playerName}',
                              '${keyStates[5].points}',
                              '${keyStates[5].pointsType}',
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      keyStatsContainer2(
                        context,
                        '${keyStates[6].type}',
                        '${keyStates[6].teamName}',
                        '${keyStates[6].playerName}',
                        '${keyStates[6].points}',
                        '${keyStates[6].pointsType}',
                      ),
                      keyStatsContainer2(
                        context,
                        '${keyStates[7].type}',
                        '${keyStates[7].teamName}',
                        '${keyStates[7].playerName}',
                        '${keyStates[7].points}',
                        '${keyStates[7].pointsType}',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Headlines",
                        style: textStyle1,
                      ),
                      GestureDetector(
                          onTap: () {
                            widget.goToThiTab(4);
                          },
                          child: Text(
                            "View All",
                            style: textStyle2,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<Map<String, dynamic>>(
                    future: seriesNew,
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text(
                          "Error : ${snapshot.hasError}",
                          style: const TextStyle(color: Colors.white),
                        );
                      } else if (snapshot.hasData) {
                        final storyList = snapshot.data!;
                        return SizedBox(
                          height: height * 0.35,
                          child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final story = storyList['storyList'][index];
                                if(story.containsKey('story') && story['story'].isNotEmpty){
                                  final headline = story['story']['hline'];
                                  return headlines(context,headline);
                                }
                                return Container();
                              }),
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Team Squads",
                    style: textStyle1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<Map<String, dynamic>>(
                    future: seriesSquad,
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                      return Text(
                      "Error : ${snapshot.hasError}",
                      style: const TextStyle(color: Colors.white),
                      );
                      } else if (snapshot.hasData) {
                        final squads = snapshot.data!;
                        final squadList = squads['squads'];
                        return SizedBox(
                          height: height * 0.18,
                          child: ListView.builder(
                              itemCount: squadList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final squadImg = squads['squads'][index];
                                if(squadImg.containsKey('imageId') && squadImg['imageId'] != null){
                                  final squadName = squads['squads'][index]['squadType'];
                                  return teamSquadsWidget(context,squadName);
                                }
                                return Container();
                              }),
                        );
                      }
                      return Container();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Series Info",
                    style: textStyle1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.bottomsheetColor),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Series",
                            style: textStyle3,
                          ),
                          trailing: Text(
                            "World Cup 2023",
                            style: textStyle3,
                          ),
                        ),
                        divider,
                        ListTile(
                          title: Text(
                            "Duration",
                            style: textStyle3,
                          ),
                          trailing: Text(
                            "05 Oct - 19 Nov 2023",
                            style: textStyle3,
                          ),
                        ),
                        divider,
                        ListTile(
                          title: Text(
                            "Format",
                            style: textStyle3,
                          ),
                          trailing: Text(
                            "48 ODIs",
                            style: textStyle3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildIndicators(context) {
    double indicatorWidth = MediaQuery.of(context).size.width * 0.09;
    double totalWidth = indicatorWidth * 4;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      width: totalWidth,
      height: 3,
      child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: indicatorWidth,
              height: 3.0,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.blue : Colors.grey,
              ),
            );
          }),
    );
  }
}
