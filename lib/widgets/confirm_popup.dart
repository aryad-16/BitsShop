import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Constants/constants.dart';

Future<bool> showExitPopUp(BuildContext context, String title) async {
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                    title,
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
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
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
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 28),
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
