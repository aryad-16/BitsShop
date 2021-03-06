import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:provider/provider.dart';

import '../../../Data/data.dart';
import '../../../providers/profiles_provider.dart';
import '../../../widgets/error_snackbar.dart';
import '../../../widgets/pick_image.dart';
import '../../signup and login/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final FocusNode _phoneNumberFocusNode = FocusNode();
final FocusNode _roomNoFocusNode = FocusNode();

class _ProfileScreenState extends State<ProfileScreen> {
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
    TextEditingController _phoneNumberController =
        TextEditingController(text: _profile.phoneNumber.toString())
          ..selection = TextSelection(
            baseOffset: _profile.phoneNumber.toString().length,
            extentOffset: _profile.phoneNumber.toString().length,
          );
    TextEditingController _roomNumberController =
        TextEditingController(text: _profile.rommNo.toString())
          ..selection = TextSelection(
            baseOffset: _profile.rommNo.toString().length,
            extentOffset: _profile.rommNo.toString().length,
          );
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
        Provider.of<Profiles>(context, listen: false)
            .updateProfile(profileID, 1, 'arya d yus boy');
        setState(() {
          this.image = imagetemp;
        });
      } on PlatformException catch (e) {
        errorSnackbar(context, 'Failed to pick image: $e');
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
                Provider.of<Profiles>(context, listen: false)
                    .updateProfile(profileID, 3, _bhawanNames[index]);
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
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
                      controller: TextEditingController()..text = _profile.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
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
                        ..text = _profile.email,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      focusNode: _phoneNumberFocusNode,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        counterText: '',
                        labelText: 'Phone Number',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                        isDense: true,
                      ),
                      style: const TextStyle(
                        fontFamily: 'ManRope Regular',
                        fontSize: 18,
                      ),
                      maxLength: 10,
                      onEditingComplete: () {
                        if (_phoneNumberController.text.length < 10) {
                          errorSnackbar(
                              context, 'Please enter valid phone number');
                          _phoneNumberController.text =
                              _profile.phoneNumber.toString();
                        } else {
                          Provider.of<Profiles>(context, listen: false)
                              .updateProfile(
                                  profileID, 2, _phoneNumberController.text);
                        }
                      },
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        _fieldFocusChange(
                            context, _phoneNumberFocusNode, _roomNoFocusNode);
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
                            enabledBorder: OutlineInputBorder(),
                            labelText: 'Bhawan',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 12,
                            ),
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
                    child: TextFormField(
                      focusNode: _roomNoFocusNode,
                      decoration: const InputDecoration(
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
                      controller: _roomNumberController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        Provider.of<Profiles>(context, listen: false)
                            .updateProfile(
                                profileID, 4, _roomNumberController.text);
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
                        Navigator.of(context).pushReplacement(
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
