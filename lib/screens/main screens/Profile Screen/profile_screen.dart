import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:login_singup_screen_ui/Constants/pick_image.dart';
import 'package:login_singup_screen_ui/screens/signup%20and%20login/login_screen.dart';
import 'package:provider/provider.dart';

import '../../../Data/data.dart';
import '../../../providers/profiles_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode roomNoFocusNode = FocusNode();
  final List<String> _bhawanNames = [
    'Shankar Bhawan',
    'vyas Bhawan',
    'Ram Bhawan',
    'Budh Bhawan',
    'Krishna Bhawan',
    'Ghandhi Bhawan',
    'Meera Bhawan'
  ];
  File? image;
  @override
  Widget build(BuildContext context) {
    final _profile =
        Provider.of<Profiles>(context, listen: false).getProfile(profileID);
    TextEditingController bhawanNameController =
        TextEditingController(text: _profile.bhawanName);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    _fieldFocusChange(
        BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }

    Future pickImage(ImageSource imageSource) async {
      try {
        final image = await ImagePicker().pickImage(source: imageSource);
        if (image == null) return;
        final imagetemp = File(image.path);
        setState(() {
          this.image = imagetemp;
        });
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }

    void _showModalSheet() {
      showModalBottomSheet(
        context: context,
        builder: (context) => ListView.builder(
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () {
                bhawanNameController.text = _bhawanNames[index];
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  _bhawanNames[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'ManRope Regular',
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
          itemCount: _bhawanNames.length,
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        leading: const SizedBox(),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 21,
            fontFamily: 'Poppins Medium',
            color: Color.fromRGBO(14, 20, 70, 1),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: image == null
                              ? Image.network(
                                  _profile.profilePicUrl,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  image!,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        child: buildCircle(
                          child: buildCircle(
                            child: GestureDetector(
                              onTap: () => showPopUp(context, pickImage),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            color: Colors.blue,
                            padding: 8,
                          ),
                          color: Colors.white,
                          padding: 3,
                        ),
                        bottom: 12,
                        right: 0,
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.black87,
                    indent: 22,
                    height: 25,
                    endIndent: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextField(
                      focusNode: nameFocusNode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        labelText: 'Name',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                        isDense: true,
                      ),
                      onSubmitted: (_) {
                        _fieldFocusChange(
                            context, nameFocusNode, phoneNumberFocusNode);
                      },
                      onEditingComplete: () => print('Hi bro '),
                      style: const TextStyle(
                        fontFamily: 'ManRope Regular',
                        fontSize: 18,
                      ),
                      controller: TextEditingController()..text = _profile.name,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        labelText: 'Email',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                        isDense: true,
                      ),
                      enabled: false,
                      style: TextStyle(
                        fontFamily: 'ManRope Regular',
                        fontSize: 18,
                        color: Constant.greyColor1,
                      ),
                      controller: TextEditingController()
                        ..text = 'f20201556@pilani.bits-pilani.ac.in',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextField(
                      focusNode: phoneNumberFocusNode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        disabledBorder: OutlineInputBorder(),
                        labelText: 'Phone Number',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                        isDense: true,
                      ),
                      style: const TextStyle(
                        fontFamily: 'ManRope Regular',
                        fontSize: 18,
                      ),
                      controller: TextEditingController()
                        ..text = _profile.phoneNumber.toString(),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) {
                        _fieldFocusChange(
                            context, phoneNumberFocusNode, roomNoFocusNode);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: InkWell(
                      onTap: () => _showModalSheet(),
                      child: IgnorePointer(
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            labelText: 'Bhawan',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 18, horizontal: 12),
                            isDense: true,
                          ),
                          style: const TextStyle(
                            fontFamily: 'ManRope Regular',
                            fontSize: 18,
                          ),
                          controller: bhawanNameController,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextField(
                      focusNode: roomNoFocusNode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        labelText: 'Room Number',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                        isDense: true,
                      ),
                      style: const TextStyle(
                        fontFamily: 'ManRope Regular',
                        fontSize: 18,
                      ),
                      controller: TextEditingController()
                        ..text = _profile.rommNo.toString(),
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
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
                            builder: (ctx) => const LoginScreen(),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCircle(
          {required Widget child,
          required Color color,
          required double padding}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(padding),
          color: color,
          child: child,
        ),
      );
}
