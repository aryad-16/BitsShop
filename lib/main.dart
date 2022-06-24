import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:login_singup_screen_ui/firebase_options.dart';
import 'package:login_singup_screen_ui/providers/item_model.dart';
import 'package:login_singup_screen_ui/providers/profiles_provider.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/Edit%20Screen/edit_screen.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/home%20screen/home_screen.dart';
import 'package:login_singup_screen_ui/screens/signup%20and%20login/continue_with_phone.dart';
import 'package:provider/provider.dart';

import 'providers/items_provider.dart';
import 'screens/bottom_nav_bar_screen.dart';
import 'screens/signup and login/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Future<List> getFeedItems() async {
    var feedItems;
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('items').get().then((ds) {
      feedItems = ds.docs
          .map((doc) => Item(
              category: Category.values
                  .firstWhere((e) => e.toString() == doc['category']),
              price: int.parse(doc['price']),
              profileId: doc['profileId'],
              title: doc['title'],
              id: doc['id'],
              description: doc['description'],
              imageList: doc['imageList'].split(','),
              year: doc.data().toString().contains('year')
                  ? YearCategory.values
                      .firstWhere((e) => e.toString() == doc['year'])
                  : null,
              sem: doc.data().toString().contains('semester')
                  ? SemesterCategory.values
                      .firstWhere((e) => e.toString() == doc['semester'])
                  : null,
              branch: doc.data().toString().contains('branch')
                  ? BranchCategory.values
                      .firstWhere((e) => e.toString() == doc['branch'])
                  : null))
          .toList();
      Items().setItemsList(feedItems);
      print(feedItems[0].branch);
    }).catchError((e) {
      print(e);
    }).then((value) {});
    return feedItems;
  }

  @override
  Widget build(BuildContext context) {
    getFeedItems();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Items()),
        ChangeNotifierProvider.value(value: Profiles())
      ],
      child: FirebasePhoneAuthProvider(
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SignUpScreen(),
          routes: {
            EditScreen.routeName: (ctx) => const EditScreen(),
            SignUpScreen.routename: (context) => const SignUpScreen(),
            HomeScreen.routename: (context) => const HomeScreen(),
            MainScreen.routename: (context) => const MainScreen(),
            ContinueWithPhone.routeName: (context) => const ContinueWithPhone()
          },
        ),
      ),
    );
  }
}
