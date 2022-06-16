import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

errorSnackbar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: const Color.fromRGBO(237, 92, 90, 1),
    ),
  );
}
