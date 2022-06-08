import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../Constants/constants.dart';
import '../../../providers/items_provider.dart';
import 'items_grid_view.dart';

class ItemCategoryScreen extends StatefulWidget {
  final String category;
  const ItemCategoryScreen({Key? key, required this.category})
      : super(key: key);

  @override
  State<ItemCategoryScreen> createState() => _ItemCategoryScreenState();
}

class _ItemCategoryScreenState extends State<ItemCategoryScreen> {
  late StateSetter _setState;
  String? _selectedYear;
  String? _selectedSem;
  String? _selectedBranch;
  @override
  Widget build(BuildContext context) {
    final items = widget.category == 'Books'
        ? Provider.of<Items>(context).bookitems
        : widget.category == 'Cycles'
            ? Provider.of<Items>(context).cycleitems
            : widget.category == 'Electronics'
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
          widget.category,
          style: const TextStyle(
            fontSize: 21,
            fontFamily: 'Poppins Medium',
            color: Color.fromRGBO(14, 20, 70, 1),
          ),
        ),
        actions: [
          widget.category == 'Books'
              ? GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        content: StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          _setState = setState;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'Filters',
                                    style: TextStyle(
                                      fontFamily: 'manRope Regular',
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedBranch = null;
                                          _selectedSem = null;
                                          _selectedYear = null;
                                        });
                                      },
                                      child: roundedContainer('Reset', false)),
                                ],
                              ),
                              const Divider(
                                color: Colors.black87,
                                height: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5),
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
                                alignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                runSpacing: 6,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _setState(() {
                                        _selectedYear = '1st Year';
                                      });
                                    },
                                    child: roundedContainer('1st Year',
                                        _selectedYear == '1st Year'),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      _setState(() {
                                        _selectedYear = '2nd Year';
                                      });
                                    },
                                    child: roundedContainer('2nd Year',
                                        _selectedYear == '2nd Year'),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      _setState(() {
                                        _selectedYear = '3rd Year';
                                      });
                                    },
                                    child: roundedContainer('3rd Year',
                                        _selectedYear == '3rd Year'),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      _setState(() {
                                        _selectedYear = '4th Year';
                                      });
                                    },
                                    child: roundedContainer('4th Year',
                                        _selectedYear == '4th Year'),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      _setState(() {
                                        _selectedYear = '5th Year';
                                      });
                                    },
                                    child: roundedContainer('5th Year',
                                        _selectedYear == '5th Year'),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
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
                              Wrap(
                                alignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                runSpacing: 6,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedSem = '1st Semester';
                                        });
                                      },
                                      child: roundedContainer('1st Semester',
                                          _selectedSem == '1st Semester')),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedSem = '2nd Semester';
                                        });
                                      },
                                      child: roundedContainer('2nd Semester',
                                          _selectedSem == '2nd Semester')),
                                  const SizedBox(width: 10),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
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
                              Wrap(
                                alignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                runSpacing: 6,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedBranch = 'ENI';
                                        });
                                      },
                                      child: roundedContainer(
                                          'ENI', _selectedBranch == 'ENI')),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedBranch = 'ECE';
                                        });
                                      },
                                      child: roundedContainer(
                                          'ECE', _selectedBranch == 'ECE')),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedBranch = 'EEE';
                                        });
                                      },
                                      child: roundedContainer(
                                          'EEE', _selectedBranch == 'EEE')),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedBranch = 'CS';
                                        });
                                      },
                                      child: roundedContainer(
                                          'CS', _selectedBranch == 'CS')),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedBranch = 'Chemical';
                                        });
                                      },
                                      child: roundedContainer('Chemical',
                                          _selectedBranch == 'Chemical')),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedBranch = 'Manufacturing';
                                        });
                                      },
                                      child: roundedContainer('Manufacturing',
                                          _selectedBranch == 'Manufacturing')),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedBranch = 'Civil';
                                        });
                                      },
                                      child: roundedContainer(
                                          'Civil', _selectedBranch == 'Civil')),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedBranch = 'Bio Dual';
                                        });
                                      },
                                      child: roundedContainer('Bio Dual',
                                          _selectedBranch == 'Bio Dual')),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedBranch = 'Phy Dual';
                                        });
                                      },
                                      child: roundedContainer('Phy Dual',
                                          _selectedBranch == 'Phy Dual')),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedBranch = 'Chem Dual';
                                        });
                                      },
                                      child: roundedContainer('Chem Dual',
                                          _selectedBranch == 'Chem Dual')),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                      onTap: () {
                                        _setState(() {
                                          _selectedBranch = 'Eco Dual';
                                        });
                                      },
                                      child: roundedContainer('Eco Dual',
                                          _selectedBranch == 'Eco Dual')),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [Constant.boxShadow],
                                      gradient: Constant.yellowlinear,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 14),
                                    margin: const EdgeInsets.only(top: 28),
                                    child: const Text(
                                      'Refine Search',
                                      style: TextStyle(
                                        fontFamily: 'ManRope Regular',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.9,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                      );
                    },
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
      body:
          ItemsGridView(category: widget.category, items: items, isEdit: false),
    );
  }

  Widget roundedContainer(String title, bool yellowBg) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        color: yellowBg ? Constant.yellowColor : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Constant.yellowColor),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'manRope Regular',
          fontSize: 16,
          color: yellowBg ? Colors.white : Constant.yellowColor,
        ),
      ),
    );
  }
}
