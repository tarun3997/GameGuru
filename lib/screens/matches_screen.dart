
import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/models/local_model/score_card_model.dart';
import 'package:gameguru/screens/navigat_screens/score_card_details_screen.dart';
import 'package:gameguru/services/imageServices.dart';
import 'package:gameguru/services/server/finished_match_api.dart';
import 'package:gameguru/services/server/live_score_api.dart';
import 'package:gameguru/services/server/upcoming_match_api.dart';
import 'package:gameguru/widgets/score_cards/finished_match_score_card.dart';
import 'package:gameguru/widgets/score_cards/live_score_card.dart';
import 'package:gameguru/widgets/score_cards/upcoming_match_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:gameguru/enum_classes/match_type.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int initialIndex = 0;
  bool isExpanded = true;

  final List<LiveMatchCard> liveMatches = [
    LiveMatchCard(
      stadiumName: "Stadium 1",
      team1: "Team A",
      team2: "Team B",
      live: true,
      team1Score: 150,
      team1Wicket: 2,
      team2Score: 100,
      team2Wicket: 5,
      team1Over: "15.3",
      team2Over: "15.0",
      matchInfo: "Match Info 1",
      tournamentInfo: "Tournament 1",
    ),
    LiveMatchCard(
      stadiumName: "Stadium 2",
      team1: "Team C",
      team2: "Team D",
      live: false,
      team1Score: 160,
      team1Wicket: 1,
      team2Score: 60,
      team2Wicket: 6,
      team1Over: "16.4",
      team2Over: "16.0",
      matchInfo: "Match Info 2",
      tournamentInfo: "Tournament 2",
    ),
    // Add more LiveMatchCard objects as needed
  ];

  late Future<Map<String, dynamic>> futureDataScore;

  late Future<Map<String, dynamic>> upcomingMatchesData;
  late Future<Map<String, dynamic>> finishedMatchData;
  bool isExpandeds = false;

  void toggleExpansion() {
    setState(() {
      isExpandeds = !isExpandeds;
    });
  }

  @override
  void initState() {
    super.initState();
    futureDataScore = fetchData();
    upcomingMatchesData = upcomingMatchData();
    finishedMatchData = finishedMatch();

    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        initialIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff01040a),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  pinned: true,
                  snap: true,
                  floating: true,
                  scrolledUnderElevation: 0,
                  backgroundColor: const Color(0xff01040a),
                  title: Text(
                    "Utakarsh",
                    style: GoogleFonts.getFont('Josefin Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  actions: const [
                    Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 25,
                    )
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(49),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey, // Customize the divider color
                            width: 1.0, // Customize the divider width
                          ),
                        ),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: Colors.white,
                        unselectedLabelColor: const Color(0xff686c68),
                        indicatorColor: const Color(0xff38e849),
                        dividerColor: Colors.transparent,
                        labelStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        unselectedLabelStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                        isScrollable: true,
                        tabs: const [
                          Tab(
                            child: Text("Live"),
                          ),
                          Tab(
                            child: Text("For You"),
                          ),
                          Tab(
                            child: Text("Upcoming"),
                          ),
                          Tab(
                            child: Text("Finished"),
                          ),
                        ],
                      ),
                    ),
                  ))
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              Tab(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: futureDataScore,
                  builder: (context , snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    } else if(snapshot.hasError){
                      return Text("Error : ${snapshot.hasError}",style: const TextStyle(color: Colors.white),);
                    }
                    else if(snapshot.hasData){
                      final typeMatch = snapshot.data!['typeMatches'];
                      return ListView.builder(
                        itemCount: typeMatch.length,
                        itemBuilder: (context, index) {
                          final match = typeMatch[index];
                          if (match.containsKey('seriesMatches') && match['seriesMatches'].isNotEmpty) {
                            final matchType = match['matchType'];
                            final seriesMatches = List<Map<String, dynamic>>.from(match['seriesMatches']);
                            final filteredSeriesMatches = seriesMatches.where((dynamic seriesMatch) {
                              return seriesMatch is Map<String, dynamic> && seriesMatch.containsKey('seriesAdWrapper');
                            }).toList();
                            return ExpansionTile(
                              initiallyExpanded: true,

                              title: Text("$matchType",style: const TextStyle(color: AppColors.primary,fontSize: 14),),
                              trailing: Icon(
                                isExpandeds
                                    ? Icons.arrow_drop_up_outlined
                                    : Icons.arrow_drop_down,
                              ),
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: filteredSeriesMatches.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context , index){
                                        final seriesMatches = filteredSeriesMatches[index]['seriesAdWrapper']['matches'];
                                        return Column(
                                          children: List<Widget>.from(seriesMatches.map((singleMatch){
                                            final seriesName = singleMatch['matchInfo']['seriesName'];
                                            final matchId = singleMatch['matchInfo']['matchId'];
                                            final matchDesc = singleMatch['matchInfo']['matchDesc'];
                                            final matchFormat = singleMatch['matchInfo']['matchFormat'];
                                            final currentState = singleMatch['matchInfo']['state'];
                                            final matchDescNumber = matchDesc.replaceFirst('Match','');
                                            String? liveState;
                                            bool isLive = false;
                                            if(currentState == 'In Progress'){
                                              liveState = 'Live';
                                              isLive = true;
                                            }else{
                                              liveState = currentState;
                                            }

                                            final matchStatus = singleMatch['matchInfo']['status'];
                                            final team1 = singleMatch['matchInfo']['team1']['teamSName'];
                                            final team2 = singleMatch['matchInfo']['team2']['teamSName'];
                                            String? runs1, wickets1, overs1, runs2, wickets2, overs2;
                                            final matchScores = singleMatch['matchScore'];
                                            if(matchScores !=null){
                                              final team1Scores = singleMatch['matchScore']['team1Score'];
                                              final team2Scores = singleMatch['matchScore']['team2Score'];
                                              if (team1Scores != null) {
                                                final inning1 = team1Scores['inngs1'];
                                                if (inning1 != null) {
                                                  final inning1Wickets = inning1['wickets'];
                                                  if (inning1Wickets != null) {
                                                    wickets1 = inning1Wickets.toString();
                                                  } else {
                                                    wickets1 = '0';
                                                  }
                                                  runs1 = inning1['runs'].toString();
                                                  overs1 = inning1['overs'].toString();
                                                } else {
                                                  runs1 = '';
                                                  wickets1 = '';
                                                  overs1 = 'Yet to bat';
                                                }
                                              } else {
                                                runs1 = '';
                                                wickets1 = '';
                                                overs1 = 'Yet to bat';
                                              }
                                              if (team2Scores != null) {
                                                final inning2 = team2Scores['inngs1'];
                                                if (inning2 != null) {
                                                  final inning2Wickets = inning2['wickets'];
                                                  if (inning2Wickets != null) {
                                                    wickets2 = inning2Wickets.toString();
                                                  } else {
                                                    wickets2 = '0';
                                                  }
                                                  runs2 = inning2['runs'].toString();
                                                  overs2 = inning2['overs'].toString();
                                                } else {
                                                  runs2 = '';
                                                  wickets2 = '';
                                                  overs2 = 'Yet to bat';
                                                }
                                              } else {
                                                runs2 = '';
                                                wickets2 = '';
                                                overs2 = 'Yet to bat';
                                              }
                                            }else{
                                              runs1 = '0';
                                              wickets1 = '0';
                                              overs1 = '0.0';
                                              runs2 = '';
                                              wickets2 = '';
                                              overs2 = 'Yet to bat';
                                            }
                                            // final isTeam1Batting = match['currBatTeamId'] == match['team1']['teamId'];
                                            // final isTeam2Batting = !isTeam1Batting;
                                            return  Center(
                                                child: GestureDetector(onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  ScorecardDetailScreen(matchType: MatchType.Live, matchId: matchId,)));
                                                },
                                                  child: LiveScoreCard(
                                                    matchStadium:
                                                    '$matchDescNumber $matchFormat, $seriesName',
                                                    team1: '$team1',
                                                    team2: "$team2",
                                                    team1Score: runs1,
                                                    team1Wickets: wickets1,
                                                    team1Overs: overs1,
                                                    team2Score: runs2,
                                                    team2Wickets: wickets2,
                                                    team2Overs: overs2,
                                                    matchStatus: matchStatus,
                                                    currentState: '$liveState',
                                                    isTeam1Batting: false,
                                                    isTeam2Batting: false,
                                                    isLive: isLive,
                                                  ),
                                                ));

                                          })),
                                        );

                                })
                              ],
                            );


                          }

                        },
                      );
                    }
                    return Container(child: const Text("Error",style: TextStyle(color: Colors.white),),);
                  },
                )
              ),
              Tab(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: upcomingMatchesData,
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }else if(snapshot.hasError){
                      return Text("Error : ${snapshot.hasError}",style: const TextStyle(color: Colors.white),);

                    }else if (snapshot.hasData){
                      final upMatch = snapshot.data!['matchScheduleMap'];

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 25),
                        child: ListView.builder(
                          itemCount: upMatch.length,
                          itemBuilder: (context, index) {
                            final scheduleAdWrapper = upMatch[index]['scheduleAdWrapper'];

                            if (scheduleAdWrapper != null){
                              final matchScheduleList = scheduleAdWrapper['matchScheduleList'];
                              if (matchScheduleList != null && matchScheduleList.isNotEmpty){
                                final List<Widget> cards = [];

                                for (var matchInfo in matchScheduleList) {
                                  if (matchInfo.isNotEmpty) {
                                    final seriesName = matchInfo['seriesName'];
                                    final matchDesc = matchInfo['matchInfo'][0]['matchDesc'];
                                    final matchFormat = matchInfo['matchInfo'][0]['matchFormat'];
                                    final teamANAme = matchInfo['matchInfo'][0]['team1']['teamSName'];
                                    final teamBNAme = matchInfo['matchInfo'][0]['team2']['teamSName'];
                                    final startDate = matchInfo['matchInfo'][0]['startDate'];

                                    final startDateInMillis = int.tryParse(startDate) ?? 0;

                                    final startDates = DateTime.fromMillisecondsSinceEpoch(startDateInMillis);

                                    final formattedTime = DateFormat.jm().format(startDates);

                                    final matchNumber = matchDesc.replaceAll(RegExp(r'Match'), '').trim();
                                    cards.add(

                                      UpcomingMatchScoreCard(
                                        matchStadium: '$matchNumber, $matchFormat, $seriesName',
                                        team1: '$teamANAme',
                                        team2: "$teamBNAme",
                                        startTime: formattedTime, team1ImageId: '', team2ImageId: '',
                                      ),
                                    );
                                  }
                                }


                                return Column(children: cards,);

                              }else{
                                return Container();
                              }
                            }else{
                              return Container();
                            }

                          },
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              Tab(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: upcomingMatchesData,
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }else if(snapshot.hasError){
                      return Text("Error : ${snapshot.hasError}",style: const TextStyle(color: Colors.white),);

                    }else if (snapshot.hasData){
                      final upMatch = snapshot.data!['matchScheduleMap'];

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 25),
                        child: ListView.builder(
                          itemCount: upMatch.length,
                          itemBuilder: (context, index) {
                            final scheduleAdWrapper = upMatch[index]['scheduleAdWrapper'];

                            if (scheduleAdWrapper != null){
                              final matchScheduleList = scheduleAdWrapper['matchScheduleList'];
                              if (matchScheduleList != null && matchScheduleList.isNotEmpty){
                                final List<Widget> cards = [];
                                for (var matchInfo in matchScheduleList) {
                                  if (matchInfo.isNotEmpty) {
                                    final seriesName = matchInfo['seriesName'];
                                    final matchDesc = matchInfo['matchInfo'][0]['matchDesc'];
                                    final matchFormat = matchInfo['matchInfo'][0]['matchFormat'];
                                    final teamANAme = matchInfo['matchInfo'][0]['team1']['teamSName'];
                                    final teamAImage = matchInfo['matchInfo'][0]['team1']['imageId'];
                                    final teamBNAme = matchInfo['matchInfo'][0]['team2']['teamSName'];
                                    final teamBImage = matchInfo['matchInfo'][0]['team2']['imageId'];
                                    final startDate = matchInfo['matchInfo'][0]['startDate'];
                                    final startDateInMillis = int.tryParse(startDate) ?? 0;

                                    final startDates = DateTime.fromMillisecondsSinceEpoch(startDateInMillis);

                                    final formattedTime = DateFormat.jm().format(startDates);

                                    final matchNumber = matchDesc.replaceAll(RegExp(r'Match'), '').trim();
                                    cards.add(
                                      UpcomingMatchScoreCard(
                                        matchStadium: '$matchNumber, $matchFormat, $seriesName',
                                        team1: '$teamANAme',
                                        team2: "$teamBNAme",
                                        startTime: formattedTime, team1ImageId: '$teamAImage', team2ImageId: '$teamBImage',
                                      ),
                                    );
                                  }
                                }
                                return Column(children: cards,);
                              }else{
                                return Container();
                              }
                            }else{
                              return Container();
                            }

                          },
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              Tab(
                child: FutureBuilder<Map<String , dynamic>>(
                  future: finishedMatchData,
                  builder: (context , snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator());
                    }else if(snapshot.hasError){
                      return Text("Error : ${snapshot.hasError}",style: const TextStyle(color: Colors.white),);
                    }else if(snapshot.hasData){
                      final finishedMatches = snapshot.data!['typeMatches'][0]['seriesMatches'];
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: finishedMatches.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (finishedMatches[index].containsKey('seriesAdWrapper')){
                            final seriesAdWrapper = finishedMatches[index]['seriesAdWrapper'];
                            final seriesName = seriesAdWrapper['seriesName'];
                            final matches = seriesAdWrapper['matches'];
                            return ExpansionTile(
                              initiallyExpanded: true,

                              title: Text("$seriesName",style: const TextStyle(color: AppColors.primary,fontSize: 14),),
                              trailing: Icon(
                              isExpandeds
                              ? Icons.arrow_drop_up_outlined
                                  : Icons.arrow_drop_down,
                              ),
                              children: [
                                ListView.builder(
                                  itemCount: matches.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, matchIndex) {
                                    final teamAName = matches[matchIndex]['matchInfo']['team1']['teamSName'];
                                    final teamBName = matches[matchIndex]['matchInfo']['team2']['teamSName'];
                                    final teamAScore = matches[matchIndex]['matchScore']['team1Score']['inngs1'];
                                    final teamBScore = matches[matchIndex]['matchScore']['team2Score']['inngs1'];
                                    final teamWinBy = matches[matchIndex]['matchInfo']['status'];
                                    final teamARuns = teamAScore['runs'];
                                    final teamBRuns = teamBScore['runs'];
                                    final teamAWickets = teamAScore['wickets'];
                                    final teamBWickets = teamBScore['wickets'];
                                    final teamAOvers = teamAScore['overs'];
                                    final teamBOvers = teamBScore['overs'];
                                    final parts = teamWinBy.split('');
                                    final match = RegExp(r'(\d+) runs').firstMatch(teamWinBy);
                                    String? runs;
                                    if(parts.length > 2){
                                      runs = match?.group(1);
                                    }
                                    return Center(
                                        child: GestureDetector(onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  ScorecardDetailScreen(matchType: MatchType.Upcoming, matchId: 0,)));
                                        },
                                          child: FinishedMatchScoreCard(
                                            matchStadium: '$seriesName',
                                            team1: '$teamAName',
                                            team2: "$teamBName",
                                            wonTeam: "NZ",
                                            winBy: "$runs",
                                            team1Score: "$teamARuns",
                                            team1Wickets: '$teamAWickets',
                                            team1Overs: '$teamAOvers',
                                            team2Score: '$teamBRuns',
                                            team2Wickets: '$teamBWickets',
                                            team2Overs: '$teamBOvers',
                                          ),
                                        ));


                                  },
                                ),
                              ],
                              onExpansionChanged: (value){
                                toggleExpansion();
                              },

                            );
                          }else{
                            return Container();
                          }
                        }
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
