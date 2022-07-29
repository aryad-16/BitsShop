 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:login_singup_screen_ui/model/user_data_model.dart';
import 'package:login_singup_screen_ui/screens/bottom_nav_bar_screen.dart';
import 'package:login_singup_screen_ui/screens/signup%20and%20login/register_screen.dart';

Future<void> userCheck(ref, context) async {
    await Future.delayed(const Duration(seconds: 0));
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    print(user?.uid);
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('Profiles')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          ref.read(currentUserDataProvider.state).state =
              UserData.fromDocument(doc);
          Navigator.pushReplacementNamed(context, MainScreen.routename);
        }
      } catch (e) {
        print(e);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()));
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()));
      });
    }
  }