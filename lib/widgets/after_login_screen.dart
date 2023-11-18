import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/screens/navigat_screens/edit_profile_screen.dart';
import 'package:gameguru/widgets/custom_circle.dart';
import 'package:google_fonts/google_fonts.dart';

Widget AfterLoginWidget(BuildContext context, String displayName, String email, String photoURL, Function(String) onDisplayNameChanged){

  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  return Column(children: [
    Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: GestureDetector(onTap: (){
      },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayName ,
                    style: GoogleFonts.getFont('Open Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(
                  height: 5,
                ),
                Text(email,
                  style: GoogleFonts.getFont('Open Sans',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff686c68)),overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            GestureDetector(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(photoURL: photoURL,email: email,displayName: displayName,onDisplayNameChanged: onDisplayNameChanged,)));
            },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(
                        0xff333433), // Set the border color here
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  foregroundColor: const Color(0xff333433),
                  backgroundColor: const Color(0xff1a1818),
                  radius: 24,
                  backgroundImage: CachedNetworkImageProvider(photoURL),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    const Divider(
      thickness: 0.5,
      color: Color(0xff686c68),
    ),
    GestureDetector(
      onTap: () {

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("Following",style: TextStyle(color: AppColors.primary,fontSize: 17,fontWeight: FontWeight.w500),),
              Text("See All",style: TextStyle(color: AppColors.fontColor3,fontSize: 16,fontWeight: FontWeight.w600),)
            ],),
          ),
          Container(
            margin: const EdgeInsets.only(left: 14),
            height: height * 0.28,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: 8,
                shrinkWrap: true,
                itemBuilder: (BuildContext context , int index){
                  Widget circleContain ;
                  String circleText ;
                  if (index == 0){
                    circleContain = const Icon(Icons.add);
                    circleText = 'Add';
                  }
                  else if (index == 7){
                    circleContain = const Icon(Icons.more_horiz);
                    circleText = 'More';

                  }else{

                    circleContain = const Icon(Icons.abc);
                    circleText = 'Teams' ;
                  }
              return Column(
                children:
                  List.generate(2, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: customCircle(
                          size: 34,
                        child: circleContain,
                        text: circleText,
                        widthsize: width * 0.18
                      ),
                    );
                  }),
              );
            }),
          )
        ],
      ),
    ),
  ],);
}