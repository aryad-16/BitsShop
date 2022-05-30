import 'package:flutter/material.dart';

Widget addPhoto(int i) {
  return Container(
    width: 102,
    margin: const EdgeInsets.fromLTRB(10, 51.5, 10, 24.5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: const Center(
      child: Text(
        '+',
        style: TextStyle(
          fontFamily: 'Avenir',
          fontSize: 30,
          color: Color.fromRGBO(27, 27, 27, 1),
        ),
      ),
    ),
  );
}
