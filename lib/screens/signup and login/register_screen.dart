import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/home%20screen/home_screen.dart';
import 'package:login_singup_screen_ui/screens/signup%20and%20login/login_screen.dart';
import 'package:login_singup_screen_ui/widgets/signUp_login_top_text.dart';

import 'continue_with_phone.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const routename = 'signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _value = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signUp() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      // Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final width = MediaQuery.of(context).size.width;
    final height =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    Widget _textFormField(
        String title, String prefixasset, String suffixasset, int a) {
      return Padding(
        padding: a == 0
            ? EdgeInsets.only(top: (30 / 812) * height)
            : EdgeInsets.only(top: (18 / 812) * height),
        child: SizedBox(
          width: (315 / 375) * width,
          child: TextFormField(
            textCapitalization: a == 3 || a == 2
                ? TextCapitalization.none
                : TextCapitalization.sentences,
            textInputAction:
                a == 3 ? TextInputAction.done : TextInputAction.next,
            keyboardType: a == 0
                ? TextInputType.text
                : a == 1
                    ? TextInputType.emailAddress
                    : TextInputType.visiblePassword,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  top: 18, left: 12, right: 12, bottom: 18),
              hintText: title,
              hintStyle: const TextStyle(
                fontFamily: 'Poppins Regular',
                fontSize: 16,
                color: Color.fromRGBO(173, 164, 165, 1),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 5, top: 12, bottom: 12),
                child: a == 1
                    ? Transform.scale(
                        scale: 0.86,
                        child: SvgPicture.asset(
                          prefixasset,
                        ),
                      )
                    : SvgPicture.asset(
                        prefixasset,
                      ),
              ),
              suffixIcon: a == 2 || a == 3
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 5, top: 14, bottom: 14, right: 5),
                      child: SvgPicture.asset(
                        suffixasset,
                      ),
                    )
                  : null,
              filled: true,
              fillColor: const Color.fromRGBO(247, 248, 248, 1),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.white,
        ),
        preferredSize: const Size.fromHeight(0),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            top_Text(height, 'Create an Account'),
            _textFormField('First Name', 'assets/icons/person.svg', '', 0),
            _textFormField('Email', 'assets/icons/email.svg', '', 1),
            _textFormField('Password', 'assets/icons/password.svg', '', 2),
            _textFormField('Confirm Password', 'assets/icons/password.svg',
                'assets/icons/seehidepassword.svg', 3),
            Padding(
              padding: EdgeInsets.only(
                left: (18 / 375) * width,
                top: 10,
                right: (18 / 375) * width,
              ),
              child: Row(
                children: <Widget>[
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(6),
                          right: Radius.circular(6),
                        ),
                      ),
                      activeColor: const Color.fromRGBO(173, 164, 165, 1),
                      value: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                    ),
                  ),
                  Container(
                    // height: 50,
                    width: width - 100,
                    padding: const EdgeInsets.only(right: 10),
                    child: const Text(
                      'By continuing you accept our Privacy Policy and Term of Use',
                      style: TextStyle(
                        fontFamily: 'Poppins Regular',
                        fontSize: 11,
                        color: Color.fromRGBO(173, 164, 165, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50, bottom: (10 / 812) * height),
              decoration: BoxDecoration(
                boxShadow: [Constant.boxShadow],
                gradient: Constant.yellowlinear,
                borderRadius: BorderRadius.circular(100),
              ),
              width: (315 / 375) * width,
              height: (60 / 812) * height,
              child: ElevatedButton(
                style: Constant.elevatedButtonStyle,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const ContinueWithPhone(),
                    ),
                  );
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontFamily: 'Poppins Bold',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: (30 / 375) * width,
                right: (30 / 375) * width,
                bottom: (00 / 812) * height,
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: (141 / 375) * width,
                    child: const Divider(
                      thickness: 1.2,
                      color: Color.fromRGBO(221, 218, 218, 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Or",
                      style: Constant.introductoryScreenTextDescStyle,
                    ),
                  ),
                  SizedBox(
                    width: (140 / 375) * width,
                    child: const Divider(
                      thickness: 1.2,
                      color: Color.fromRGBO(221, 218, 218, 1),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/google.svg',
                    ),
                    GestureDetector(
                      onTap: () async {
                        print('here1');
                        await signUp();
                        print('here2');
                        await Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routename);
                      },
                      child: Transform.scale(
                        scale: 0.37,
                        child: SvgPicture.asset(
                          'assets/icons/google_icon.svg',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: (30 / 375) * width,
                ),
                SvgPicture.asset('assets/icons/facebook.svg'),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: (20 / 812) * height, bottom: (20 / 812) * height),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account?',
                    style: const TextStyle(
                      fontFamily: 'Poppins Regular',
                      fontSize: 18,
                      color: Colors.black,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Login',
                        style: const TextStyle(
                            color: Color.fromRGBO(245, 130, 50, 1),
                            fontSize: 18),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (ctx) => const LoginScreen(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
