import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_singup_screen_ui/providers/profiles_provider.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/Edit%20Screen/edit_screen.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/home%20screen/home_screen.dart';
import 'package:provider/provider.dart';

import 'providers/items_provider.dart';
import 'screens/signup and login/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Items()),
        ChangeNotifierProvider.value(value: Profiles())
      ],
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
          HomeScreen.routename: (context) => const HomeScreen()
        },
      ),
    );
  }
}
