import 'package:flutter/material.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:login_singup_screen_ui/screens/signup%20and%20login/verifty_phone.dart';
import 'package:login_singup_screen_ui/widgets/error_snackbar.dart';

import '/widgets/numeric_pad.dart';

class ContinueWithPhone extends StatefulWidget {
  const ContinueWithPhone({Key? key}) : super(key: key);

  static const routeName = 'continuewithphone';

  @override
  _ContinueWithPhoneState createState() => _ContinueWithPhoneState();
}

class _ContinueWithPhoneState extends State<ContinueWithPhone> {
  String phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final width = MediaQuery.of(context).size.width;
    final height =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Send OTP",
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
      backgroundColor: const Color(0xFFF7F7F7),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFebebeb),
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  // decoration: const BoxDecoration(
                  //   gradient: LinearGradient(
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //     colors: [
                  //       Color(0xFFFFFFFF),
                  //       Color(0xFFF7F7F7),
                  //     ],
                  //   ),
                  // ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 130,
                        child: Image.asset('assets/images/holding-phone.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 74),
                        child: Text(
                          "You'll receive a 4 digit code to verify next.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins Regular',
                            fontSize: 17,
                            color: Constant.greyColor1,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(31),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        // color: Colors.blueGrey,
                        width: 0.5 * width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const FittedBox(
                              child: Text(
                                "Enter your phone number",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins Regular',
                                  // fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              //Adding a fittedBox (having issues, to be solved)
                              width: 0.4 * width,
                              child: Text(
                                phoneNumber,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'ManRope SemiBold',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: Constant.yellowlinear,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ElevatedButton(
                          style: Constant.elevatedButtonStyle,
                          onPressed: () {
                            if (phoneNumber.length == 10) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (ctx) =>
                                        VerifyPhone(phoneNumber: phoneNumber)
                                    // VerifyOTP(
                                    //   phoneNumber: phoneNumber,
                                    // ),
                                    ),
                              );
                            } else {
                              errorSnackbar(
                                  context, 'Please enter valid phone number');
                            }
                          },
                          child: const FittedBox(
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                fontFamily: 'Poppins SemiBold',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              NumericPad(
                onNumberSelected: (value) {
                  setState(
                    () {
                      if (phoneNumber.length == 10 && value != -1) {
                      } else if (value != -1) {
                        phoneNumber = phoneNumber + value.toString();
                      } else {
                        phoneNumber =
                            phoneNumber.substring(0, phoneNumber.length - 1);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
