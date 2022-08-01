import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/Search%20Screen/search_screen.dart';
import 'package:login_singup_screen_ui/widgets/animated_indexed_stack.dart';
import 'package:login_singup_screen_ui/widgets/confirm_popup.dart';

import '../providers/item_model.dart';
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
    const SearchScreen(category: ItemCategory.yourItems, isEdit: true),
    const ProfileScreen(),
  ];

  // bool _isInit = true;
  // Future<void> getFeedItems(BuildContext context) async {
  //   print("Hello guys have a good day");
  //   List<Item> feedItems = [];
  //   await FirebaseFirestore.instance.collection('items').get().then((ds) {
  //     feedItems = ds.docs
  //         .map((doc) => Item(
  //             category: ItemCategory.values
  //                 .firstWhere((e) => e.toString() == doc['category']),
  //             price: int.parse(doc['price']),
  //             profileId: doc['profileId'],
  //             title: doc['title'],
  //             id: doc['id'],
  //             description: doc['description'],
  //             imageList: doc['imageList'].split(','),
  //             year: doc.data().toString().contains('year')
  //                 ? YearCategory.values
  //                     .firstWhere((e) => e.toString() == doc['year'])
  //                 : null,
  //             sem: doc.data().toString().contains('semester')
  //                 ? SemesterCategory.values
  //                     .firstWhere((e) => e.toString() == doc['semester'])
  //                 : null,
  //             branch: doc.data().toString().contains('branch')
  //                 ? BranchCategory.values
  //                     .firstWhere((e) => e.toString() == doc['branch'])
  //                 : null))
  //         .toList();
  //     Provider.of<Items>(context).setItemsList(feedItems);
  //     print(feedItems[0].branch);
  //     print("Hello guys have a good fking day");
  //   }).catchError((e) {
  //     print(e);
  //   }).then((value) {});
  // }

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     getFeedItems(context);
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          showExitPopUp(context, 'Are you sure you want to exit the app?'),
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
