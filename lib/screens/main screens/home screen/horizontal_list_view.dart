import 'package:flutter/material.dart';
import 'package:login_singup_screen_ui/providers/items_provider.dart';
import 'package:provider/provider.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../Constants/constants.dart';
import '../../../providers/item_model.dart';
import '../Search Screen/search_screen.dart';
import 'grid_item.dart';

class HorizontalListView extends StatelessWidget {
  final ItemCategory category;
  const HorizontalListView({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items =
        Provider.of<Items>(context).searchItems(category, '', null, null, null);
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
                  category.toString().substring(13).capitalize ?? '',
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
                        builder: (ctx) =>
                            SearchScreen(category: category, isEdit: false),
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
          StreamBuilder<List<Item>>(
            stream: Items().getItemsList(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went worng ${snapshot.error}');
              } else if (snapshot.hasData) {
                final it = snapshot.data as List<Item>;
                return SizedBox(
                  height: 310,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: it.length < 5 ? it.length : 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                        value: it[index],
                        child: const SingleItemWidget(isEdit: false),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
