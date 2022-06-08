import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../Constants/constants.dart';
import '../../../providers/items_provider.dart';
import 'items_grid_view.dart';

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
          category == 'Books'
              ? GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                'Filters',
                                style: TextStyle(
                                  fontFamily: 'manRope Regular',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              roundedContainer('Reset'),
                            ],
                          ),
                          const Divider(
                            color: Colors.black87,
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              'YEAR',
                              style: TextStyle(
                                fontFamily: 'manRope Regular',
                                fontSize: 16,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            direction: Axis.horizontal,
                            runSpacing: 6,
                            children: [
                              roundedContainer('1st Year'),
                              const SizedBox(width: 10),
                              roundedContainer('2nd Year'),
                              const SizedBox(width: 10),
                              roundedContainer('3rd Year'),
                              const SizedBox(width: 10),
                              roundedContainer('4th Year'),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 4, top: 20),
                            child: Text(
                              'SEMESTER',
                              style: TextStyle(
                                fontFamily: 'manRope Regular',
                                fontSize: 16,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                roundedContainer('1st Semester'),
                                const SizedBox(width: 10),
                                roundedContainer('2nd Semester'),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 4, top: 20),
                            child: Text(
                              'BRANCH',
                              style: TextStyle(
                                fontFamily: 'manRope Regular',
                                fontSize: 16,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const SizedBox(height: 7),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                roundedContainer('ENI'),
                                const SizedBox(width: 10),
                                roundedContainer('ECE'),
                                const SizedBox(width: 10),
                                roundedContainer('EEE'),
                                const SizedBox(width: 10),
                                roundedContainer('CS'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 12.4),
                    child: SvgPicture.asset(
                      'assets/icons/filter.svg',
                      width: 30,
                      height: 30,
                      color: const Color.fromRGBO(14, 20, 70, 1),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: ItemsGridView(category: category, items: items, isEdit: false),
    );
  }

  Container roundedContainer(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Constant.yellowColor,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'manRope Regular',
          fontSize: 16,
          color: Constant.yellowColor,
        ),
      ),
    );
  }
}
