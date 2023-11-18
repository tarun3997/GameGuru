import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/enum_classes/match_type.dart';
import 'package:gameguru/screens/tournament_screen.dart';
import 'package:gameguru/services/server/live_score_api.dart';
import 'package:gameguru/widgets/over_count_widget.dart';
import 'package:gameguru/widgets/poll_results_widget.dart';
import 'package:gameguru/widgets/score_cards/upcoming_match_card.dart';

class MatchCompleteLiveTabBarView extends StatefulWidget {
  final int matchId;
  const MatchCompleteLiveTabBarView({super.key, required this.matchId});
  @override
  State<MatchCompleteLiveTabBarView> createState() => _MatchCompleteLiveTabBarViewState();
}

class _MatchCompleteLiveTabBarViewState extends State<MatchCompleteLiveTabBarView> {
  TextStyle textStyle1 = const TextStyle(color: AppColors.primary,fontSize: 14);
  TextStyle textStyle2 = const TextStyle(color: AppColors.primary,fontSize: 16,fontWeight: FontWeight.w500);
  TextStyle textStyle3 = const TextStyle(color: AppColors.fontColor1,fontSize: 15,);
  TextStyle textStyle4 = const TextStyle(color: AppColors.fontColor1,fontSize: 12,);
  TextStyle textStyle5 = const TextStyle(color: Color(0xffdeaf65),fontSize: 14);

  Divider divider = const Divider(
    thickness: 0.3,
    color: Color(0xff686c68),
  );
  late Future<Map<String,dynamic>> liveScoreData;

  @override
  void initState() {
    liveScoreData = liveScore(widget.matchId);
    super.initState();
  }
  int overs = 4;
  @override
  Widget build(BuildContext context) {
    final width =  MediaQuery.of(context).size.width;
    final height =  MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: FutureBuilder<Map<String, dynamic>>(
        future: liveScoreData,
        builder: (context, snapshot){
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
            final overSummaryList = liveData['overSummaryList'];
            final playerOfTheMatch = liveData['matchHeader']['playersOfTheMatch'][0]['fullName'];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(height: 20,),
                  Text("Player of the Match",style: textStyle1,),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: width,
                    height: height * 0.13,
                    decoration: BoxDecoration(
                        color: AppColors.bottomsheetColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0,top: 10,bottom: 5),
                              child: Text(playerOfTheMatch,style: textStyle2,),
                            ),
                            divider,
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0,top: 5,bottom: 10),
                              child: Row(
                                children: [
                                  Text("131",style: textStyle2,),
                                  Text(" (84)",style: textStyle3,),
                                ],
                              ),
                            ),
                          ],),
                        const Positioned(
                            bottom: 0,
                            right: 20,
                            child: CircleAvatar(radius: 42,))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  pollResultWidget(context,'', ''),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Match Summary",style: textStyle1,),
                      const Text("Scorecard",style: TextStyle(color: AppColors.iconColor,fontSize: 13),)
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: width,
                    decoration: BoxDecoration(
                        color: AppColors.bottomsheetColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                const CircleAvatar(radius: 17),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("AFG",style: textStyle2,),
                                ),
                                Text("1st Innings",style: textStyle4,),
                              ],),
                              Row(children: [
                                Text("278-8 ",style: textStyle2,),
                                Text("(50.0)",style: textStyle4,),
                              ],),
                            ],
                          ),
                        ),
                        divider,
                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -2),
                          title: Text("1st best batsman",style: textStyle1,),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("80",style: textStyle2,),
                              Text(" (88)",style: textStyle4,),
                            ],
                          ),
                        ),
                        divider,

                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -2),
                          title: Text("2nd best batsman",style: textStyle1,),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("80",style: textStyle2,),
                              Text(" (88)",style: textStyle4,),
                            ],
                          ),
                        ),
                        divider,
                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -2),
                          title: Text("1st best bowler",style: textStyle1,),
                          trailing: Text("4-39",style: textStyle2,),
                        ),
                        divider,
                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -2),
                          title: Text("2nd best bowler",style: textStyle1,),
                          trailing: Text("2-43",style: textStyle2,),
                        ),
                        const SizedBox(height: 10,)
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: width,
                    decoration: BoxDecoration(
                        color: AppColors.bottomsheetColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                const CircleAvatar(radius: 17),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text("IND",style: textStyle2,),
                                ),
                                Text("2nd Innings",style: textStyle4,),
                              ],),
                              Row(children: [
                                Text("278-8 ",style: textStyle2,),
                                Text("(50.0)",style: textStyle4,),
                              ],),
                            ],
                          ),
                        ),
                        divider,
                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -2),
                          title: Text("1st best batsman",style: textStyle1,),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("131",style: textStyle2,),
                              Text(" (84)",style: textStyle4,),
                            ],
                          ),
                        ),
                        divider,

                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -2),
                          title: Text("2nd best batsman",style: textStyle1,),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("55",style: textStyle2,),
                              Text(" (56)",style: textStyle4,),
                            ],
                          ),
                        ),
                        divider,
                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -2),
                          title: Text("1st best bowler",style: textStyle1,),
                          trailing: Text("2-57",style: textStyle2,),
                        ),
                        divider,
                        ListTile(
                          dense: true,
                          visualDensity: const VisualDensity(vertical: -2),
                          title: Text("2nd best bowler",style: textStyle1,),
                          trailing: Text("0-31",style: textStyle2,),
                        ),
                        const SizedBox(height: 10,)
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text("Next Matches",style: textStyle1,),
                  const SizedBox(height: 14,),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      itemCount: 3,
                      itemBuilder: (context , index){
                        return const Center(child: UpcomingMatchScoreCard(matchStadium: '11th ODI', team1: 'New Zealand', team2: 'Bangladesh', startTime: '02:00 PM', team1ImageId: '', team2ImageId: '',));
                      }),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const TournamentScreen(initialTabIndex: 1,)));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                      width: width,
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.bottomsheetColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("See More Matches",style: textStyle1,),
                          const Text("World Cup 2023",style: TextStyle(color: AppColors.iconColor,fontSize: 13),),
                        ],),
                    ),
                  ),
                  const SizedBox(height: 50,)
                ],),
            );
          }
          return Container();
        },
      ),
    );
  }
}
