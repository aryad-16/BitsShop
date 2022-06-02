import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../Constants/constants.dart';
import '../../../providers/item_model.dart';
import '../home screen/grid_item.dart';
import '../home screen/search_screen.dart';

class ItemsGridView extends StatelessWidget {
  final bool isEdit;
  final String category;
  final List<Item> items;
  const ItemsGridView({
    Key? key,
    required this.category,
    required this.isEdit,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification? overscroll) {
        overscroll!.disallowIndicator();
        return true;
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const SearchScreen(),
                    ),
                  );
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(bottom: 15.0, left: 32, right: 32),
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsets.only(
                      top: 3.0, left: 10.0, bottom: 3.0, right: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SvgPicture.asset(
                        'assets/icons/search.svg',
                        height: 22,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Search $category',
                        style: TextStyle(
                          fontFamily: 'manRope Regular',
                          fontSize: 17,
                          color: Constant.greyColor1,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.black45),
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.685,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 15,
                  crossAxisCount: 2,
                ),
                itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
                  value: items[index],
                  child: SingleItemWidget(
                    isEdit: isEdit,
                  ),
                ),
                itemCount: items.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
