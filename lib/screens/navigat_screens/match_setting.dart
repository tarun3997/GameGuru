import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/widgets/bottom_sheet/setting_win_probability_view.dart';

class MatchSettingScreen extends StatefulWidget {
  const MatchSettingScreen({Key? key}) : super(key: key);

  @override
  State<MatchSettingScreen> createState() => _MatchSettingScreenState();
}

class _MatchSettingScreenState extends State<MatchSettingScreen> {
  Divider divider = const Divider(
    thickness: 0.3,
    color: Color(0xff686c68),
  );
  bool isSwitched = true;
  bool isSwitched2 = true;
  int selectedRadio = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            GestureDetector(onTap: (){
              Navigator.pop(context);
            },child: const Icon(Icons.arrow_back_rounded,color: AppColors.fontColor2,size: 28,)),
            const SizedBox(width: 10,),
            const Text("Match Settings",style: TextStyle(color: AppColors.fontColor2,fontSize: 18),),
          ],
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(children: [
        divider,
        GestureDetector(onTap: (){
          WinProbabilityBottomSheet(context);
        },
          child: const ListTile(
            leading: Icon(Icons.emoji_events_rounded,color: AppColors.fontColor1,size: 28,),
            title: Text("Win Probability View",style: TextStyle(color: AppColors.fontColor2,fontSize: 16),),
            subtitle: Text("Customize your view with options for selecting a view and real-time score project",style: TextStyle(fontSize: 11,color: AppColors.fontColor1),),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: AppColors.fontColor1,size: 20,),
          ),
        ),
        const SizedBox(height: 15,),
        const ListTile(
          leading: Icon(Icons.spatial_audio_off_sharp,color: AppColors.fontColor1,size: 28,),
          title: Text("Speech Setting (Accessibility)",style: TextStyle(color: AppColors.fontColor2,fontSize: 16),),
          subtitle: Text("Customize the accessibility of your speech options for voice, language, and speed",style: TextStyle(fontSize: 11,color: AppColors.fontColor1),),
          trailing: Icon(Icons.arrow_forward_ios_rounded,color: AppColors.fontColor1,size: 20,),
        )
      ],),
    );
  }
}
