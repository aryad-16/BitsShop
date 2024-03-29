import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:login_singup_screen_ui/firebase_options.dart';
import 'package:login_singup_screen_ui/providers/profiles_provider.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/Edit%20Screen/edit_screen.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/home%20screen/home_screen.dart';
import 'package:login_singup_screen_ui/screens/signup%20and%20login/continue_with_phone.dart';
import 'package:login_singup_screen_ui/widgets/initializer.dart';
import 'package:provider/provider.dart';

import 'providers/items_provider.dart';
import 'screens/bottom_nav_bar_screen.dart';
import 'screens/signup and login/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const rp.ProviderScope(child: MyApp()));
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
      child: FirebasePhoneAuthProvider(
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const InitializerWidget(),
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
