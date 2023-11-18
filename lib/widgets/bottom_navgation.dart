import 'package:flutter/material.dart';
import 'package:gameguru/screens/fixtures_screen.dart';
import 'package:gameguru/screens/homescreen.dart';
import 'package:gameguru/screens/matches_screen.dart';
import 'package:gameguru/screens/profile_screen.dart';
import 'package:gameguru/screens/tournament_screen.dart';

class BottomNaigation extends StatefulWidget {
  const BottomNaigation({Key? key}) : super(key: key);

  @override
  State<BottomNaigation> createState() => _BottomNaigationState();
}

class _BottomNaigationState extends State<BottomNaigation> {

  int _selectedIndex = 2;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const TournamentScreen(),
    const MatchesScreen(),
    const FixturesScreen(),
    const ProfileScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xff080C0F),
          selectedLabelStyle: const TextStyle(color: Colors.white,fontSize: 14),
          unselectedItemColor: const Color(0xff686c68),
          selectedIconTheme: const IconThemeData(color: Colors.white),

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home),
            label: 'Home'),

            BottomNavigationBarItem(icon: Icon(Icons.emoji_events_sharp),
            label: 'WC'),
            BottomNavigationBarItem(icon: Icon(Icons.sports_cricket_sharp),
            label: 'Matches'),
            BottomNavigationBarItem(icon: Icon(Icons.date_range),
            label: 'Fixtures'),
            BottomNavigationBarItem(icon: Icon(Icons.person_2_rounded),
            label: 'Profile'),
          ],
          selectedItemColor: Colors.white,

          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
