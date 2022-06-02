import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../Constants/constants.dart';
import '../../../providers/items_provider.dart';
import '../home screen/grid_item.dart';
import '../home screen/search_screen.dart';

class ItemCategoryScreen extends StatelessWidget {
  final String category;
  const ItemCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = category == 'Books'
        ? Provider.of<Items>(context).bookitems
        : category == 'Cycles'
            ? Provider.of<Items>(context).cycleitems
            : category == 'Electronics'
                ? Provider.of<Items>(context).electronicsitems
                : Provider.of<Items>(context).othersitems;
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
      body: NotificationListener<OverscrollIndicatorNotification>(
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
                    margin: const EdgeInsets.only(
                        bottom: 15.0, left: 32, right: 32),
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
                    child: const SingleItemWidget(),
                  ),
                  itemCount: items.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
