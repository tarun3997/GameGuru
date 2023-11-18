
import 'package:flutter/material.dart';
import 'package:gameguru/assets/colors/app_color.dart';

Widget customCircle({Widget? child, ImageProvider<Object>? image, double? size, String? text, double? widthsize}) {

  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xff333433),
            width: 1,
          ),
        ),
        child: CircleAvatar(
          foregroundColor: const Color(0xff333433),
          backgroundColor: const Color(0xff01040a),
          radius: size ?? 23,
          backgroundImage: image,
          child: child,
        ),
      ),
      SizedBox(
        width: widthsize ?? 0,
        child: Center(
          child: Text(
            text ?? "",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16,color: AppColors.fontColor1),
          ),
        ),
      ),
    ],
  );
}
