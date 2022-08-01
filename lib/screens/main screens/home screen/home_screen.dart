import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:login_singup_screen_ui/providers/item_model.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/Search%20Screen/search_screen.dart';
import 'package:provider/provider.dart';

import '../../../Data/data.dart';
import '../../../providers/profiles_provider.dart';
import '../../../widgets/drawer.dart';
import 'horizontal_list_view.dart';

class HomeScreen extends StatefulWidget {
  static const routename = 'homescreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool _isInit = true;
  // Future<void> getFeedItems(BuildContext context) async {
  //   print("Hello guys have a good day");
  //   List<Item> feedItems = [];
  //   await FirebaseFirestore.instance.collection('items').get().then((ds) {
  //     feedItems = ds.docs
  //         .map((doc) => Item(
  //             category: Category.values
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
  //     // Provider.of<Items>(context).setItemsList(feedItems);
  //     print("Hello guys have a good fking day ${feedItems[0].branch}");
  //     // print("Hello guys have a good fking day");
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
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final _profile =
        Provider.of<Profiles>(context, listen: false).getProfile(profileID);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, right: 5),
          child: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Transform.scale(
                  scale: 0.95,
                  child: SvgPicture.asset(
                    'assets/icons/menu.svg',
                  ),
                ),
              );
            },
          ),
        ),
        title: Text(
          'BitsShop',
          style: TextStyle(
            fontFamily: 'ManRope SemiBold',
            fontSize: 28,
            letterSpacing: 1.2,
            color: Constant.yellowColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              width: 28,
              child: SvgPicture.asset(
                'assets/icons/notification_on.svg',
              ),
            ),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 245, 245, 245),
          statusBarIconBrightness: Brightness.dark,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: DrawerWidget(profile: _profile),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification? overscroll) {
          overscroll!.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const SearchScreen(
                        category: ItemCategory.all,
                        isEdit: false,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 15.0, left: 32, right: 32),
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.only(
                      top: 3.0, left: 10.0, bottom: 3.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/icons/search.svg',
                        height: 22,
                      ),
                      SvgPicture.asset(
                        'assets/icons/filter.svg',
                        height: 22,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black45),
                  ),
                ),
              ),
              Container(
                height: 32,
                margin: const EdgeInsets.only(top: 5.0, left: 32, right: 32),
                child: Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icons/location.svg',
                      color: Constant.yellowColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Deliver to ",
                      style: TextStyle(
                        fontFamily: 'manRope Regular',
                        fontSize: 15,
                        color: Constant.greyColor1,
                      ),
                    ),
                    const Text(
                      "Arya, Pilani",
                      style: TextStyle(
                        fontFamily: 'manRope SemiBold',
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const HorizontalListView(category: ItemCategory.books),
              const HorizontalListView(category: ItemCategory.cycles),
              const HorizontalListView(category: ItemCategory.electronics),
              const HorizontalListView(category: ItemCategory.others),
            ],
          ),
          padding: const EdgeInsets.only(bottom: 15),
        ),
      ),
    );
  }
}
