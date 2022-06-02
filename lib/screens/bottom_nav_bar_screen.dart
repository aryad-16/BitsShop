import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_singup_screen_ui/providers/items_provider.dart';
import 'package:login_singup_screen_ui/widgets/animated_indexed_stack.dart';
import 'package:provider/provider.dart';

import 'main screens/New Ad Screen/new_ad_screen.dart';
import 'main screens/ads_alive_screen.dart';
import 'main screens/home screen/home_screen.dart';
import 'main screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageindex = 0;
  List<Widget> pagelist = <Widget>[
    const HomeScreen(),
    const NewAdScreen(),
    const AdsAliveScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Items(),
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
    );
  }
}
