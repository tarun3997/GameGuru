import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';
import 'package:gameguru/utils/split_word.dart';
import 'package:gameguru/widgets/Overview_widget/key_stats_container.dart';

TextStyle textStyle1 = const TextStyle(
    color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.w500);
TextStyle textStyle2 = const TextStyle(
  color: AppColors.fontColor1,
  fontSize: 10,
);
TextStyle textStyle3 = const TextStyle(
  color: AppColors.fontColor1,
  fontSize: 15,
);
TextStyle textStyle4 = const TextStyle(
  color: AppColors.fontColor1,
  fontSize: 13,
);

TableRow tableRow(
    {required String batterName,
      required String batterStatus,
      required String batterBowlFace,
      required String batterRuns,
      required String batterFours,
      required String batterSix,
      required String batterSR}) {
  return TableRow(
    children: [
      TableCell(
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(child: Text(formatPlayerName(batterName), style: textStyle1,overflow: TextOverflow.ellipsis,maxLines: 1,)),
                ],
              ),
              Row(
                children: [
                  Flexible(child: Text(batterStatus, style: textStyle2,overflow: TextOverflow.ellipsis,maxLines: 1,)),
                ],
              ),
            ],
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(child: Text(batterRuns, style: textStyle1)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(child: Text(batterBowlFace, style: textStyle3)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(child: Text(batterFours, style: textStyle3)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(child: Text(batterSix, style: textStyle3)),
        ),
      ),
      TableCell(
        child: Container(
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(child: Text(batterSR, style: textStyle3)),
        ),
      ),
    ],
  );
}

TableRow bowlerTableRow(
    {required String bowlerName,
      required String bowlerOver,
      required String bowlerMaiden,
      required String bowlerRun,
      required String bowlerWicket,
      required String bowlerEco}) {
  return TableRow(
    children: [
      TableCell(
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(bowlerName, style: textStyle1),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(child: Text(bowlerOver, style: textStyle1)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(child: Text(bowlerMaiden, style: textStyle3)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(child: Text(bowlerRun, style: textStyle3)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(child: Text(bowlerWicket, style: textStyle3)),
        ),
      ),
      TableCell(
        child: Container(
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(child: Text(bowlerEco, style: textStyle3)),
        ),
      ),
    ],
  );
}

TableRow fallOfWicketRow(
    {required String batterName,
      required String runScore,
      required String fallWicket,
      required String wicketInOver,}) {
  return TableRow(
    children: [
      TableCell(
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Text(formatPlayerName(batterName),
              style:textStyle1),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Center(child: Text("$fallWicket-$runScore", style: textStyle1)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.only(top: 6.0,right: 20),
          child: Center(child: Text(wicketInOver, style: textStyle4)),
        ),
      ),

    ],
  );
}

TableRow tableRowDivider() {
  return TableRow(
    children: [
      TableCell(child: divider),
      TableCell(child: divider),
      TableCell(child: divider),
      TableCell(child: divider),
      TableCell(child: divider),
      TableCell(child: divider),
    ],
  );
}
TableRow tableRowDivider2() {
  return TableRow(
    children: [
      TableCell(child: divider),
      TableCell(child: divider),
      TableCell(child: divider),
    ],
  );
}