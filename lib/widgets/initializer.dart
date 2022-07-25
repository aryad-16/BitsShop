import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_singup_screen_ui/screens/bottom_nav_bar_screen.dart';
import 'package:login_singup_screen_ui/screens/signup%20and%20login/register_screen.dart';
import '../constants/constants.dart';
import '../model/userDataModel.dart';

class InitializerWidget extends ConsumerStatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  static const routeName = 'initializer';

  @override
  ConsumerState<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends ConsumerState<InitializerWidget> {
  @override
  void initState() {
    userCheck();
    super.initState();
  }

  Future<void> userCheck() async {
    await Future.delayed(Duration(seconds: 0));
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
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()));
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignUpScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(builder: (context, orientation) {
          return Center(child: CircularProgressIndicator.adaptive());
        });
      },
    );
  }
}
