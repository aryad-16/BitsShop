import 'package:flutter/material.dart';
import 'package:login_singup_screen_ui/providers/items_provider.dart';
import 'package:provider/provider.dart';

import '../../../Constants/constants.dart';
import '../Item Category Screen/item_category_screen.dart';
import 'grid_item.dart';

class HorizontalListView extends StatelessWidget {
  final String title;
  const HorizontalListView({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = title == 'Books'
        ? Provider.of<Items>(context).bookitems
        : title == 'Cycles'
            ? Provider.of<Items>(context).cycleitems
            : title == 'Electronics'
                ? Provider.of<Items>(context).electronicsitems
                : Provider.of<Items>(context).othersitems;
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'ManRope Regular',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.9,
                    color: Color.fromRGBO(34, 26, 69, 1),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ChangeNotifierProvider.value(
                            value: Items(),
                            child: ItemCategoryScreen(category: title)),
                      ),
                    );
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      fontFamily: 'ManRope Regular',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.9,
                      color: Constant.greyColor1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 310,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: items[index],
                  child: const SingleItemWidget(isEdit: false),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
