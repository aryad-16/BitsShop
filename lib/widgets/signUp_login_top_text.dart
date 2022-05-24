import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:flutter/material.dart';

Widget top_Text(double height, String title) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.only(
          top: (20 / 812) * height,
          bottom: (8 / 812) * height,
        ),
        child: Text(
          'Hey there,',
          style: TextStyle(
            fontFamily: 'Poppins Regular',
            color: Constant.blackColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins Bold',
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Constant.blackColor,
        ),
      ),
    ],
  );
}
