import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';

Widget OverCountWidget(int over, String totalRuns, List<String> runs) {
  TextStyle textStyle = const TextStyle(color: AppColors.primary, fontSize: 11);
  TextStyle textStyle1 = const TextStyle(color: AppColors.primary, fontSize: 12);

  // for (String run in runs) {
  //   if (int.tryParse(run) != null) {
  //     totalRuns += int.parse(run);
  //   } else if (run.endsWith('wd')) {
  //     totalRuns += 1; // Add 1 run for wide
  //     int? wideRun = int.tryParse(run.replaceAll(RegExp(r'[a-z]'), ''));
  //     if (wideRun != null) {
  //       totalRuns += wideRun;
  //     }
  //   } else if (run.endsWith('nb')) {
  //     totalRuns += 1; // Add 1 run for no-ball
  //     int? wideRun = int.tryParse(run.replaceAll(RegExp(r'[a-z]'), ''));
  //     if (wideRun != null) {
  //       totalRuns += wideRun;
  //     }
  //   }
  // }

  int minContainers = 6;

  if (runs.length < minContainers) {
    int emptyRunCount = minContainers - runs.length;
    for (int i = 0; i < emptyRunCount; i++) {
      runs.add('');
    }
  }

  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Text("Over $over", style: textStyle1),
      ),
      Wrap(
        spacing: 3, // Adjust the spacing between runs
        children: runs.map((run) {
          Color circleColor;

          if (run == '4') {
            circleColor = const Color(0xff3291AD);
          } else if (run == '6') {
            circleColor = Colors.green;
          } else {
            circleColor = Colors.transparent;
          }

          return Container(
            width: 25,
            height: 25,
            margin: const EdgeInsets.only(right: 3),
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.fontColor1, width: 0.1),
            ),
            child: Center(child: Text(run, style: textStyle)),
          );
        }).toList(),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text("= $totalRuns", style: textStyle),
      ),
      const Padding(
        padding: EdgeInsets.all(10.0),
        child: VerticalDivider(
          thickness: 0.2,
        ),
      ),
    ],
  );
}
