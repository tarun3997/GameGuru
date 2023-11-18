import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/widgets/custom_circle.dart';
import 'package:gameguru/widgets/score_card.dart';
import 'package:gameguru/widgets/series_fixture_widget.dart';

class FixturesScreen extends StatefulWidget {
  const FixturesScreen({Key? key}) : super(key: key);

  @override
  State<FixturesScreen> createState() => _FixturesScreenState();
}

class _FixturesScreenState extends State<FixturesScreen>
    with SingleTickerProviderStateMixin {
  int selectedCategoryIndex = 0;
  int initialIndex = 0;
  final additionalHeight = 10.0;
  List<Color> categoryColors = [];
  late TabController _tabController;
  final isIndexAtMyMatch = false;
  List<String> category = [
    "All",
    "Men",
    "T20",
    "ODI",
    "International",
    "Test",
    "Women",
    "League",
    "Domestic",
  ];

  ImageProvider<Object> flagimage =  const CachedNetworkImageProvider(
    'https://cdn.britannica.com/97/1597-004-05816F4E/Flag-India.jpg',
  );
  @override
  void initState() {
    super.initState();
    categoryColors = List.generate(
      category.length,
      (index) => index == selectedCategoryIndex
          ? AppColors.buttonBoxColor
          : Colors.transparent,
    );
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      initialIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Divider divider = const Divider(
    thickness: 0.3,
    color: Color(0xff686c68),
  );
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: AppColors.backgroundColor,
                floating: true,
                pinned: true,
                scrolledUnderElevation: 0,
                flexibleSpace: Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey, // Adjust the color as needed
                        width: 1.0, // Adjust the thickness as needed
                      ),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: const Color(0xff686c68),
                    indicatorColor: const Color(0xff38e849),
                    isScrollable: true,
                    labelStyle: const TextStyle(fontSize: 16),
                    tabs: const [
                      Tab(
                        child: Text("Days"),
                      ),
                      Tab(
                        child: Text("Series"),
                      ),
                      Tab(
                        child: Text("My Matches"),
                      ),
                    ],
                    indicator: null,
                    // labelPadding: EdgeInsets.symmetric(horizontal: 14),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: SizedBox(
                            height: 35,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: category.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedCategoryIndex = index;
                                      categoryColors = List.generate(
                                        category.length,
                                        (i) => i == index
                                            ? AppColors.buttonBoxColor
                                            : Colors.transparent,
                                      );
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: categoryColors[index],
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: selectedCategoryIndex == index
                                            ? Colors.transparent
                                            : AppColors.fontColor1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        category[index],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: selectedCategoryIndex == index
                                              ? AppColors.primary
                                              : AppColors.fontColor1,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                            child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 3,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xff272e36)),
                            ),
                            const Icon(
                              Icons.filter_list,
                              color: AppColors.iconColor,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ))
                      ],
                    ),
                    if (initialIndex == 2)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        color: AppColors.backgroundColor,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            customCircle(
                                child: const Icon(
                                  Icons.edit_outlined,
                                  color: AppColors.fontColor1,
                                ),
                                text: "Edit",
                                widthsize: 60),
                            customCircle(
                                image: flagimage,
                                text: "IND",
                                widthsize: 60),
                          ],
                        ),
                      ),
                    if (initialIndex == 2) divider
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Container(
                        width: width,
                        height: 60,
                        color: AppColors.backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                initialIndex == 1
                                    ? "This Month"
                                    : "Today, 06 Oct",
                                style: const TextStyle(color: Colors.white),
                              ),
                              if (initialIndex != 1)
                                const Row(
                                  children: [
                                    Icon(Icons.calendar_today,
                                        color: AppColors.iconColor,
                                        semanticLabel: "Calendar"),
                                    Text("Calendar",
                                        style: TextStyle(
                                            color: AppColors.iconColor)),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              Tab(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const Center(
                      child: ScoreCard(
                        matchStadium:
                            '10th ODI, Rajiv Gandhi International Stadium, Hyderabad',
                        team1: 'team1',
                        team2: 'team2',
                        startTime: 'startTime',
                      ),
                    );
                  },
                ),
              ),
              Tab(
                child: ListView.builder(
                  itemCount: 6,
                    itemBuilder: (context, index){
                      return SeriesWidget(context);
                    },
                )
              ),
              const Tab(
                child: ScoreCard(
                  matchStadium:
                      '10th ODI, Rajiv Gandhi International Stadium, Hyderabad',
                  team1: 'team1',
                  team2: 'team2',
                  startTime: 'startTime',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => 60.0; // Adjust as needed

  @override
  double get maxExtent => 60.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
