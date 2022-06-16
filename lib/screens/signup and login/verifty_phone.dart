import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:login_singup_screen_ui/screens/bottom_nav_bar_screen.dart';
import 'package:login_singup_screen_ui/widgets/error_snackbar.dart';

import '../../widgets/numeric_pad.dart';

class VerifyPhone extends StatefulWidget {
  final String phoneNumber;
  static const routeName = 'verifyPhone';

  const VerifyPhone({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  String code = "";
  late String _verificationCode;
  final idToken = FirebaseAuth.instance.currentUser!.getIdToken();

  _verifyPhone() async {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + widget.phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          try {
            final userCredential = await FirebaseAuth.instance.currentUser
                ?.linkWithCredential(phoneAuthCredential);
          } on FirebaseAuthException catch (e) {
            switch (e.code) {
              case "provider-already-linked":
                print("The provider has already been linked to the user.");
                break;
              case "invalid-credential":
                print("The provider's credential is not valid.");
                break;
              case "credential-already-in-use":
                print(
                    "The account corresponding to the credential already exists, "
                    "or is already linked to a Firebase User.");
                break;
              // See the API reference for the full list of error codes.
              default:
                print("Unknown error.");
            }
          }
          FirebaseAuth.instance
              .signInWithCredential(phoneAuthCredential)
              .then((value) async {
            if (value.user != null) {
              print('User is logged in.');
              Navigator.of(context).pushReplacementNamed(MainScreen.routename);
            }
          });
        },
        verificationFailed: (FirebaseAuthException firebaseAuthException) {
          print(firebaseAuthException.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        });
  }

  @override
  void initState() {
    _verifyPhone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final width = MediaQuery.of(context).size.width;
    final height =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 30,
            color: Color.fromRGBO(34, 26, 69, 1),
          ),
        ),
        title: const Text(
          "Verify OTP",
          style: TextStyle(
            fontSize: 19,
            fontFamily: 'Poppins Medium',
            color: Color.fromRGBO(34, 26, 69, 1),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        // textTheme: Theme.of(context).textTheme,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Code is sent to " + widget.phoneNumber,
                      style: TextStyle(
                        fontFamily: 'Poppins Regular',
                        fontSize: 22,
                        color: Constant.greyColor1,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        buildCodeNumberBox(
                            code.isNotEmpty ? code.substring(0, 1) : ""),
                        buildCodeNumberBox(
                            code.length > 1 ? code.substring(1, 2) : ""),
                        buildCodeNumberBox(
                            code.length > 2 ? code.substring(2, 3) : ""),
                        buildCodeNumberBox(
                            code.length > 3 ? code.substring(3, 4) : ""),
                        buildCodeNumberBox(
                            code.length > 4 ? code.substring(4, 5) : ""),
                        buildCodeNumberBox(
                            code.length > 5 ? code.substring(5, 6) : ""),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 14,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Didn't recieve code? ",
                          style: TextStyle(
                            fontFamily: 'Poppins Regular',
                            fontSize: 16,
                            color: Constant.greyColor1,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Resend the code to the user");
                          },
                          child: const Text(
                            "Request again",
                            style: TextStyle(
                              fontFamily: 'Poppins Regular',
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 15,
              left: 0.06 * width,
              right: 0.06 * width,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              gradient: Constant.yellowlinear,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [Constant.boxShadow],
            ),
            width: (315 / 375) * width,
            height: (60 / 812) * height,
            child: ElevatedButton(
              style: Constant.elevatedButtonStyle,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const MainScreen(),
                  ),
                );
              },
              child: GestureDetector(
                child: const FittedBox(
                  child: Text(
                    "Verify and Create Account",
                    style: TextStyle(
                      fontFamily: 'Poppins Bold',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          NumericPad(
            onNumberSelected: (value) async {
              print('The fucking value is $value');
              setState(() {
                if (value != -1) {
                  if (code.length < 6) {
                    code = code + value.toString();
                  }
                } else {
                  code = code.substring(0, code.length - 1);
                }
                print('The fucking code is : $code');
              });
              if (code.length == 6) {
                try {
                  final credential = PhoneAuthProvider.credential(
                      verificationId: _verificationCode, smsCode: code);
                  final userCredential = await FirebaseAuth.instance.currentUser
                      ?.linkWithCredential(credential);
                } on FirebaseAuthException catch (e) {
                  switch (e.code) {
                    case "provider-already-linked":
                      print(
                          "The provider has already been linked to the user.");
                      break;
                    case "invalid-credential":
                      print("The provider's credential is not valid.");
                      break;
                    case "credential-already-in-use":
                      print(
                          "The account corresponding to the credential already exists, "
                          "or is already linked to a Firebase User.");
                      break;
                    // See the API reference for the full list of error codes.
                    default:
                      print("Unknown error.");
                  }
                }
                try {
                  FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: code))
                      .then((value) async {
                    if (value.user != null) {
                      print('correct pin, logging in.');
                      Navigator.of(context)
                          .pushReplacementNamed(MainScreen.routename);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  errorSnackbar(context, 'Invalid OTP');
                }
              }
            },
          ),
        ],
      )),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 40,
        height: 50,
        child: ClipPath(
          clipper: const ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)))),
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFFF5F4F9),
                // borderRadius: BorderRadius.all(
                //   Radius.circular(15),
                // ),
                // color: Colors.orange,
                border: Border(
                    bottom: BorderSide(color: Color(0xFFE6E3F5), width: 4.5))
                // boxShadow: <BoxShadow>[
                //   BoxShadow(
                //       color: Color(0xFFE6E3F5),
                //       // blurRadius: 12,
                //       // spreadRadius: 4,
                //       offset: Offset(0.0, 0.75))
                // ],
                ),
            child: Center(
              child: Text(
                codeNumber,
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'ManRope SemiBold',
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(34, 26, 69, 1),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
