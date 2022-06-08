import 'package:flutter/material.dart';

import '../Constants/constants.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key? key,
    required this.title,
    required this.yellowBg,
  }) : super(key: key);

  final String title;
  final bool yellowBg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: yellowBg ? Constant.yellowColor : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Constant.yellowColor),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'manRope Regular',
          fontSize: 16,
          color: yellowBg ? Colors.white : Constant.yellowColor,
        ),
      ),
    );
  }
}
