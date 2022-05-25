import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class ItemCategoryScreen extends StatelessWidget {
  final String category;
  const ItemCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 245, 245, 245),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 6, top: 5),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 26,
            ),
            onPressed: () => Navigator.of(context).pop(),
            // color: const Color.fromARGB(180, 0, 0, 0),
            color: const Color.fromRGBO(14, 20, 70, 1),
          ),
        ),
        centerTitle: true,
        title: Text(
          category,
          style: const TextStyle(
            fontSize: 21,
            fontFamily: 'Poppins Medium',
            color: Color.fromRGBO(14, 20, 70, 1),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, left: 12.4),
            child: SvgPicture.asset(
              'assets/icons/filter.svg',
              width: 30,
              height: 30,
              color: const Color.fromRGBO(14, 20, 70, 1),
            ),
          ),
        ],
      ),
    );
  }
}
