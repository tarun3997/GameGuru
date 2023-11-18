import 'package:flutter/material.dart';

Widget CustomListTile({Widget? icon, Text? text}){
  return Column(
    children: [
      ListTile(
        leading: icon,
        title: text,
        trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 18,color: Color(
            0xff504e4e),),
      ),

    ],
  );
}
