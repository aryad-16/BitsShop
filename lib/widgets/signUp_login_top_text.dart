import 'package:flutter/material.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';

Widget topText(double height, String title) {
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
        // style: GoogleFonts.inter(
        //   fontWeight: FontWeight.bold,
        //   fontSize: 24,
        //   color: Constant.blackColor,
        // ),
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
