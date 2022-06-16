import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_singup_screen_ui/widgets/search_widget.dart';
import 'package:provider/provider.dart';

import '../../../Constants/constants.dart';
import '../../../Data/data.dart';
import '../../../providers/items_provider.dart';
import '../../../providers/profiles_provider.dart';
import '../../../widgets/rounded_containers.dart';
import '../Item Category Screen/items_grid_view.dart';

class SearchScreen extends StatefulWidget {
  final String category;
  final bool isEdit;
  const SearchScreen({Key? key, required this.category, required this.isEdit})
      : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  StateSetter? _setState;
  String? _selectedYear;
  String? _selectedSem;
  String? _selectedBranch;
  String query = '';
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ids = Provider.of<Profiles>(context, listen: false)
        .getProfile(profileID)
        .theirAdIds;
    final items = widget.category == 'Books'
        ? Provider.of<Items>(context, listen: false).searchBookItems(query)
        : widget.category == 'Cycles'
            ? Provider.of<Items>(context, listen: false).searchCycleItems(query)
            : widget.category == 'Electronics'
                ? Provider.of<Items>(context, listen: false)
                    .searchElectronicItems(query)
                : widget.category == 'All'
                    ? Provider.of<Items>(context, listen: false)
                        .searchAllItems(query)
                    : widget.category == 'Other'
                        ? Provider.of<Items>(context, listen: false)
                            .searchOtherItems(query)
                        : Provider.of<Items>(context)
                            .searchYourItems(ids, query);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: const Color.fromARGB(255, 245, 245, 245)),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 245, 245, 245),
          ),
          leading: widget.isEdit
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 6, top: 5),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 26,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).pop();
                    },
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
            widget.category == 'Books' || widget.category == 'All Products'
                ? GestureDetector(
                    onTap: () => _showFiltersDialog(context),
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
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: <Widget>[
                SearchWidget(
                  text: query,
                  hintText: widget.category == 'Manage Ads'
                      ? 'Search Ads'
                      : 'Search ${widget.category}',
                  onChanged: searchBook,
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ItemsGridView(
                    category: widget.category,
                    items: items,
                    isEdit: widget.isEdit,
                    searchInclude: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void searchBook(String query) {
    setState(() {
      this.query = query;
    });
  }

  Future<dynamic> _showFiltersDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        _controller.forward();
        return FadeTransition(
          opacity: _animation,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                _setState = setState;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Filter',
                          style: TextStyle(
                            fontFamily: 'manRope Regular',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              _setState!(() {
                                _selectedBranch = null;
                                _selectedSem = null;
                                _selectedYear = null;
                              });
                            },
                            child: const RoundedContainer(
                              title: 'Reset',
                              yellowBg: false,
                            )),
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
                            _setState!(() {
                              _selectedYear = '1st Year';
                            });
                          },
                          child: RoundedContainer(
                            title: '1st Year',
                            yellowBg: _selectedYear == '1st Year',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = '2nd Year';
                            });
                          },
                          child: RoundedContainer(
                            title: '2nd Year',
                            yellowBg: _selectedYear == '2nd Year',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = '3rd Year';
                            });
                          },
                          child: RoundedContainer(
                            title: '3rd Year',
                            yellowBg: _selectedYear == '3rd Year',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = '4th Year';
                            });
                          },
                          child: RoundedContainer(
                            title: '4th Year',
                            yellowBg: _selectedYear == '4th Year',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = '5th Year';
                            });
                          },
                          child: RoundedContainer(
                            title: '5th Year',
                            yellowBg: _selectedYear == '5th Year',
                          ),
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
                              _setState!(() {
                                _selectedSem = '1st Semester';
                              });
                            },
                            child: RoundedContainer(
                              title: '1st Semester',
                              yellowBg: _selectedSem == '1st Semester',
                            )),
                        const SizedBox(width: 10),
                        GestureDetector(
                            onTap: () {
                              _setState!(() {
                                _selectedSem = '2nd Semester';
                              });
                            },
                            child: RoundedContainer(
                              title: '2nd Semester',
                              yellowBg: _selectedSem == '2nd Semester',
                            )),
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
                            _setState!(() {
                              _selectedBranch = 'ENI';
                            });
                          },
                          child: RoundedContainer(
                            title: 'ENI',
                            yellowBg: _selectedBranch == 'ENI',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = 'ECE';
                            });
                          },
                          child: RoundedContainer(
                            title: 'ECE',
                            yellowBg: _selectedBranch == 'ECE',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = 'EEE';
                            });
                          },
                          child: RoundedContainer(
                            title: 'EEE',
                            yellowBg: _selectedBranch == 'EEE',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = 'CS';
                            });
                          },
                          child: RoundedContainer(
                            title: 'CS',
                            yellowBg: _selectedBranch == 'CS',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = 'Chemical';
                            });
                          },
                          child: RoundedContainer(
                            title: 'Chemical',
                            yellowBg: _selectedBranch == 'Chemical',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = 'Manufacturing';
                            });
                          },
                          child: RoundedContainer(
                            title: 'Manufacturing',
                            yellowBg: _selectedBranch == 'Manufacturing',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = 'Civil';
                            });
                          },
                          child: RoundedContainer(
                            title: 'Civil',
                            yellowBg: _selectedBranch == 'Civil',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = 'Bio Dual';
                            });
                          },
                          child: RoundedContainer(
                            title: 'Bio Dual',
                            yellowBg: _selectedBranch == 'Bio Dual',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = 'Phy Dual';
                            });
                          },
                          child: RoundedContainer(
                            title: 'Phy Dual',
                            yellowBg: _selectedBranch == 'Phy Dual',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = 'Chem Dual';
                            });
                          },
                          child: RoundedContainer(
                            title: 'Chem Dual',
                            yellowBg: _selectedBranch == 'Chem Dual',
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = 'Eco Dual';
                            });
                          },
                          child: RoundedContainer(
                            title: 'Eco Dual',
                            yellowBg: _selectedBranch == 'Eco Dual',
                          ),
                        ),
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
              },
            ),
          ),
        );
      },
    );
  }
}
