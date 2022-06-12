import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:login_singup_screen_ui/screens/bottom_nav_bar_screen.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/home%20screen/home_screen.dart';
import 'package:login_singup_screen_ui/screens/signup%20and%20login/register_screen.dart';
import '../../widgets/numeric_pad.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';

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
    final auth = await FirebaseAuth.instance;
    auth.verifyPhoneNumber(
      phoneNumber: '+91' + widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential phonecredential) async {
        final googleUser = await GoogleSignIn().signIn();
        final googleAuth = await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        try {
          final userCredential = await FirebaseAuth.instance.currentUser
              ?.linkWithCredential(credential);
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
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  void initState() {
    // TODO: implement initState
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
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Verify OTP",
          style: TextStyle(
            fontSize: 19,
            fontFamily: 'Poppins Medium',
            // fontWeight: FontWeight.bold,
            color: Colors.black,
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
                top: 15, left: 0.06 * width, right: 0.06 * width, bottom: 10),
            decoration: BoxDecoration(
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
          // Container(
          //   height: MediaQuery.of(context).size.height * 0.13,
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(25),
          //     ),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(16),
          //     child: Row(
          //       children: <Widget>[
          //         Expanded(
          //           child: GestureDetector(
          //             onTap: () {
          //               Navigator.of(context).push(
          //                 MaterialPageRoute(
          //                   builder: (ctx) => const HomeScreen(),
          //                 ),
          //               );
          //             },
          //             child: Container(
          //               decoration: const BoxDecoration(
          //                 color: Color(0xFFFFDC3D),
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(15),
          //                 ),
          //               ),
          //               child: const Center(
          //                 child: Text(
          //                   "Verify and Create Account",
          //                   style: TextStyle(
          //                     fontSize: 18,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          NumericPad(
            onNumberSelected: (value) {
              print(value);
              setState(() {
                if (value != -1) {
                  if (code.length < 4) {
                    code = code + value.toString();
                  }
                } else {
                  code = code.substring(0, code.length - 1);
                }
                print(code);
              });
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
