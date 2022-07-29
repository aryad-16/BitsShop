import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as rp;
import 'package:image_picker/image_picker.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:login_singup_screen_ui/model/user_data_model.dart';
import 'package:provider/provider.dart';

import '../../../Data/data.dart';
import '../../../providers/profiles_provider.dart';
import '../../../widgets/error_snackbar.dart';
import '../../../widgets/pick_image.dart';

class ProfileScreen extends rp.ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  rp.ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

final FocusNode _phoneNumberFocusNode = FocusNode();
final FocusNode _roomNoFocusNode = FocusNode();

class _ProfileScreenState extends rp.ConsumerState<ProfileScreen> {
  bool editMode = false;
  var _formKey = GlobalKey<FormState>();
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
  var userdata;
  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final imagetemp = File(image.path);
      final ref = FirebaseStorage.instance.ref();
      debugPrint('got file');
      print(userdata?.uid.toString());
      await ref
          .child('profilePics/${userdata!.uid}')
          .putFile(imagetemp)
          .whenComplete(() async {
        debugPrint('uploading');
        await ref.child('profilePics/${userdata!.uid}').getDownloadURL().then((value) async {
          await FirebaseFirestore.instance
              .collection('Profiles')
              .doc(userdata!.uid)
              .set({'profilePicUrl': value}, SetOptions(merge: true));
        });
      });
      setState(() {
        this.image = imagetemp;
      });
    } on PlatformException catch (e) {
      errorSnackbar(context, 'Failed to pick image: $e');
    }
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    userdata = ref.read(currentUserDataProvider.state).state;
    final _profile = ref.watch(currentUserDataProvider.state).state;
    TextEditingController _phoneNumberController =
        TextEditingController(text: _profile!.phoneNumber.toString())
          ..selection = TextSelection(
            baseOffset: _profile.phoneNumber.toString().length,
            extentOffset: _profile.phoneNumber.toString().length,
          );
    TextEditingController _roomNumberController =
        TextEditingController(text: _profile.roomNo.toString())
          ..selection = TextSelection(
            baseOffset: _profile.roomNo.toString().length,
            extentOffset: _profile.roomNo.toString().length,
          );

    void _showModalSheet() {
      showModalBottomSheet(
        context: context,
        builder: (context) => ListView.builder(
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  userdata!.bhawanName = _bhawanNames[index];
                });
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
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Form(
              key: _formKey,
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
                                  width: 180,
                                  height: 180,
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
                  const Spacer(flex: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
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
                      controller: TextEditingController()
                        ..text = _profile.username,
                    ),
                  ),
                  const Spacer(flex: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: TextField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(),
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
                  const Spacer(flex: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: TextFormField(
                      enabled: editMode,
                      focusNode: _phoneNumberFocusNode,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        counterText: '',
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.black),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                        isDense: true,
                      ),
                      style: const TextStyle(
                        fontFamily: 'ManRope Regular',
                        fontSize: 18,
                      ),
                      maxLength: 10,
                      validator: (value) {
                        if (value == null || value.length < 10) {
                          return 'Please enter a valid phone number';
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
                  const Spacer(flex: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: InkWell(
                      onTap: editMode ? _showModalSheet : null,
                      child: IgnorePointer(
                        child: TextFormField(
                          initialValue: userdata!.bhawanName,
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a bhawan';
                            }
                          },
                          enabled: editMode,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            labelText: 'Bhawan',
                            labelStyle: TextStyle(color: Colors.black),
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
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.length < 4 ||
                            value.length > 4) {
                          return 'Please select a room number (4 digits)';
                        }
                      },
                      enabled: editMode,
                      focusNode: _roomNoFocusNode,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        labelText: 'Room Number',
                        labelStyle: TextStyle(color: Colors.black),
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
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (editMode == false)
            setState(() {
              editMode = !editMode;
            });
          else {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              userdata.roomNo = _roomNumberController.text;
              userdata.phoneNumber = _phoneNumberController.text;
              await FirebaseFirestore.instance
                  .collection('Profiles')
                  .doc(userdata.uid)
                  .update(
                {
                  'bhawanName': userdata.bhawanName,
                  'roomNo': userdata.roomNo,
                  'phoneNumber': userdata.phoneNumber,
                },
              );
              setState(() {
                editMode = !editMode;
              });
            }
          }
        },
        child: !editMode ? Icon(Icons.edit) : Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
