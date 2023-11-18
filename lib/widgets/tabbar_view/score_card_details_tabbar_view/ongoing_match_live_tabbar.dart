import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/services/server/live_score_api.dart';
import 'package:gameguru/utils/split_word.dart';
import 'package:gameguru/widgets/over_count_widget.dart';

class LiveMatchTabBar extends StatefulWidget {
  final int matchId;
  const LiveMatchTabBar({super.key, required this.matchId});

  @override
  State<LiveMatchTabBar> createState() => _LiveMatchTabBarState();
}

class _LiveMatchTabBarState extends State<LiveMatchTabBar> {
  TextStyle textStyle1 = const TextStyle(color: AppColors.primary,fontSize: 14);
  TextStyle textStyle2 = const TextStyle(color: AppColors.primary,fontSize: 16,fontWeight: FontWeight.w500);
  TextStyle textStyle3 = const TextStyle(color: AppColors.fontColor1,fontSize: 15,);
  TextStyle textStyle4 = const TextStyle(color: AppColors.fontColor1,fontSize: 12,);
  TextStyle textStyle6 = const TextStyle(color: AppColors.fontColor1,fontSize: 10,);
  TextStyle textStyle5 = const TextStyle(color: Color(0xffdeaf65),fontSize: 14);

  late Future<Map<String,dynamic>> liveScoreData;

  @override
  void initState() {
    liveScoreData = liveScore(widget.matchId);
    super.initState();
  }
  Divider divider = const Divider(
    thickness: 0.3,
    color: Color(0xff686c68),
  );
  int overs = 4;
  int teamAWinChance = 90;
  int teamBWinChance = 10;
  bool isBatting = true;
  bool isBatting2 = false;
  int teamAVotes = 0;
  int teamBVotes = 0;
  bool isVoteSelectedForTeamA = false;
  bool isVoteSelectedForTeamB = false;

  void votesForTeamA(){
    setState(() {
      teamAVotes++;
    });
  }
  void votesForTeamB(){
    setState(() {
      teamBVotes++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width =  MediaQuery.of(context).size.width;

    return FutureBuilder<Map<String, dynamic>>(
      future: liveScoreData,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }else if(snapshot.hasError){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: const Text("Sorry, Match Details are currently unavailable for this match. Please select a different match to view its details.",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Go Back!"))
            ],
          );
        }else if(snapshot.hasData){
          final liveData = snapshot.data!;
          final crr = liveData['currentRunRate'];
          final rrr = liveData['requiredRunRate'].toString();
          final toss = liveData['matchHeader']['tossResults']['tossWinnerName'];
          final target = liveData['target'].toString();
          final team1 = liveData['matchHeader']['team1']['shortName'];
          final team2 = liveData['matchHeader']['team2']['shortName'];
          final status = liveData['status'];
          final partnerShip = liveData['partnerShip'];
          final bowlerStriker = liveData['bowlerStriker'];
          final bowlName = bowlerStriker['bowlName'];
          final bowlWkts = bowlerStriker['bowlWkts'];
          final bowlRuns = bowlerStriker['bowlRuns'];
          final bowlOvs = bowlerStriker['bowlOvs'];
          final bowlEcon = bowlerStriker['bowlEcon'];

          final batsmanStriker = liveData['batsmanStriker'];
          final overSummaryList = liveData['overSummaryList'];
          final lastWicket = liveData['lastWicket'];
          final batName = batsmanStriker['batName'].toString();
          final batRuns = batsmanStriker['batRuns'];
          final batBalls = batsmanStriker['batBalls'];
          final batFours = batsmanStriker['batFours'];
          final batSixes = batsmanStriker['batSixes'];
          final batStrikeRate = batsmanStriker['batStrikeRate'];
          final batsmanNonStriker = liveData['batsmanNonStriker'];
          final batName2 = batsmanNonStriker['batName'];
          final batRuns2 = batsmanNonStriker['batRuns'];
          final batBalls2 = batsmanNonStriker['batBalls'];
          final batFours2 = batsmanNonStriker['batFours'];
          final batSixes2 = batsmanNonStriker['batSixes'];
          final batStrikeRate2 = batsmanNonStriker['batStrikeRate'];

          String formatAndAssignName(String name) {
            return name?.isNotEmpty == true ? formatPlayerName(name) : '';
          }
          String BatName = formatAndAssignName(batName);
          String BatName2 = formatAndAssignName(batName2);
          String BowlName = formatAndAssignName(bowlName);
          bool? statusValue;
          if(status == ''){
            statusValue = false;
          }else{
            statusValue = true;
          }
          String? RRR, runRate, lastWkt , lastWktName, partBalls , partRuns, pShip , title, titleValue;

          if(lastWicket == '' && partnerShip == ''){
            lastWkt = '';
            lastWktName = '';
            pShip = '';
            partBalls = '';
            partRuns = '';
          }else{
            lastWkt = 'Last wkt:';
            lastWktName = lastWicket;
            pShip = 'P`ship:';
            partBalls = partnerShip['balls'].toString();
            partRuns = partnerShip['runs'].toString();
          }
          if(rrr == '0' ){
            title = 'Target:';
            titleValue = target;
            RRR = 'RRR';
            runRate = rrr;
          }else{
            title = 'Toss:';
            titleValue = toss;
            RRR = '';
            runRate = '';
          }
          return Column(
            children: [
              Container(
                width: width,
                color: AppColors.bottomsheetColor,
                padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Text("CRR: $crr",style: textStyle4,),
                      const SizedBox(width: 16,),
                      Text("$RRR $runRate",style: textStyle4,),
                    ],),
                    Text("$title $titleValue",style: textStyle4,)
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    statusValue ? Container(
                      width: width,
                      decoration: const BoxDecoration(
                          color: Color(0xff0e1317),
                          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Center(child: Text("$status",style: textStyle5),),
                      ),
                    ) : Container(),
                    SizedBox(
                        height: 40,
                        child: ListView.builder(
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: overs,
                            itemBuilder: (context, index){
                              final overSummary = overSummaryList[index];
                              final runs = overSummary['runs'];
                              final overs = overSummary['overNum'];
                              final o_summary = overSummary['o_summary'].toString();
                              List<String> oSummaryList = o_summary.split(RegExp(r'\s+')).where((elements) => elements.trim().isNotEmpty).toList();
                              double originalValue = overs;
                              int roundedValue = originalValue.ceil();
                              return OverCountWidget(roundedValue, '$runs',oSummaryList);
                            } )),
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: width,
                      decoration: BoxDecoration(
                          color: AppColors.bottomsheetColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("$team1",style: textStyle1,),
                                Text("$teamAWinChance%",style: textStyle1,),
                              ],),
                          ),
                          Expanded(
                            flex: 8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.info_outline_rounded,size: 18,color: AppColors.fontColor1,),
                                    Text(" Realtime Win %",style: textStyle4,)
                                  ],),
                                const SizedBox(height: 10,),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  height: 5,
                                  child: Row(children: [
                                    Expanded(
                                        flex: teamAWinChance,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
                                            color: Color(0xff7e7e7e),
                                          ),)),
                                    Expanded(
                                        flex: teamBWinChance,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.horizontal(right: Radius.circular(5)),
                                            color: Color(0xff5b688a),
                                          ),
                                        )),
                                  ],),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("$team2",style: textStyle1,),
                                Text("$teamBWinChance%",style: textStyle1,),
                              ],),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),

                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: width,
                      decoration: BoxDecoration(
                          color: AppColors.bottomsheetColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(children: [
                        Table(columnWidths: const {
                          0: FlexColumnWidth(3),
                          4: FlexColumnWidth(1.3)
                        },
                          children: [
                            TableRow(
                                children: [
                                  TableCell(child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text("Batter",style: textStyle4,),
                                  )),
                                  TableCell(child: Center(child: Text("R (B)",style: textStyle4,))),
                                  TableCell(child: Center(child: Text("4s",style: textStyle4,))),
                                  TableCell(child: Center(child: Text("6s",style: textStyle4,))),
                                  TableCell(child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Center(child: Text("SR",style: textStyle4,)),
                                  )),
                                ]
                            ),
                            TableRow(
                                children: [
                                  TableCell(child: divider),
                                  TableCell(child: divider),
                                  TableCell(child: divider),
                                  TableCell(child: divider),
                                  TableCell(child: divider),
                                ]
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isBatting2 = false;
                                        isBatting = true;
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: isBatting ? Colors.white.withOpacity(0.08) : Colors.transparent,
                                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(4)),
                                      ),
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Flexible(
                                            fit: FlexFit.loose,
                                              child: Text("$BatName ", style: textStyle1,overflow: TextOverflow.ellipsis,),
                                            ),
                                            isBatting ? Transform.rotate(
                                              angle: 55,
                                              child: const Icon(Icons.sports_cricket_sharp, size: 14, color: Color(0xffeaaf55)),
                                            ) : const Text("")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    color: isBatting ? Colors.white.withOpacity(0.08) : Colors.transparent,
                                    height: 30,
                                    child: Row(
                                      children: [
                                        Text("$batRuns", style: textStyle1),
                                        Text(" ($batBalls)", style: textStyle4),
                                      ],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    color: isBatting ? Colors.white.withOpacity(0.08) : Colors.transparent,
                                    height: 30,
                                    child: Center(child: Text("$batFours", style: textStyle1)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    color: isBatting ? Colors.white.withOpacity(0.08) : Colors.transparent,
                                    height: 30,
                                    child: Center(child: Text("$batSixes", style: textStyle1)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: isBatting ? Colors.white.withOpacity(0.08) : Colors.transparent,
                                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
                                    ),
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Center(child: Text("$batStrikeRate", style: textStyle1)),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isBatting2 = true;
                                        isBatting = false;
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: isBatting2 ? Colors.white.withOpacity(0.08) : Colors.transparent,
                                        borderRadius: const BorderRadius.horizontal(left: Radius.circular(4)),
                                      ),
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Flexible(
                                                fit: FlexFit.loose,
                                                child: Text("$BatName2 ", style: textStyle1,overflow: TextOverflow.ellipsis,)),
                                            isBatting2 ? Transform.rotate(
                                              angle: 55,
                                              child: const Icon(Icons.sports_cricket_sharp, size: 14, color: Color(0xffeaaf55)),
                                            ) : const Text("")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    color: isBatting2 ? Colors.white.withOpacity(0.08) : Colors.transparent,
                                    height: 30,
                                    child: Row(
                                      children: [
                                        Text("$batRuns2", style: textStyle1),
                                        Text(" ($batBalls2)", style: textStyle4),
                                      ],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    color: isBatting2 ? Colors.white.withOpacity(0.08) : Colors.transparent,
                                    height: 30,
                                    child: Center(child: Text("$batFours2", style: textStyle1)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    color: isBatting2 ? Colors.white.withOpacity(0.08) : Colors.transparent,
                                    height: 30,
                                    child: Center(child: Text("$batSixes2", style: textStyle1)),
                                  ),
                                ),
                                TableCell(
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: isBatting2 ? Colors.white.withOpacity(0.08) : Colors.transparent,
                                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
                                    ),
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Center(child: Text("$batStrikeRate2", style: textStyle1)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            children: [
                              divider,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text("$pShip $partRuns ($partBalls)",style: textStyle4,)),
                                  Expanded(child: Text("$lastWkt $lastWktName",style: textStyle4,overflow: TextOverflow.ellipsis),),
                                ],)
                            ],
                          ),
                        )
                      ],),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: width,
                      decoration: BoxDecoration(
                          color: AppColors.bottomsheetColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(children: [
                        Table(columnWidths: const {
                          0: FlexColumnWidth(3),
                          4: FlexColumnWidth(1.3)
                        },
                          children: [
                            TableRow(
                                children: [
                                  TableCell(child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Text("Bowler",style: textStyle4,),
                                  )),
                                  TableCell(child: Center(child: Text("W-R",style: textStyle4,))),
                                  TableCell(child: Center(child: Text("Overs",style: textStyle4,))),
                                  TableCell(child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Center(child: Text("Econ",style: textStyle4,)),
                                  )),
                                ]
                            ),
                            TableRow(
                                children: [
                                  TableCell(child: divider),
                                  TableCell(child: divider),
                                  TableCell(child: divider),
                                  TableCell(child: divider),
                                ]
                            ),
                            TableRow(
                              children: [
                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("$BowlName ", style: textStyle1),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(child: Text("$bowlWkts-$bowlRuns", style: textStyle1)),
                                ),
                                TableCell(
                                  child: Center(child: Text("$bowlOvs", style: textStyle1)),
                                ),

                                TableCell(
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Center(child: Text("$bowlEcon", style: textStyle1)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      ],),
                    ),
                    const SizedBox(height: 20,),
                    winPolWidget(context, team1: '$team1', team2: '$team2'),
                  ],),
              ),
            ],
          );
        }
        return Container();
      }
    );
  }

  Widget winningPercentage(double size, double progress, Color progressColor, Color bgColor){


    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: SizedBox(
        height: size,
        width: size,
        child: Stack(
          children: [
            Container(
              color: bgColor,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size * progress,
                color: progressColor,
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget winPolWidget(context , {required String team1, required String team2}){
    int totalVotes = teamAVotes + teamBVotes;

    double percentageTeamA = (teamAVotes / totalVotes) * 100;
    double percentageTeamB = (teamBVotes / totalVotes) * 100;

    double percentageLineTeamA = teamAVotes / totalVotes;
    double percentageLineTeamB = teamBVotes / totalVotes;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(12),
      width: width,
      height: height * 0.14,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.buttonBoxColor2
      ),
      child:  Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Who will win?",style: textStyle1,),
            Text("Total Votes: $totalVotes",style: const TextStyle(color: AppColors.fontColor1,fontSize: 10),),
          ],),
        const SizedBox(height: 18,),
        Row(children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                votesForTeamA();
                setState(() {
                  isVoteSelectedForTeamA = true;
                  isVoteSelectedForTeamB = true;
                });
              },
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.5,color: AppColors.fontColor1)
                    ),
                    child: Center(child: isVoteSelectedForTeamA ? Text("$team1 : ${percentageTeamA.toStringAsFixed(0)}%",style: const TextStyle(color: AppColors.primary,fontSize: 14)) :  Text("$team1",style: const TextStyle(color: AppColors.primary,fontSize: 14))
                    ),
                  ),
                  if(isVoteSelectedForTeamA)
                  FractionallySizedBox(
                    widthFactor: percentageLineTeamA,
                    child: Container(
                      margin: const EdgeInsets.only(right: 12,left: 8),
                      height: 45,
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(
                            width: 0.8,
                            color: Colors.white
                          ))
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(onTap: (){
              votesForTeamB();
              setState(() {
                isVoteSelectedForTeamA = true;
                isVoteSelectedForTeamB = true;
              });
            },
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.5,color: AppColors.fontColor1)
                    ),
                    child: Center(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon(Icons.emoji_events_rounded,color: Colors.yellowAccent,size: 16,),
                        isVoteSelectedForTeamB ? Text("$team2 : ${percentageTeamB.toStringAsFixed(0)}%",style: const TextStyle(color: AppColors.primary,fontSize: 14)) : Text("$team2",style: const TextStyle(color: AppColors.primary,fontSize: 14))
                      ],
                    )),
                  ),
                  if(isVoteSelectedForTeamB)
                    FractionallySizedBox(
                    widthFactor: percentageLineTeamB,
                    child: Container(
                      margin: const EdgeInsets.only(left: 12,right: 8),
                      height: 45,
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(
                              width: 0.8,
                              color: Colors.white
                          ))
                      ),
                    ),)
                ],
              ),
            ),
          ),
        ],),

      ],),
    );

  }
}
