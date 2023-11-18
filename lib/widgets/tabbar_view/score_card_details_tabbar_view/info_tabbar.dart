import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/services/server/match_info_api.dart';
import 'package:gameguru/widgets/poll_results_widget.dart';
import 'package:gameguru/widgets/score_cards/finished_match_score_card.dart';
import 'package:intl/intl.dart';

class InfoTabBarView extends StatefulWidget {
  final int matchId;
  const InfoTabBarView({super.key, required this.matchId});

  @override
  State<InfoTabBarView> createState() => _InfoTabBarViewState();
}

class _InfoTabBarViewState extends State<InfoTabBarView> {

  final GlobalKey<AnimatedCircularChartState> _chartKey = GlobalKey<AnimatedCircularChartState>();

  List<CircularStackEntry> data = <CircularStackEntry>[
    CircularStackEntry(
      <CircularSegmentEntry>[
        CircularSegmentEntry(56, Colors.red[200], rankKey: 'BatFirst'),
        CircularSegmentEntry(31, Colors.blue[200], rankKey: 'BowlFirst'),
        CircularSegmentEntry(13, Colors.yellow[200], rankKey: 'noResult'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];
  List<String> team1Form = ['*','W','L','W','W','W'];
  List<String> team2Form = ['L','W','L','L','L'];
  TextStyle textStyle1 = const TextStyle(color: AppColors.primary,fontSize: 14,fontWeight: FontWeight.w500);
  TextStyle textStyle2 = const TextStyle(color: AppColors.fontColor1,fontSize: 11,);
  TextStyle textStyle3 = const TextStyle(color: Colors.white,fontSize: 12);
  TextStyle textStyle4 = const TextStyle(color: Color(0xffdeaf65),fontSize: 12);

  Divider divider = const Divider(
    thickness: 0.3,
    color: Color(0xff686c68),
  );

  bool isOverallSelected = true;
  bool isOnVenueSelected = false;
  late Future<Map<String, dynamic>> matchInfoData;
  @override
  void initState() {
    matchInfoData = matchInfo(widget.matchId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: FutureBuilder<Map<String, dynamic>>(
        future: matchInfoData,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            return Text("Error : ${snapshot.hasError}",style: const TextStyle(color: Colors.white),);
          }else if(snapshot.hasData){
            final infoMatch = snapshot.data!;
            final toss = infoMatch['matchInfo']['status'];
            final matchStartTime = infoMatch['matchInfo']['matchStartTimestamp'];
            final matchDesc = infoMatch['matchInfo']['matchDescription'];
            final series = infoMatch['matchInfo']['series']['name'];
            final venue = infoMatch['matchInfo']['venue'];
            final team1 = infoMatch['matchInfo']['team1'];
            final team2 = infoMatch['matchInfo']['team2'];
            final umpire1 = infoMatch['matchInfo']['umpire1']['name'];
            final umpire2 = infoMatch['matchInfo']['umpire2']['name'];
            final umpire3 = infoMatch['matchInfo']['umpire3']['name'];
            final referee = infoMatch['matchInfo']['referee']['name'];
            final team1Name = team1['name'];
            final team2Name = team2['name'];
            final team1ShortName = team1['shortName'];
            final team2ShortName = team2['shortName'];
            final venueName = venue['name'];
            final venueCity = venue['city'];
            final venueCountry = venue['country'];

            final broadcastInfo = infoMatch['broadcastInfo'][0]['broadcaster'];
            List<String> broadcaster = [];
            for(int i = 0; i < broadcastInfo.length; i++){
              final value = broadcastInfo[i]['value'];
              broadcaster.add(value);
            }


            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(matchStartTime);
            String formatedDateTime = DateFormat('EEEE, dd MMM, hh:mm a').format(dateTime);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 15,bottom: 10),
                  child: Text(toss,style: textStyle4,),
                ),
                divider,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(matchDesc,style: textStyle2,),
                          Row(
                            children: [
                              Text(series,style: textStyle1,),
                              const SizedBox(width: 5,),
                              const Icon(Icons.arrow_forward_ios_rounded,color: AppColors.iconColor,size: 14,)
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: width * 0.14,
                        height: height * 0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                      )
                    ],),
                ),
                divider,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Icon(Icons.calendar_today,color: AppColors.fontColor1,size: 20,),
                        const SizedBox(width: 10,),
                        Text(formatedDateTime,style: textStyle3,)

                      ],),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            const Icon(Icons.location_on,color: AppColors.fontColor1,size: 20,),
                            const SizedBox(width: 10,),
                            Text("$venueName, $venueCity, $venueCountry",style: const TextStyle(color: AppColors.iconColor,fontSize: 12),overflow: TextOverflow.ellipsis,)

                          ],),
                          const Icon(Icons.keyboard_arrow_down,color: AppColors.iconColor,)
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Row(children: [
                        const Icon(Icons.airplay_outlined,color: AppColors.fontColor1,size: 20,),
                        const SizedBox(width: 10,),
                        Text(broadcaster.join(', '),style: textStyle3,)
                      ],),
                      const SizedBox(height: 30,),
                      Text("Playing XI",style: textStyle1,),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(radius: 14,),
                                SizedBox(width: 15,),
                                Text(team1Name,style: TextStyle(color: AppColors.iconColor,fontSize: 14),)
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,color: AppColors.fontColor1,)
                          ],),
                      ),
                      divider,
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(radius: 14,),
                                SizedBox(width: 15,),
                                Text(team2Name,style: TextStyle(color: AppColors.iconColor,fontSize: 14),)
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios_rounded,color: AppColors.fontColor1,)
                          ],),
                      ),
                      divider,
                      const SizedBox(height: 10,),
                      pollResultWidget(context,team1ShortName, team2ShortName),
                      const SizedBox(height: 30,),
                      Row(
                        children: [
                          Text("Team form",style: textStyle1,),
                          const SizedBox(width: 8,),
                          Text("(Last 5 matches)",style: textStyle2,),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(radius: 14,),
                                const SizedBox(width: 15,),
                                Text("IND",style: textStyle3,)
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: AppColors.fontColor1,width: 0.1)
                                  ),
                                  child: Center(child: Text("*",style: textStyle2,)),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
                                  height: 25,
                                  width: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: team1Form.length,
                                    itemBuilder: (context, index){
                                      return wlContainer(team1Form[index]);
                                    },
                                  ),
                                ),
                                const Icon(Icons.keyboard_arrow_down_rounded,color: AppColors.fontColor1,)

                              ],
                            ),
                          ],),
                      ),
                      divider,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(radius: 14,),
                                const SizedBox(width: 15,),
                                Text("AFG",style: textStyle3,)
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: AppColors.fontColor1,width: 0.1)
                                  ),
                                  child: Center(child: Text("*",style: textStyle2,)),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
                                  height: 25,
                                  width: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: team2Form.length,
                                    itemBuilder: (context, index){
                                      return wlContainer(team2Form[index]);
                                    },
                                  ),
                                ),
                                const Icon(Icons.keyboard_arrow_down_rounded,color: AppColors.fontColor1,)

                              ],
                            ),
                          ],),
                      ),
                      divider,
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Head to Head",style: textStyle1,),
                              const SizedBox(width: 4,),
                              Text("(Last 10 matches)",style: textStyle2,),
                            ],
                          ),
                          const Text("All Matches",style: TextStyle(color: AppColors.iconColor,fontSize: 13),)
                        ],
                      ),
                      const SizedBox(height: 30,),
                      Center(
                        child: SizedBox(
                          width: width * 0.7,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                CircleAvatar(radius: 20,),
                                SizedBox(height: 5,),
                                Text("IND",style: TextStyle(color: AppColors.fontColor1),)
                              ],),
                              Text("2 - 0",style: TextStyle(color: AppColors.iconColor,fontSize: 28,fontWeight: FontWeight.w500),),
                              Column(children: [
                                CircleAvatar(radius: 20,),
                                SizedBox(height: 5,),
                                Text("AFG",style: TextStyle(color: AppColors.fontColor1),)
                              ],),
                            ],),
                        ),
                      ),
                      const SizedBox(height: 30,),
                      const Center(
                        child: Column(
                          children: [
                            FinishedMatchScoreCard(
                              matchStadium: '28th ODI, World Cup 2019 on 22 Jun', team1: 'IND', team2: 'AFG', wonTeam: 'IND', winBy: '11 runs', team1Score: '224', team1Wickets: '8', team1Overs: '50.0', team2Score: '213', team2Wickets: '9', team2Overs: '49.5',
                            ),
                            FinishedMatchScoreCard(
                              matchStadium: '28th ODI, World Cup 2019 on 22 Jun', team1: 'IND', team2: 'AFG', wonTeam: 'IND', winBy: '11 runs', team1Score: '224', team1Wickets: '8', team1Overs: '50.0', team2Score: '213', team2Wickets: '9', team2Overs: '49.5',
                            ),
                            FinishedMatchScoreCard(
                              matchStadium: '28th ODI, World Cup 2019 on 22 Jun', team1: 'IND', team2: 'AFG', wonTeam: 'IND', winBy: '11 runs', team1Score: '224', team1Wickets: '8', team1Overs: '50.0', team2Score: '213', team2Wickets: '9', team2Overs: '49.5',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Row(
                        children: [
                          Text("Team Comparison",style: textStyle1,),
                          const SizedBox(width: 4,),
                          Text("(Last 10 matches)",style: textStyle2,),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          GestureDetector(onTap: (){
                            setState(() {
                              isOverallSelected = true;
                              isOnVenueSelected = false;
                            });
                          },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              height: 35,
                              decoration: BoxDecoration(
                                  color: isOverallSelected ? AppColors.buttonBoxColor : Colors.transparent,
                                  border: Border.all(width:
                                  isOverallSelected ? 01 : 0.0,
                                      color: isOverallSelected ? Colors.transparent : AppColors.fontColor1
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Text("Overall",style: textStyle1,)),
                            ),
                          ),
                          GestureDetector(onTap: (){
                            setState(() {
                              isOverallSelected = false;
                              isOnVenueSelected = true;
                            });
                          },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              height: 35,
                              decoration: BoxDecoration(
                                  color: isOnVenueSelected ? AppColors.buttonBoxColor : Colors.transparent,
                                  border: Border.all(width:
                                  isOnVenueSelected ? 01 : 0.0,
                                      color: isOnVenueSelected ? Colors.transparent : AppColors.fontColor1
                                  ),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(child: Text("On Venue",style: textStyle1,)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            const CircleAvatar(
                              radius: 16,
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("IND",style: textStyle3,),
                                Text("vs all teams",style: textStyle2,),
                              ],
                            )
                          ],),
                          Row(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("IND",style: textStyle3,),
                                Text("vs all teams",style: textStyle2,),
                              ],
                            ),
                            const SizedBox(width: 10,),
                            const CircleAvatar(
                              radius: 16,
                            ),

                          ],),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      divider,
                      comparison("10","10",Colors.white,"Matched Played"),
                      divider,
                      comparison("80%","20%",Colors.lightGreenAccent,"Win"),
                      divider,
                      comparison("246","224",Colors.lightGreenAccent,"Average Score"),
                      divider,
                      comparison("399","331",Colors.lightGreenAccent,"Highest Score"),
                      divider,
                      comparison("51","59",Colors.pinkAccent,"Lowest Score"),
                      divider,
                      const SizedBox(height: 25,),
                      const Row(children: [
                        Icon(Icons.location_on,color: AppColors.fontColor1,size: 20,),
                        SizedBox(width: 10,),
                        Text("Arun Jaitley Stadium, Delhi, India",style: TextStyle(color: AppColors.iconColor,fontSize: 12),)

                      ],),
                      const SizedBox(height: 15,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 18),
                        width: width,
                        height: height * 0.16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:  Border.all(color: AppColors.fontColor1,width: 0.1)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  const CircleAvatar(backgroundColor: Colors.yellow,radius: 18,),
                                  const SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Delhi, India",style: textStyle2,),
                                      Text("29.6°C",style: textStyle1,),
                                    ],)
                                ],),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      const Icon(Icons.water_drop_rounded,color: AppColors.iconColor,size: 18,),
                                      const SizedBox(width: 10,),
                                      Text("34 % (Humidity)",style: textStyle2,)
                                    ],),
                                    const SizedBox(height: 5,),
                                    Row(children: [
                                      const Icon(Icons.cloudy_snowing,color: AppColors.iconColor,size: 18,),
                                      const SizedBox(width: 10,),
                                      Text("0 % Chance",style: textStyle2,)
                                    ],),
                                  ],)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Clear",style: TextStyle(color: AppColors.primary,fontSize: 12),),
                                Text("updated at 11 Oct, 09:12 PM",style: textStyle2,),
                              ],)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 18),
                        width: width,
                        height: height * 0.16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:  Border.all(color: AppColors.fontColor1,width: 0.1)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AnimatedCircularChart(size: const Size(120.0,120.0),
                              initialChartData: data,
                              chartType: CircularChartType.Radial,
                              percentageValues: true,
                              labelStyle: textStyle1,
                              key: _chartKey,
                              holeLabel: "16",
                            ),
                            SizedBox(
                              width: 130,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(children: [
                                    Text("Win Bat first",style: textStyle2,),
                                    const SizedBox(width: 20,),
                                    const Text("56%",style: TextStyle(color: Colors.red),)
                                  ],),
                                  divider,
                                  Row(children: [
                                    Text("Win Bowl first",style: textStyle2,),
                                    const SizedBox(width: 20,),
                                    const Text("31%",style: TextStyle(color: Colors.blue),)
                                  ],),
                                ],),
                            )

                          ],),
                      ),
                      const SizedBox(height: 15,),
                      divider,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Avg 1st Innings",style: textStyle2,),
                                Text("216",style: textStyle1,),
                              ],),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Avg 2nd Innings",style: textStyle2,),
                                Text("173",style: textStyle1,),
                              ],),
                          ],
                        ),
                      ),
                      divider,
                      stadiumAvg("Highest Total","428-5","(50 Ov) by SA","SA vs SL"),
                      divider,
                      stadiumAvg("Lowest Total","99-10","(27.1 Ov) by SA","SA vs IND"),
                      divider,
                      stadiumAvg("Highest Chased","238-2","(36.4 Ov) by IND","IND vs ENG"),
                      divider,
                      stadiumAvg("Lowest Defended","167-10","(43.4 Ov) by IND","IND vs PAK"),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          Text("Pace vs Spin on Venue",style: textStyle1,),
                          const SizedBox(width: 4,),
                          Text("(Last 10 matches)",style: textStyle2,),
                        ],
                      ),
                      const SizedBox(height: 20,),

                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          width: width * 0.86,
                          height: height * 0.065,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Pace", style: TextStyle(color: AppColors.primary)),
                                    Text("73 Wkt", style: TextStyle(color: Color(0xff470869), fontSize: 12)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        height: 7,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                                          color: Color(0xffa74a6e),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("57%", style: textStyle2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: FractionallySizedBox(
                                  widthFactor: 1.0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        height: 7,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                                          color: Color(0xff6855b1),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("43%", style: textStyle2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 8.0, left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Spin", style: TextStyle(color: AppColors.primary)),
                                    Text("54 Wkt", style: TextStyle(color: Color(0xff8a3131), fontSize: 12)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20,),
                      Text("Umpire",style: textStyle1,),

                      ListTile(
                        titleTextStyle: textStyle2,

                        title: const Text("Umpire"),
                        subtitle: Text("$umpire1, $umpire2, $umpire3 ",style: TextStyle(color: Colors.white, fontSize: 12),),
                      ),

                      divider,
                      ListTile(
                        titleTextStyle: textStyle2,
                        title: const Text("Referee"),
                        subtitle:  Text(referee,style: TextStyle(color: Colors.white, fontSize: 12)),
                      ),

                    ],),
                ),
                const SizedBox(height: 100,),

              ],);
          }
          return Container();
        },
      ),
    );
  }

  Widget stadiumAvg(String title, String score, String over, String between){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(title,style: textStyle2,),
            Row(
              children: [
                Text(score,style: textStyle1,),
                const SizedBox(width: 6,),
                Text(over,style: textStyle2,),
              ],
            ),
          ],),
          Text(between,style: const TextStyle(color: AppColors.iconColor),),
        ],
      ),
    );
  }

  Widget wlContainer(String teamForm){
    bool isTeamWin = teamForm == 'W';
    if (teamForm != 'W' && teamForm != 'L') {
      return Container(); // Return an empty container for invalid values
    }
    return Container(
      margin: const EdgeInsets.only(left: 5),
      width: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isTeamWin ? Colors.green : Colors.red
      ),
      child: Center(child: Text(teamForm,style: const TextStyle(color: AppColors.primary),)),
    );
  }

  Widget comparison(String team1, String team2, Color color,String type){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(team1,style: TextStyle(color: color,fontSize: 15),),
          Text(type,style: textStyle2,),
          Text(team2,style: const TextStyle(color: Colors.white,fontSize: 15),),
        ],),
    );

  }
}
