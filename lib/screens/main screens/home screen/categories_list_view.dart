import 'package:flutter/material.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/Item%20Category%20Screen/item_category_screen.dart';

Widget categorieslistView(int index, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ItemCategoryScreen(
          category: 'Books',
        ),
      ),
    ),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 150,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Image.network(
                  'https://m.media-amazon.com/images/I/71an9eiBxpL._AC_SL1500_.jpg',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              SizedBox(
                height: 35,
                child: Center(
                  child: Text(
                    index == 0
                        ? 'Bicycle'
                        : index == 1
                            ? 'Laptop Accessories'
                            : index == 2
                                ? 'Party'
                                : 'Gym    Accessories',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins Medium',
                      // fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(14, 20, 70, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
