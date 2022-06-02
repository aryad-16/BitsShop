import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';

// ignore: must_be_immutable
class AddPicture extends StatefulWidget {
  final BuildContext context;
  final int index;
  List<String> imageList;
  AddPicture({
    Key? key,
    required this.imageList,
    required this.context,
    required this.index,
  }) : super(key: key);

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  File? image;

  Future pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final imagetemp = File(image.path);
      setState(() {
        this.image = imagetemp;
        widget.imageList[widget.index] = image.path;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future showPopUp() => showDialog(
        context: widget.context,
        builder: (context) => AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 80),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black),
                  ),
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: SvgPicture.asset(
                            'assets/icons/addimagefromgallery.svg'),
                      ),
                      const Text('Gallery'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black),
                  ),
                  height: 90,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: SvgPicture.asset(
                            'assets/icons/addimagefromcamera.svg'),
                      ),
                      const Text('Camera'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPopUp(),
      child: Container(
        width: 250,
        margin: const EdgeInsets.fromLTRB(10, 51.5, 10, 24.5),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Center(
              child: widget.imageList[widget.index] != 'a'
                  ? ClipRRect(
                      child: Image.file(File(widget.imageList[widget.index])),
                      borderRadius: BorderRadius.circular(10),
                    )
                  : image != null
                      ? ClipRRect(
                          child: Image.file(image!),
                          borderRadius: BorderRadius.circular(10),
                        )
                      : SvgPicture.asset(
                          'assets/icons/images.svg',
                          color: const Color.fromRGBO(34, 26, 69, 1),
                          width: 30,
                        ),
            ),
            image != null || widget.imageList[widget.index] != 'a'
                ? Positioned(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          image = null;
                          widget.imageList.removeAt(widget.index);
                          widget.imageList.add('a');
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: SvgPicture.asset(
                          'assets/icons/delete.svg',
                          color: Constant.yellowColor,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(1),
                        ),
                      ),
                    ),
                    right: 4,
                    top: 4,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
