import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/home%20screen/search_screen.dart';
import 'package:login_singup_screen_ui/widgets/animated_indexed_stack.dart';

import '../Constants/constants.dart';
import 'main screens/New Ad Screen/new_ad_screen.dart';
import 'main screens/Profile Screen/profile_screen.dart';
import 'main screens/home screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  static const routename = 'mainscreen';
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageindex = 0;
  List<Widget> pagelist = <Widget>[
    const HomeScreen(),
    const NewAdScreen(),
    const SearchScreen(category: 'Manage Ads', isEdit: true),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopUp() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(237, 92, 90, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    const Spacer(flex: 1),
                    const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    const Spacer(flex: 10),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icons/cancel_sign.svg',
                      width: 40,
                      color: const Color.fromRGBO(237, 92, 90, 1),
                    ),
                    const SizedBox(width: 20),
                    Flexible(
                      child: Text(
                        'Are you sure you want to exit the app?',
                        style: TextStyle(
                          color: Constant.greyColor1,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(false);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Constant.greyColor1,
                  ),
                ),
                child: Text(
                  'NO',
                  style: TextStyle(
                    color: Constant.greyColor1,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(true);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 28),
                margin: const EdgeInsets.only(bottom: 12, right: 12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(237, 92, 90, 1),
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromRGBO(237, 92, 90, 1),
                ),
                child: const Text(
                  'YES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: showExitPopUp,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: const Color.fromARGB(255, 245, 245, 245)),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _pageindex,
            onTap: (value) {
              setState(() {
                _pageindex = value;
              });
            },
            selectedIconTheme:
                const IconThemeData(color: Color.fromRGBO(247, 154, 0, 1)),
            selectedItemColor: const Color.fromRGBO(247, 154, 0, 1),
            // backgroundColor: const Color.fromRGBO(27, 27, 27, 1),
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 15,
            unselectedFontSize: 14,
            unselectedIconTheme: const IconThemeData(color: Colors.black87),
            unselectedItemColor: const Color.fromRGBO(237, 236, 232, 1),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  width: 28,
                  height: 28,
                  color: const Color.fromRGBO(27, 27, 27, 1),
                ),
                label: "Home",
                activeIcon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  width: 28,
                  height: 28,
                  color: const Color.fromRGBO(247, 154, 0, 1),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/addnewad.svg',
                  width: 28,
                  height: 28,
                  color: const Color.fromRGBO(27, 27, 27, 1),
                ),
                label: "Lending",
                activeIcon: SvgPicture.asset(
                  'assets/icons/addnewad.svg',
                  width: 28,
                  height: 28,
                  color: const Color.fromRGBO(247, 154, 0, 1),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/adslist.svg',
                  width: 28,
                  height: 28,
                  color: const Color.fromRGBO(27, 27, 27, 1),
                ),
                label: "Ads Alive",
                activeIcon: SvgPicture.asset(
                  'assets/icons/adslist.svg',
                  width: 28,
                  height: 28,
                  color: const Color.fromRGBO(247, 154, 0, 1),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/person.svg',
                  width: 28,
                  height: 28,
                  color: const Color.fromRGBO(27, 27, 27, 1),
                ),
                label: "Profile",
                activeIcon: SvgPicture.asset(
                  'assets/icons/person.svg',
                  width: 28,
                  height: 28,
                  color: const Color.fromRGBO(247, 154, 0, 1),
                ),
              ),
            ],
          ),
          body: AnimatedIndexedStack(
            children: pagelist,
            index: _pageindex,
          ),
        ),
      ),
    );
  }
}
