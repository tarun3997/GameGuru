import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/widgets/score_card.dart';
import 'package:google_fonts/google_fonts.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: Text("GAMEGURU",style: GoogleFonts.getFont('Josefin Sans',fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),),
          actions: const [
          Icon(Icons.search_rounded,color: Colors.white,),
          SizedBox(width: 25,)],

          bottom: const TabBar(
            labelColor: Colors.white,
              dividerColor: Colors.transparent,
              unselectedLabelColor: Color(0xff686c68),
              indicatorColor: Color(0xff38e849),
              isScrollable: true,
              tabs: [
            Tab(child: Text("Live"),),
            Tab(child: Text("For You"),),
            Tab(child: Text("Upcoming"),),
            Tab(child: Text("Finished"),),
          ],
          indicator: null),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundColor
                  ),
                  child:  ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return  Center(
                        child: GestureDetector(onTap: (){
                        },
                          child:  const ScoreCard(
                            matchStadium: 'match Stadium',
                            team1: 'team1',
                            team2: 'team2',
                            startTime: 'startTime',
                          ),
                        ),
                      );
                    },

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
