import 'package:flutter/material.dart';

class Constant {
  static LinearGradient blueLinear = const LinearGradient(
    colors: [
      Color.fromRGBO(154, 196, 254, 1),
      Color.fromRGBO(146, 163, 253, 1),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static LinearGradient yellowlinear = const LinearGradient(
    colors: [
      Color.fromRGBO(250, 192, 95, 1),
      Color.fromRGBO(247, 154, 0, 1),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  // static LinearGradient yellowaccentlinear = const LinearGradient(
  //   colors: [
  //     Color.fromRGBO(249, 217, 118, 1),
  //     Color.fromRGBO(243, 159, 134, 1),
  //   ],
  //   begin: Alignment.centerLeft,
  //   end: Alignment.centerRight,
  // );
  static LinearGradient purpleLinear = const LinearGradient(
    colors: [
      Color.fromRGBO(238, 164, 206, 1),
      Color.fromRGBO(197, 139, 242, 1),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static Color blackColor = const Color.fromRGBO(29, 22, 23, 1);
  static Color whiteColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color greyColor1 = const Color.fromRGBO(123, 111, 114, 1);
  static Color yellowColor = const Color.fromRGBO(247, 154, 0, 1);

  static TextStyle introductoryScreenTextTitleStyle = TextStyle(
      fontFamily: 'Poppins Bold',
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: blackColor);
  static TextStyle introductoryScreenTextDescStyle = TextStyle(
    fontFamily: 'Poppins Regular',
    fontSize: 15,
    color: greyColor1,
    height: 1.5,
  );

  static BoxShadow boxShadow = BoxShadow(
    color: const Color.fromRGBO(146, 163, 253, 1).withOpacity(0.22),
    spreadRadius: 2,
    blurRadius: 7,
    offset: const Offset(8, 4),
  );

  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    shadowColor: Colors.transparent,
    elevation: 0,
    shape: const StadiumBorder(),
    primary: Colors.transparent,
  );
}
