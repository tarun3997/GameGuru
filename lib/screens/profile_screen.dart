import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/screens/navigat_screens/match_setting.dart';
import 'package:gameguru/widgets/after_login_screen.dart';
import 'package:gameguru/widgets/bottom_sheet/app_theme_bottom_sheet.dart';
import 'package:gameguru/widgets/not_login_screen.dart';
import 'package:gameguru/widgets/profile_listtiles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  late final FirebaseAuth _auth;
  String? displayName;
  String? email;
  String? photoURL;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _loadDisplayName();
  }
  Future<void> _loadDisplayName() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = sharedPrefs.getString('displayName') ?? "";
      email = sharedPrefs.getString('email');
      photoURL = sharedPrefs.getString('photoURL');
    });
  }
  void _updateDisplayName(String newName) {
    setState(() {
      displayName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {



    const divider = Divider(
      thickness: 0.3,
      color: Color(0xff686c68),
    );
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Column(
              children: [

                FutureBuilder<User?>(
                    future: _auth.authStateChanges().first,
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return  const CircularProgressIndicator();
                      }else{
                        if (snapshot.hasData){
                          return AfterLoginWidget(context, displayName ?? "", email ?? "" , photoURL ?? "",_updateDisplayName);
                        }else{
                          return NotLoginWidget(context);
                        }
                      }
                }),
                const Divider(
                  thickness: 0.5,
                  color: Color(0xff686c68),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      CustomListTile(
                          icon: const Icon(Icons.sports_cricket_sharp,
                              color: Color(0xff9b9898)),
                          text: const Text(
                            "GAMEGURU",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )),
                      divider,
                      GestureDetector(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MatchSettingScreen()));
                      },
                        child: CustomListTile(
                            icon: const Icon(Icons.settings,
                                color: Color(0xff9b9898)),
                            text: const Text(
                              "Match Setting",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            )),
                      ),
                      divider,
                      GestureDetector(onTap: (){
                        AppThemeBottomSheet(context);
                      },
                        child: CustomListTile(
                            icon: const Icon(Icons.dark_mode_rounded,
                                color: Color(0xff9b9898)),
                            text: const Text(
                              "App Theme",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            )),
                      ),
                      divider,
                      CustomListTile(
                          icon: const Icon(Icons.notifications,
                              color: Color(0xff9b9898)),
                          text: const Text(
                            "Notification Setting",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )),
                      divider,
                      CustomListTile(
                          icon: const Icon(Icons.language_rounded,
                              color: Color(0xff9b9898)),
                          text: const Text(
                            "Language",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )),
                      divider,
                      CustomListTile(
                          icon: const Icon(
                            Icons.more_horiz_rounded,
                            color: Color(0xff9b9898),
                          ),
                          text: const Text(
                            "More",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          )),
                      divider,
                      if (_auth.currentUser != null)
                      GestureDetector(
                        onTap: (){
                          _signOut();
                        },
                        child: CustomListTile(
                            icon: const Icon(
                              Icons.logout_rounded,
                              color: Color(0xff9b9898),
                            ),
                            text: const Text(
                              "LogOut",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            )),
                      ),
                    ],
                  ),
                ),
                divider
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _refresh() async {
    // No need for additional logic here
    // Simply re-fetch the authentication state
  }
  // Google SignOut
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      // Clear the login flag in SharedPreferences
      final sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.setBool('isLoggedIn', false);

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      // Refresh the screen
      _refreshIndicatorKey.currentState?.show();
      // Navigate to the login screen

    } catch (e) {
      print("Sign Out Error: $e");
    }
  }
}
