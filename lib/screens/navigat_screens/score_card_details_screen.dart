import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/enum_classes/match_type.dart';
import 'package:gameguru/widgets/appbar/live_match_appbar.dart';
import 'package:gameguru/widgets/appbar/match_complete_appbar.dart';
import 'package:gameguru/widgets/tabbar_view/score_card_details_tabbar_view/info_tabbar.dart';
import 'package:gameguru/widgets/tabbar_view/score_card_details_tabbar_view/match_commentary.dart';
import 'package:gameguru/widgets/tabbar_view/score_card_details_tabbar_view/match_complete_live_tabbar.dart';
import 'package:gameguru/widgets/tabbar_view/score_card_details_tabbar_view/ongoing_match_live_tabbar.dart';
import 'package:gameguru/widgets/tabbar_view/score_card_details_tabbar_view/scorecard_tabbar.dart';

class ScorecardDetailScreen extends StatefulWidget {
  final MatchType matchType;
  final int matchId;
  final String team1;
  final String team2;
  final String team1Run;
  final String team2Run;
  final String team1Wkts;
  final String team2Wkts;
  final String team1Overs;
  final String team2Overs;
  final String teamDesc;
  final String status;

  const ScorecardDetailScreen({super.key, required this.matchType, required this.matchId, required this.team1, required this.team2, required this.teamDesc, required this.team1Run, required this.team2Run, required this.team1Wkts, required this.team2Wkts, required this.team1Overs, required this.team2Overs, required this.status});

  @override
  State<ScorecardDetailScreen> createState() => _ScorecardDetailScreenState();
}

class _ScorecardDetailScreenState extends State<ScorecardDetailScreen> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this, initialIndex: 3); // Set the initial index to 3 (the "Live" tab).
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  Divider divider = const Divider(
    thickness: 0.2,
    color: Color(0xff686c68),
  );

  final List<String> tabLabels = [
    "Info",
    "Fantasy",
    "Commentary",
    "Live",
    "Scorecard",
    "Graph",
    "Points Table",
  ];


  TextStyle textStyle1 = const TextStyle(color: AppColors.fontColor1,fontSize: 12);
  TextStyle textStyle3 = const TextStyle(color: AppColors.fontColor1,fontSize: 9);
  TextStyle textStyle2 = const TextStyle(color: AppColors.primary,fontSize: 14);
  TextStyle textStyle4 = const TextStyle(color: Color(0xffdeaf65),fontSize: 12);
  @override
  Widget build(BuildContext context) {
    double appBarSize;
    appBarSize = 130;
    Widget appBar;
    appBar = LiveMatchAppbar(matchId: widget.matchId,);
    if (widget.matchType == MatchType.Live){
      appBar = LiveMatchAppbar(matchId: widget.matchId,);
      appBarSize = 130;
    }
    else if (widget.matchType == MatchType.Upcoming){
      appBar = matchCompleteAppbar(team1: widget.team1,team2: widget.team2,team1Overs: widget.team1Overs,team1Runs: widget.team1Run,team1Wkts: widget.team1Wkts,team2Overs: widget.team2Overs,team2Runs: widget.team2Run,team2Wkts: widget.team2Wkts, status: widget.status);
      appBarSize = 180;
    }else if (widget.matchType == MatchType.Finished){
      appBar = matchCompleteAppbar(team1: widget.team1,team2: widget.team2,team1Overs: widget.team1Overs,team1Runs: widget.team1Run,team1Wkts: widget.team1Wkts,team2Overs: widget.team2Overs,team2Runs: widget.team2Run,team2Wkts: widget.team2Wkts,status: widget.status);
      appBarSize = 180;
    }

    Widget liveTabBar;
    liveTabBar =  MatchCompleteLiveTabBarView(matchId: widget.matchId,);
    if (widget.matchType == MatchType.Live){
      liveTabBar = LiveMatchTabBar(matchId: widget.matchId,);
    }
    else if (widget.matchType == MatchType.Upcoming){
      liveTabBar = MatchCompleteLiveTabBarView(matchId: widget.matchId,);
    }else if (widget.matchType == MatchType.Finished){
      liveTabBar = MatchCompleteLiveTabBarView(matchId: widget.matchId,);
    }
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled){
            return [
              SliverAppBar(
                floating: false,
                snap: false,
                pinned: false,
                titleTextStyle: const TextStyle(color: AppColors.primary,fontSize: 16),
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.bottomsheetColor,

              scrolledUnderElevation: 0,
              title: Row(
                children: [
                  GestureDetector(onTap: (){
                    Navigator.pop(context);
                  },child: const Icon(Icons.arrow_back_rounded,size: 26, color: AppColors.primary,)),
                  const SizedBox(width: 8,),
                  Flexible(child: Text("${widget.team1} vs ${widget.team2}, ${widget.teamDesc}",overflow: TextOverflow.ellipsis)),
                ],
              ),
                actions: [
                  Transform.rotate(
                      angle: 45,
                      child: const Icon(Icons.push_pin,color: AppColors.fontColor2,size: 22,)),
                  const SizedBox(width: 5,),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(Icons.settings,color: AppColors.fontColor2,size: 22,),
                  ),
                ],
            ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.bottomsheetColor,
                floating: true,
                snap: true,
                pinned: true,
                scrolledUnderElevation: 0,
                toolbarHeight: appBarSize,
                titleSpacing: 0,
                title: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey, // Customize the divider color
                            width: 0.2, // Customize the divider width
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
                        tabs: tabLabels.map((e) => Tab(text: e,)).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: appBar,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: divider,
                    )
                  ],
                ),
              )

            ];
          },
          body: TabBarView(
            controller: _tabController,
            children:   [
              Tab(
                child: InfoTabBarView(matchId: widget.matchId),
              ),
              Tab(
                text: "Tab2",
              ),
              Tab(
                child: MatchCommentary(matchId: widget.matchId,),
              ),
              Tab(
                child: liveTabBar,
              ),
              Tab(
                child: ScorecardTabBarView(matchId: widget.matchId,),
              ),
              Tab(
                text: "Tab6",
              ),
              Tab(
                text: "Tab7",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
