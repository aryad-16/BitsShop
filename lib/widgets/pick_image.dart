import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

Future showPopUp(BuildContext context,
        Future Function(ImageSource imageSource) pickImage) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 80),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
