import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/home%20screen/home_screen.dart';
import 'package:pinput/pinput.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({Key? key, this.phoneNumber}) : super(key: key);
  final phoneNumber;
  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  String _verificationCode = "";

  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
    width: 60,
    height: 64,
    textStyle:
        GoogleFonts.poppins(fontSize: 20, color: Color.fromRGBO(70, 69, 66, 1)),
    decoration: BoxDecoration(
      color: Color.fromRGBO(232, 235, 241, 0.37),
      borderRadius: BorderRadius.circular(24),
    ),
  );

  final cursor = Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: 21,
      height: 1,
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(137, 146, 160, 1),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

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
              Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
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
    // TODO: implement initState
    _verifyPhone();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(title: Text('OTP Verification')),
      body: Column(children: [
        Container(
          margin: EdgeInsets.all(40),
          child: Text('OTP has been sent to ${widget.phoneNumber}'),
        ),
        Pinput(
          length: 6,
          controller: controller,
          focusNode: focusNode,
          defaultPinTheme: defaultPinTheme,
          separator: SizedBox(width: 16),
          onSubmitted: (pin) async {
            try {
              final credential = PhoneAuthProvider.credential(
                  verificationId: _verificationCode, smsCode: pin);
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
            try {
              FirebaseAuth.instance
                  .signInWithCredential(PhoneAuthProvider.credential(
                      verificationId: _verificationCode, smsCode: pin))
                  .then((value) async {
                if (value.user != null) {
                  print('correct pin, logging in.');
                  Navigator.of(context)
                      .pushReplacementNamed(HomeScreen.routename);
                }
              });
            } catch (e) {
              FocusScope.of(context).unfocus();
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Invalid OTP')));
            }
          },
          focusedPinTheme: defaultPinTheme.copyWith(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
                  offset: Offset(0, 3),
                  blurRadius: 16,
                )
              ],
            ),
          ),
          showCursor: true,
          cursor: cursor,
        )
      ]),
    );
  }
}
