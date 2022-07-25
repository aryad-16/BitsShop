import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/Favorites%20Screen/favorite_items.dart';
import 'package:login_singup_screen_ui/widgets/initializer.dart';

import '../Constants/constants.dart';
import '../model/profile_model.dart';
import '../screens/bottom_nav_bar_screen.dart';
import '../screens/signup and login/login_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    required Profile profile,
  })  : _profile = profile,
        super(key: key);

  final Profile _profile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     IconButton(
              //       onPressed: () => Navigator.of(context).pop(),
              //       icon: const Icon(
              //         Icons.clear_rounded,
              //         size: 30,
              //         color: Colors.black87,
              //       ),
              //     ),
              //   ],
              // ),
              const Spacer(flex: 3),
              CircleAvatar(
                backgroundImage: NetworkImage(_profile.profilePicUrl),
                radius: 60,
              ),
              const Spacer(flex: 1),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  _profile.name,
                  style: const TextStyle(
                    fontFamily: 'ManRope SemiBold',
                    fontSize: 18,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  _profile.email,
                  style: const TextStyle(
                    fontFamily: 'ManRope Regular',
                    fontSize: 18,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              const Divider(
                color: Colors.black45,
                height: 22,
              ),
              const Spacer(flex: 1),
              GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(MainScreen.routename),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/home.svg',
                    width: 28,
                    height: 28,
                    color: const Color.fromRGBO(247, 154, 0, 1),
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(
                      fontFamily: 'ManRope Regular',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const FavoriteItemScreen(),
                  ),
                ),
                child: const ListTile(
                  leading: Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.red,
                    size: 28,
                  ),
                  title: Text(
                    'Favorites',
                    style: TextStyle(
                      fontFamily: 'ManRope Regular',
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
              const Divider(
                color: Colors.black45,
                height: 22,
              ),
              const Spacer(flex: 1),
              const ListTile(
                leading: Icon(
                  Icons.developer_mode_rounded,
                  color: Colors.blue,
                  size: 28,
                ),
                title: Text(
                  'Developers',
                  style: TextStyle(
                    fontFamily: 'ManRope Regular',
                    fontSize: 18,
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.privacy_tip_rounded,
                  color: Colors.red,
                  size: 28,
                ),
                title: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontFamily: 'ManRope Regular',
                    fontSize: 18,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              const Divider(
                color: Colors.black45,
                height: 22,
              ),
              const Spacer(flex: 1),
              Container(
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  boxShadow: [Constant.boxShadow],
                  gradient: Constant.yellowlinear,
                  borderRadius: BorderRadius.circular(100),
                ),
                height: 55,
                child: ElevatedButton(
                  style: Constant.elevatedButtonStyle,
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    await GoogleSignIn().signOut();
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => const InitializerWidget(),
                      ),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/icons/logout.svg',
                        color: Colors.white,
                      ),
                      const Text(
                        '  Logout',
                        style: TextStyle(
                          fontFamily: 'Poppins Bold',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
