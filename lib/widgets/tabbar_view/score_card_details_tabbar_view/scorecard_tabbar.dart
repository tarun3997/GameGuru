import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/models/local_model/batter_scorecard.dart';
import 'package:gameguru/services/server/scorecard_api.dart';
import 'package:gameguru/utils/split_word.dart';
import 'package:gameguru/widgets/Overview_widget/key_stats_container.dart';
import 'package:gameguru/widgets/table_widget/scorecard_table_row.dart';

class ScorecardTabBarView extends StatefulWidget {
  final int matchId;
  const ScorecardTabBarView({super.key, required this.matchId});


  @override
  State<ScorecardTabBarView> createState() => _ScorecardTabBarViewState();
}

class _ScorecardTabBarViewState extends State<ScorecardTabBarView> {
  List<BatterScorecard> teamAScorecard = [
    BatterScorecard(
        batsmanName: "R Sharma (c)",
        battingStatus: "c Ahmed b Afridi",
        batsmanRuns: 86,
        batsmanBowFace: 63,
        batsmanFours: 6,
        batsmanSix: 6,
        batsmanSR: 136.51),
    BatterScorecard(
        batsmanName: "S Gill",
        battingStatus: "c S Khan b Afridi",
        batsmanRuns: 16,
        batsmanBowFace: 11,
        batsmanFours: 4,
        batsmanSix: 0,
        batsmanSR: 145.45),
    BatterScorecard(
        batsmanName: "V Kohli",
        battingStatus: "c Nawaz b Hasan Ali",
        batsmanRuns: 16,
        batsmanBowFace: 18,
        batsmanFours: 3,
        batsmanSix: 0,
        batsmanSR: 88.89),
    BatterScorecard(
        batsmanName: "S Iyer",
        battingStatus: "Not Out",
        batsmanRuns: 53,
        batsmanBowFace: 62,
        batsmanFours: 3,
        batsmanSix: 2,
        batsmanSR: 85.48),
    BatterScorecard(
        batsmanName: "L Rahul (wk)",
        battingStatus: "Not Out",
        batsmanRuns: 19,
        batsmanBowFace: 29,
        batsmanFours: 2,
        batsmanSix: 0,
        batsmanSR: 65.52),
    BatterScorecard(
        batsmanName: "L Rahul (wk)",
        battingStatus: "Not Out",
        batsmanRuns: 19,
        batsmanBowFace: 29,
        batsmanFours: 2,
        batsmanSix: 0,
        batsmanSR: 65.52),
  ];
  List<BatterScorecard> teamBScorecard = [
    BatterScorecard(
        batsmanName: "Virat",
        battingStatus: "c Ahmed b Afridi",
        batsmanRuns: 86,
        batsmanBowFace: 63,
        batsmanFours: 6,
        batsmanSix: 6,
        batsmanSR: 136.51),
    BatterScorecard(
        batsmanName: "Rohit",
        battingStatus: "c S Khan b Afridi",
        batsmanRuns: 16,
        batsmanBowFace: 11,
        batsmanFours: 4,
        batsmanSix: 0,
        batsmanSR: 145.45),
    BatterScorecard(
        batsmanName: "MS Dhoni",
        battingStatus: "c Nawaz b Hasan Ali",
        batsmanRuns: 16,
        batsmanBowFace: 18,
        batsmanFours: 3,
        batsmanSix: 0,
        batsmanSR: 88.89),
    BatterScorecard(
        batsmanName: "ABD",
        battingStatus: "Not Out",
        batsmanRuns: 53,
        batsmanBowFace: 62,
        batsmanFours: 3,
        batsmanSix: 2,
        batsmanSR: 85.48),
    BatterScorecard(
        batsmanName: "L Rahul (wk)",
        battingStatus: "Not Out",
        batsmanRuns: 19,
        batsmanBowFace: 29,
        batsmanFours: 2,
        batsmanSix: 0,
        batsmanSR: 65.52),
    BatterScorecard(
        batsmanName: "L Rahul (wk)",
        battingStatus: "Not Out",
        batsmanRuns: 19,
        batsmanBowFace: 29,
        batsmanFours: 2,
        batsmanSix: 0,
        batsmanSR: 65.52),
  ];
  List<BowlerScorecard> teamBBowlerScorecard = [
    BowlerScorecard(
        bowlerName: "S Afridi",
        bowlerOver: 6.0,
        bowlerMaiden: 0,
        bowlerRun: 36,
        bowlerWicket: 2,
        bowlerEco: 6.00),
    BowlerScorecard(
        bowlerName: "H ALi",
        bowlerOver: 6.0,
        bowlerMaiden: 0,
        bowlerRun: 34,
        bowlerWicket: 1,
        bowlerEco: 5.67),
    BowlerScorecard(
        bowlerName: "M Nawaz",
        bowlerOver: 8.3,
        bowlerMaiden: 0,
        bowlerRun: 47,
        bowlerWicket: 0,
        bowlerEco: 5.53),
    BowlerScorecard(
        bowlerName: "H Rauf",
        bowlerOver: 6.0,
        bowlerMaiden: 0,
        bowlerRun: 43,
        bowlerWicket: 0,
        bowlerEco: 7.17),
    BowlerScorecard(
        bowlerName: "S Khan",
        bowlerOver: 4.0,
        bowlerMaiden: 0,
        bowlerRun: 31,
        bowlerWicket: 0,
        bowlerEco: 7.75),
  ];
  List<BowlerScorecard> teamABowlerScorecard = [
    BowlerScorecard(
        bowlerName: "J Bumrah",
        bowlerOver: 6.0,
        bowlerMaiden: 0,
        bowlerRun: 36,
        bowlerWicket: 2,
        bowlerEco: 6.00),
    BowlerScorecard(
        bowlerName: "H ALi",
        bowlerOver: 6.0,
        bowlerMaiden: 0,
        bowlerRun: 34,
        bowlerWicket: 1,
        bowlerEco: 5.67),
    BowlerScorecard(
        bowlerName: "M Nawaz",
        bowlerOver: 8.3,
        bowlerMaiden: 0,
        bowlerRun: 47,
        bowlerWicket: 0,
        bowlerEco: 5.53),
    BowlerScorecard(
        bowlerName: "H Rauf",
        bowlerOver: 6.0,
        bowlerMaiden: 0,
        bowlerRun: 43,
        bowlerWicket: 0,
        bowlerEco: 7.17),
    BowlerScorecard(
        bowlerName: "S Khan",
        bowlerOver: 4.0,
        bowlerMaiden: 0,
        bowlerRun: 31,
        bowlerWicket: 0,
        bowlerEco: 7.75),
  ];

  String selectedTeam = 'TeamA';
  TextStyle textStyle1 = const TextStyle(
      color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.w500);
  TextStyle textStyle2 = const TextStyle(
    color: AppColors.fontColor1,
    fontSize: 10,
  );
  TextStyle textStyle3 = const TextStyle(
    color: AppColors.fontColor1,
    fontSize: 15,
  );
  TextStyle textStyle4 = const TextStyle(
    color: AppColors.fontColor1,
    fontSize: 13,
  );

  bool isOverallSelected = true;
  bool isOnVenueSelected = false;
  String getOrdinal(int number) {
    if (number % 10 == 1 && number % 100 != 11) {
      return '$number${number == 11 ? 'th' : 'st'}';
    } else if (number % 10 == 2 && number % 100 != 12) {
      return '$number${number == 12 ? 'th' : 'nd'}';
    } else if (number % 10 == 3 && number % 100 != 13) {
      return '$number${number == 13 ? 'th' : 'rd'}';
    } else {
      return '$number${number >= 4 && number <= 20 ? 'th' : ['th', 'st', 'nd', 'rd', 'th', 'th', 'th', 'th', 'th', 'th'][number % 10]}';
    }
  }

  late Future<Map<String, dynamic>> scorecardData;
  @override
  void initState() {
    scorecardData = scorecardApi(widget.matchId);
    super.initState();
  }

  void selectTeamA() {
    setState(() {
      selectedTeam = 'TeamA';
      isOverallSelected = true;
      isOnVenueSelected = false;
    });
  }

  void selectTeamB() {
    setState(() {
      selectedTeam = 'TeamB';
      isOverallSelected = false;
      isOnVenueSelected = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<Map<String , dynamic>>(
        future: scorecardData,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }else if(snapshot.hasError){
            return Text("Error : ${snapshot.hasError}",style: const TextStyle(color: Colors.white),);
          }else if (snapshot.hasData){
            final scoreCard = snapshot.data!['scoreCard'];
            // team 1
            final team1Scores = scoreCard[0]['scoreDetails'];
            final team1BatTeamDetails = scoreCard[0]['batTeamDetails'];
            final extrasData = scoreCard[0]['extrasData'];
            final team1SName = team1BatTeamDetails['batTeamShortName'];
            final batsmenData = team1BatTeamDetails['batsmenData'];
            final bowlTeamDetails = scoreCard[0]['bowlTeamDetails']['bowlersData'];
            final wicketsData = scoreCard[0]['wicketsData'];
            final partnershipsData = scoreCard[0]['partnershipsData'];
            final team1runs = team1Scores['runs'];
            final team1wickets = team1Scores['wickets'];
            final team1Overs = team1Scores['overs'];
            final extrasNoBalls = extrasData['noBalls'].toString();
            final extrasTotal = extrasData['total'].toString();
            final extrasByes = extrasData['byes'].toString();
            final extrasPenalty = extrasData['penalty'].toString();
            final extrasWides = extrasData['wides'].toString();
            final extrasLebByes = extrasData['legByes'].toString();
            List<String> batNameListTeam1 = [];

            for (var i = 1; i <= batsmenData.length; i++) {
              if (batsmenData['bat_$i']['outDesc'].isEmpty) {
                batNameListTeam1.add(batsmenData['bat_$i']['batName']);
              }
            }


            // team 2
            final team2Scores = scoreCard[1]['scoreDetails'];
            final team2BatTeamDetails = scoreCard[1]['batTeamDetails'];
            final extrasData2 = scoreCard[1]['extrasData'];
            final batsmenData2 = team2BatTeamDetails['batsmenData'];
            final bowlTeamDetails2 = scoreCard[1]['bowlTeamDetails']['bowlersData'];
            final wicketsData2 = scoreCard[1]['wicketsData'];
            final partnershipsData2 = scoreCard[1]['partnershipsData'];
            final team2SName = team2BatTeamDetails['batTeamShortName'];
            final team2runs = team2Scores['runs'];
            final team2wickets = team2Scores['wickets'];
            final team2Overs = team2Scores['overs'];
            final extrasNoBalls2 = extrasData2['noBalls'].toString();
            final extrasTotal2 = extrasData2['total'].toString();
            final extrasByes2 = extrasData2['byes'].toString();
            final extrasPenalty2 = extrasData2['penalty'].toString();
            final extrasWides2 = extrasData2['wides'].toString();
            final extrasLebByes2 = extrasData2['legByes'].toString();
            List<String> batNameListTeam2 = [];
            for (var i = 1; i <= batsmenData2.length; i++) {
              if (batsmenData2['bat_$i']['outDesc'].isEmpty) {
                batNameListTeam2.add(batsmenData2['bat_$i']['batName']);
              }
            }

            List<TableRow> batNameRowList = [];
            for (var i = 1; i <= batsmenData.length; i++) {
              if (batsmenData['bat_$i']['outDesc'].isNotEmpty && batsmenData['bat_$i']['outDesc'] != null) {
                if(selectedTeam == "TeamA") {
                  batNameRowList.add(
                    tableRow(
                      batterName: batsmenData['bat_$i']['batName'],
                      batterStatus: batsmenData['bat_$i']['outDesc'],
                      batterRuns: batsmenData['bat_$i']['runs'].toString(),
                      batterBowlFace: batsmenData['bat_$i']['balls'].toString(),
                      batterFours: batsmenData['bat_$i']['fours'].toString(),
                      batterSix: batsmenData['bat_$i']['sixes'].toString(),
                      batterSR: batsmenData['bat_$i']['strikeRate'].toString(),
                    ),
                  );
                  batNameRowList.add(tableRowDivider());
                }
              }
            }


            List<TableRow> batNameRowList2 = [];
            for (var i = 1; i <= batsmenData2.length; i++) {
              if (batsmenData2['bat_$i']['outDesc'].isNotEmpty && batsmenData2['bat_$i']['outDesc'] != null) {
                if(selectedTeam == "TeamB") {
                  batNameRowList2.add(
                    tableRow(
                      batterName: batsmenData2['bat_$i']['batName'],
                      batterStatus: batsmenData2['bat_$i']['outDesc'],
                      batterRuns: batsmenData2['bat_$i']['runs'].toString(),
                      batterBowlFace: batsmenData2['bat_$i']['balls']
                          .toString(),
                      batterFours: batsmenData2['bat_$i']['fours'].toString(),
                      batterSix: batsmenData2['bat_$i']['sixes'].toString(),
                      batterSR: batsmenData2['bat_$i']['strikeRate'].toString(),
                    ),
                  );
                  batNameRowList2.add(tableRowDivider());
                }
              }
            }
            print(batNameRowList2.length);

            String? noBallsTitle, byesTitle, penaltyTitle, widesTitle, legByesTitle,total, noBallsTitle2, byesTitle2, penaltyTitle2, widesTitle2, legByesTitle2, total2;
            if (extrasData != null) {
              if (extrasTotal != '0') {
                total = extrasTotal;
              } else {
                total = '';
              }
              if (extrasNoBalls != '0') {
                noBallsTitle = '$extrasNoBalls''nb,';
              } else {
                noBallsTitle = '';
              }
              if (extrasByes != '0') {
                byesTitle = '$extrasByes''b,';
              } else {
                byesTitle = '';
              }
              if (extrasPenalty != '0') {
                penaltyTitle = '$extrasPenalty''p,';
              } else {
                penaltyTitle = '';
              }
              if (extrasWides != '0') {
                widesTitle = '$extrasWides''w,';
              } else {
                widesTitle = '';
              }
              if (extrasLebByes != '0') {
                legByesTitle = '$extrasLebByes''lb,';
              } else {
                legByesTitle = '';
              }
            }else{
              total = '';
            }
            if (extrasData2 != null) {
              if (extrasTotal2 != '0') {
                total2 = extrasTotal2;
              } else {
                total2 = '';
              }
              if (extrasNoBalls2 != '0') {
                noBallsTitle2 = '$extrasNoBalls2''nb,';
              } else {
                noBallsTitle2 = '';
              }
              if (extrasByes2 != '0') {
                byesTitle2 = '$extrasByes2''b,';
              } else {
                byesTitle2 = '';
              }
              if (extrasPenalty2 != '0') {
                penaltyTitle2 = '$extrasPenalty2''p,';
              } else {
                penaltyTitle2 = '';
              }
              if (extrasWides2 != '0') {
                widesTitle2 = '$extrasWides2''w,';
              } else {
                widesTitle2 = '';
              }
              if (extrasLebByes2 != '0') {
                legByesTitle2 = '$extrasLebByes2''lb,';
              } else {
                legByesTitle2 = '';
              }
            }else{
              total2 = '';
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectTeamA();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            height: 40,
                            decoration: BoxDecoration(
                                color: isOverallSelected
                                    ? AppColors.buttonBoxColor
                                    : Colors.transparent,
                                border: Border.all(
                                    width: isOverallSelected ? 01 : 0.0,
                                    color: isOverallSelected
                                        ? Colors.transparent
                                        : AppColors.fontColor1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                                  "$team1SName $team1runs-$team1wickets ($team1Overs)",
                                  style: textStyle1,
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            selectTeamB();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            height: 40,
                            decoration: BoxDecoration(
                                color: isOnVenueSelected
                                    ? AppColors.buttonBoxColor
                                    : Colors.transparent,
                                border: Border.all(
                                    width: isOnVenueSelected ? 01 : 0.0,
                                    color: isOnVenueSelected
                                        ? Colors.transparent
                                        : AppColors.fontColor1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                                  "$team2SName $team2runs-$team2wickets ($team2Overs)",
                                  style: textStyle1,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Table(
                  columnWidths: const {0: FlexColumnWidth(4), 5: FlexColumnWidth(2)},
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Row(
                              children: [
                                Text("Batter ",
                                    style: TextStyle(
                                        color: AppColors.iconColor, fontSize: 14)),
                                Icon(Icons.arrow_downward_rounded,
                                    size: 14, color: AppColors.iconColor),
                              ],
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(child: Text("R", style: textStyle3)),
                        ),
                        TableCell(
                          child: Center(child: Text("B", style: textStyle3)),
                        ),
                        TableCell(
                          child: Center(child: Text("4s", style: textStyle3)),
                        ),
                        TableCell(
                          child: Center(child: Text("6s", style: textStyle3)),
                        ),
                        TableCell(
                          child: Container(
                              margin: const EdgeInsets.only(right: 20),
                              child: Center(child: Text("SR", style: textStyle3))),
                        ),
                      ],
                    ),
                    tableRowDivider(),
                    ...batNameRowList ,
                    ...batNameRowList2
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Extras",
                        style: textStyle1,
                      ),
                      selectedTeam == 'TeamA' ? Row(
                        children: [
                          Text(
                            total,
                            style: textStyle1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: Text(
                              "$legByesTitle $widesTitle $noBallsTitle $byesTitle $penaltyTitle",
                              style: textStyle3,
                            ),
                          )
                        ],
                      ) :Row(
                        children: [
                          Text(
                            total2,
                            style: textStyle1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: Text(
                              "$legByesTitle2 $widesTitle2 $noBallsTitle2 $byesTitle2 $penaltyTitle2",
                              style: textStyle3,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                divider,
                const SizedBox(
                  height: 10,
                ),
                Container(

                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Visibility(
                      visible: selectedTeam == "TeamA" ? batNameListTeam1.isNotEmpty : batNameListTeam2.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DID NOT BAT",
                            style: textStyle4,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          GridView.builder(
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.5,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                              ),
                              shrinkWrap: true,
                              itemCount: selectedTeam == "TeamA" ? batNameListTeam1.length : batNameListTeam2.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {

                                return ListTile(
                                  leading: const CircleAvatar(
                                    radius: 18,
                                  ),
                                  title: selectedTeam == "TeamA" ? Text(batNameListTeam1[index], style: textStyle1,) : Text(batNameListTeam2[index], style: textStyle1,),
                                  subtitle: Text(
                                    "SR: 110.35",
                                    style: textStyle2,
                                  ),
                                );
                                }

                              )
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Text(
                    "BOWLING",
                    style: textStyle4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: divider,
                ),
                Table(columnWidths: const {
                  0: FlexColumnWidth(4),
                  5: FlexColumnWidth(2)
                }, children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: const Row(
                            children: [
                              Text("Bowler ",
                                  style: TextStyle(
                                      color: AppColors.iconColor, fontSize: 14)),
                              Icon(Icons.arrow_downward_rounded,
                                  size: 14, color: AppColors.iconColor),
                            ],
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(child: Text("O", style: textStyle3)),
                      ),
                      TableCell(
                        child: Center(child: Text("M", style: textStyle3)),
                      ),
                      TableCell(
                        child: Center(child: Text("R", style: textStyle3)),
                      ),
                      TableCell(
                        child: Center(child: Text("W", style: textStyle3)),
                      ),
                      TableCell(
                        child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: Center(child: Text("Eco", style: textStyle3))),
                      ),
                    ],
                  ),
                  tableRowDivider(),
                  for (int i = 1; i <= (selectedTeam == "TeamA" ? bowlTeamDetails.length : bowlTeamDetails2.length); i++) ...[
                    bowlerTableRow(
                        bowlerName:
                        selectedTeam == "TeamA" ? bowlTeamDetails['bowl_$i']['bowlName'] : bowlTeamDetails2['bowl_$i']['bowlName'],
                        bowlerOver:
                        selectedTeam == "TeamA" ? bowlTeamDetails['bowl_$i']['overs'].toString() : bowlTeamDetails2['bowl_$i']['overs'].toString(),
                        bowlerMaiden:
                        selectedTeam == "TeamA" ? bowlTeamDetails['bowl_$i']['maidens'].toString() : bowlTeamDetails2['bowl_$i']['maidens'].toString(),
                        bowlerRun:
                        selectedTeam == "TeamA" ? bowlTeamDetails['bowl_$i']['runs'].toString() : bowlTeamDetails2['bowl_$i']['runs'].toString(),
                        bowlerWicket:
                        selectedTeam == "TeamA" ? bowlTeamDetails['bowl_$i']['wickets'].toString() : bowlTeamDetails2['bowl_$i']['wickets'].toString(),
                        bowlerEco:
                        selectedTeam == "TeamA" ? bowlTeamDetails['bowl_$i']['economy'].toString() : bowlTeamDetails2['bowl_$i']['economy'].toString(),
                    ),
                    tableRowDivider()
                  ]
                ]),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10),
                  child: Text(
                    "FALL OF WICKETS",
                    style: textStyle4,
                  ),
                ),
                divider,
                Table(columnWidths: const {
                  0: FlexColumnWidth(3),
                }, children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text("Batter ", style: textStyle4),
                        ),
                      ),
                      TableCell(
                        child: Center(child: Text("Score", style: textStyle4)),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Center(child: Text("Over", style: textStyle4)),
                        ),
                      ),
                    ],
                  ),
                  tableRowDivider2(),
                  for (int i = 1; i <= (selectedTeam == "TeamA" ? wicketsData.length : wicketsData2.length); i++) ...[
                    fallOfWicketRow(
                        batterName: selectedTeam == "TeamA" ? wicketsData['wkt_$i']['batName'] : wicketsData2['wkt_$i']['batName'],
                        runScore: selectedTeam == "TeamA" ? wicketsData['wkt_$i']['wktRuns'].toString() : wicketsData2['wkt_$i']['wktRuns'].toString(),
                        fallWicket: selectedTeam == "TeamA" ? wicketsData['wkt_$i']['wktNbr'].toString() : wicketsData2['wkt_$i']['wktNbr'].toString(),
                        wicketInOver: selectedTeam == "TeamA" ? wicketsData['wkt_$i']['wktOver'].toString() : wicketsData2['wkt_$i']['wktOver'].toString()),
                    tableRowDivider2()
                  ]
                ]),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10, bottom: 10),
                  child: Text(
                    "PARTNERSHIPS",
                    style: textStyle3,
                  ),
                ),
                divider,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Batter 1",
                        style: textStyle3,
                      ),
                      Text(
                        "Batter 2",
                        style: textStyle3,
                      ),
                    ],
                  ),
                ),

                divider,

                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: selectedTeam == "TeamA" ? partnershipsData?.length ?? 0 : partnershipsData2?.length ?? 0,
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          partnershipsPercentage(
                            batter1Run: selectedTeam == "TeamA" ? partnershipsData?['pat_${index + 1}']?['bat1Runs'] ?? 0 : partnershipsData2?['pat_${index + 1}']?['bat1Runs'] ?? 0,
                            batter1Ball: selectedTeam == "TeamA" ? partnershipsData?['pat_${index + 1}']?['bat1Balls'] ?? 0 : partnershipsData2?['pat_${index + 1}']?['bat1Runs'] ?? 0,
                            batter2Run: selectedTeam == "TeamA" ? partnershipsData?['pat_${index + 1}']?['bat2Runs'] ?? 0 : partnershipsData2?['pat_${index + 1}']?['bat2Runs'] ?? 0,
                            batter2Ball: selectedTeam == "TeamA" ? partnershipsData?['pat_${index + 1}']?['bat2Balls'] ?? 0 : partnershipsData2?['pat_${index + 1}']?['bat2Balls'] ?? 0,
                            batter1Name: selectedTeam == "TeamA" ? partnershipsData?['pat_${index + 1}']?['bat1Name'] ?? '' : partnershipsData2?['pat_${index + 1}']?['bat1Name'] ?? '',
                            batter2Name: selectedTeam == "TeamA" ? partnershipsData?['pat_${index + 1}']?['bat2Name'] ?? '' : partnershipsData2?['pat_${index + 1}']?['bat2Name'] ?? '',
                            wicketNumber: index + 1,
                          ),
                          divider
                        ],
                      );
                    }),

                const SizedBox(
                  height: 200,
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget partnershipsPercentage(
      {required int batter1Run,
      required int batter2Run,
      required int batter1Ball,
      required int batter2Ball,
      required int wicketNumber,
      required String batter1Name,
      required String batter2Name}) {

int totalRuns = batter1Run + batter2Run;
    int totalBalls = batter1Ball + batter2Ball;
    // double batter1Percentage = batter1Run / totalRuns;
    // double batter2Percentage = batter2Run / totalRuns;
    double batter1Percentage = totalRuns != 0 ? (batter1Run / totalRuns) : 0.0;
    double batter2Percentage = totalRuns != 0 ? (batter2Run / totalRuns) : 0.0;

return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${getOrdinal(wicketNumber)} Wicket".toUpperCase(), style: textStyle4),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formatPlayerName(batter1Name), style: textStyle1),
                  Row(
                    children: [
                      Text("$batter1Run ", style: textStyle1),
                      Text("($batter1Ball)", style: textStyle3),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text('$totalRuns', style: textStyle1),
                      Text(" ($totalBalls)", style: textStyle3),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80, // Set a fixed width or adjust as needed
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: FractionallySizedBox(
                              widthFactor:
                                  batter1Percentage, // Adjust the percentage as needed
                              child: Container(
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xff418018),
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(3)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80, // Set a fixed width or adjust as needed
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor:
                                  batter2Percentage, // Adjust the percentage as needed
                              child: Container(
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: Color(0xffa63f40),
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(3)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(child: Text(formatPlayerName(batter2Name), style: textStyle1,overflow: TextOverflow.ellipsis,)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("$batter2Run ", style: textStyle1),
                      Text("($batter2Ball)", style: textStyle3),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
