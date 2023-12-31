import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/services/server/series_server/series_matches_api.dart';
import 'package:gameguru/widgets/Overview_widget/key_stats_container.dart';
import 'package:gameguru/widgets/Overview_widget/tournament_news_widget.dart';
import 'package:gameguru/widgets/score_card.dart';
import 'package:gameguru/widgets/series_fixture_widget.dart';
import 'package:gameguru/widgets/tabbar_view/tournament_overview.dart';
import 'package:intl/intl.dart';

class TournamentScreen extends StatefulWidget {
  final int initialTabIndex;
  const TournamentScreen({Key? key, this.initialTabIndex = 0}) : super(key: key);

  @override
  State<TournamentScreen> createState() => _TournamentScreenState();
}

class _TournamentScreenState extends State<TournamentScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Divider divider = const Divider(
    thickness: 0.2,
    color: Color(0xff686c68),
  );
  late Future<Map<String, dynamic>> seriesMatch;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this,initialIndex: widget.initialTabIndex);
    seriesMatch = seriesMatches(6732);
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  final List<String> tabLabels = [
    'Overview',
    'Matches',
    'Teams',
    'Points Table',
    'News',
    'Info'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                 automaticallyImplyLeading: false,
                backgroundColor: AppColors.backgroundColor,
                floating: false,
                pinned: false,
                snap: false,
                expandedHeight: 170,
                toolbarHeight: 160,
                title: Container(
                  height: 160,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index){
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 150,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
              SliverAppBar(
                iconTheme: const IconThemeData(
                  color: Colors.white
                ),
                scrolledUnderElevation: 0,
                pinned: true,
                floating: true,
                snap: false,
                backgroundColor: AppColors.backgroundColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "World Cup 2023",
                          style: TextStyle(fontSize: 18, color: AppColors.primary),
                        ),
                        Text("05 Oct to 19 Nov",style: TextStyle(fontSize: 10,color: AppColors.fontColor1),)
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 30,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(width: 0.5, color: AppColors.fontColor1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Following",
                              style: TextStyle(fontSize: 12, color: AppColors.fontColor1),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(Icons.notifications, color: AppColors.fontColor1),
                      ],
                    )
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _MyPersistentHeaderDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: const Color(0xff686c68),
                    indicatorColor: const Color(0xff38e849),
                    isScrollable: true,
                    labelStyle: const TextStyle(fontSize: 16),
                    tabs: tabLabels.map((e) => Tab(text: e)).toList(),
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              Tab(
                child: OverViewWidget(goToThiTab: (int tabIndex){
                  _tabController.animateTo(tabIndex);
                },)
              ),
              Tab(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: seriesMatch,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text(
                        "Error : ${snapshot.hasError}",
                        style: const TextStyle(color: Colors.white),
                      );
                    } else if (snapshot.hasData) {
                      final item = snapshot.data!;
                      final matchDetail = item['matchDetails'];
                      return ListView.builder(
                        itemCount: matchDetail.length,
                        itemBuilder: (context, index) {
                          final matchDetails = item['matchDetails'][index];
                          if (matchDetails.containsKey('matchDetailsMap') &&
                              matchDetails['matchDetailsMap'].isNotEmpty) {
                            final date = matchDetails['matchDetailsMap']['key'];
                            final matchList = matchDetails['matchDetailsMap']['match'];

                            List<Widget> matchWidgets = [];

                            for (int i = 0; i < matchList.length; i++) {
                              if (matchList[i].containsKey('matchInfo')) {
                                final match = matchList[i]['matchInfo'];
                                final matchDesc = match['matchDesc'];
                                final matchDescNumber = matchDesc.replaceFirst('Match', '');
                                final matchFormat = match['matchFormat'];
                                final seriesName = match['seriesName'];
                                final startDate = match['startDate'];
                                final team1SName = match['team1']['teamSName'];
                                final team2SName = match['team2']['teamSName'];
                                final startDateInMillis = int.tryParse(startDate) ?? 0;
                                final startDates = DateTime.fromMillisecondsSinceEpoch(startDateInMillis);
                                final formattedTime = DateFormat.jm().format(startDates);

                                matchWidgets.add(
                                  Center(
                                    child: ScoreCardWithDate(
                                      matchDate: date,
                                      matchStadium: '$matchDescNumber $matchFormat, $seriesName',
                                      team1: team1SName,
                                      team2: team2SName,
                                      startTime: formattedTime,
                                    ),
                                  ),
                                );
                              }
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 5),
                                  child: Text(date, style: TextStyle(color: AppColors.primary)),
                                ),
                                ...matchWidgets,
                              ],
                            );
                          }
                          return Container();
                        },
                      );
                    }
                    return Container();
                  },
                ),
              ),
              Tab(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        children: [
                          const ListTile(
                            titleTextStyle: TextStyle(color: AppColors.primary,fontSize: 15),
                            leading: CircleAvatar(radius: 18,),
                            title: Text("India"),
                            subtitle: Text("15 Players",style: TextStyle(color: Color(0xff686c68),fontSize: 14),),
                            trailing: Icon(Icons.arrow_forward_ios_rounded,size: 16,),
                          ),
                          divider
                        ],
                      ),
                    );
                  },
                ),
              ),
              Tab(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return SeriesWidget(context);
                  },
                ),
              ),
              Tab(
                child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return newsBox(context);
                  },
                ),
              ),
              Tab(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.bottomsheetColor
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Series",style: textStyle3,),
                            trailing: Text("World Cup 2023",style: textStyle3,),
                          ),
                          divider,
                          ListTile(
                            title: Text("Duration",style: textStyle3,),
                            trailing: Text("05 Oct - 19 Nov 2023",style: textStyle3,),
                          ),
                          divider,
                          ListTile(
                            title: Text("Format",style: textStyle3,),
                            trailing: Text("48 ODIs",style: textStyle3,),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  _MyPersistentHeaderDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.backgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_MyPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
