import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gameguru/widgets/bottom_sheet/login_bottom_sheet.dart';
import 'package:gameguru/widgets/custom_circle.dart';
import 'package:google_fonts/google_fonts.dart';

Widget NotLoginWidget(BuildContext context){
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  const ImageProvider<Object> viratimage =  CachedNetworkImageProvider(
    'https://www.sportstime247.com/wp-content/uploads/2022/07/Virat-kohli-rested.jpg',
  );
  const ImageProvider<Object> wcimage =  CachedNetworkImageProvider(
    'https://pbs.twimg.com/media/FznQM75WIAEgfZD.jpg',
  );
  const ImageProvider<Object> flagimage =  CachedNetworkImageProvider(
    'https://cdn.britannica.com/97/1597-004-05816F4E/Flag-India.jpg',
  );
  return Column(children: [
    Padding(
      padding:
      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: GestureDetector(onTap: (){
        LoginBottomSheet(context);
      },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Login or sign up",
                    style: GoogleFonts.getFont('Open Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Get more with GAMEGURE account now",
                  style: GoogleFonts.getFont('Open Sans',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff686c68)),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(
                      0xff333433), // Set the border color here
                  width: 1,
                ),
              ),
              child: const CircleAvatar(
                foregroundColor: Color(0xff333433),
                backgroundColor: Color(0xff1a1818),
                radius: 24,
                child: Icon(
                  Icons.person_outline,
                  size: 30,
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
        LoginBottomSheet(context);
      },
      child: SizedBox(
        width: width,
        height: height * 0.22,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.46,
                child: Stack(
                  alignment: Alignment
                      .centerRight, // Align circles to the right
                  children: <Widget>[
                    customCircle(image: flagimage),
                    Positioned(
                      right: width *
                          0.11, // 10% of the container's width
                      child: customCircle(image: wcimage),
                    ),
                    Positioned(
                      right: width *
                          0.22, // 20% of the container's width
                      child: customCircle(image: viratimage),
                    ),
                    Positioned(
                      right: width *
                          0.33, // 30% of the container's width
                      child: customCircle(
                          child: const Icon(
                            Icons.add,
                            color: Colors.lightBlue,
                            size: 18,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: width * 0.7,
                  child: Text(
                    "Login to see your favourite series, teams and players here.",
                    style: GoogleFonts.getFont('Open Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff686c68)),
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      ),
    ),
  ],);
}