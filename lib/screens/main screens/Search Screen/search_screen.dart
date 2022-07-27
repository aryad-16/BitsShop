import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_singup_screen_ui/widgets/search_widget.dart';
import 'package:provider/provider.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../Constants/constants.dart';
import '../../../Data/data.dart';
import '../../../providers/item_model.dart';
import '../../../providers/items_provider.dart';
import '../../../providers/profiles_provider.dart';
import '../../../widgets/rounded_containers.dart';
import '../Item Category Screen/items_grid_view.dart';

class SearchScreen extends StatefulWidget {
  final ItemCategory category;
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
  YearCategory? _selectedYear;
  SemesterCategory? _selectedSem;
  BranchCategory? _selectedBranch;
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
    final List<String> ids = Provider.of<Profiles>(context, listen: false)
        .getProfile(profileID)
        .theirAdIds;
    final items = widget.category == ItemCategory.yourItems
        ? Provider.of<Items>(context, listen: false).searchYourItems(ids, query)
        : Provider.of<Items>(context, listen: false).searchItems(
            widget.category,
            query,
            _selectedYear,
            _selectedSem,
            _selectedBranch,
          );

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
            widget.category == ItemCategory.yourItems
                ? 'Manage Ads'
                : widget.category == ItemCategory.all
                    ? 'All Items'
                    : widget.category.toString().substring(13).capitalize ?? '',
            style: const TextStyle(
              fontSize: 21,
              fontFamily: 'Poppins Medium',
              color: Color.fromRGBO(14, 20, 70, 1),
            ),
          ),
          actions: [
            widget.category == ItemCategory.books ||
                    widget.category == ItemCategory.all
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
                  hintText: widget.category == ItemCategory.yourItems
                      ? 'Search Ads'
                      : widget.category == ItemCategory.all
                          ? 'Search All Items'
                          : 'Search ${widget.category.toString().substring(13).capitalize ?? ''}',
                  onChanged: searchBook,
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: ItemsGridView(
                    items: items,
                    isEdit: widget.isEdit,
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
                              _selectedYear = YearCategory.first;
                            });
                          },
                          child: RoundedContainer(
                            title: '1st Year',
                            yellowBg: _selectedYear == YearCategory.first,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = YearCategory.second;
                            });
                          },
                          child: RoundedContainer(
                            title: '2nd Year',
                            yellowBg: _selectedYear == YearCategory.second,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = YearCategory.third;
                            });
                          },
                          child: RoundedContainer(
                            title: '3rd Year',
                            yellowBg: _selectedYear == YearCategory.third,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = YearCategory.fourth;
                            });
                          },
                          child: RoundedContainer(
                            title: '4th Year',
                            yellowBg: _selectedYear == YearCategory.fourth,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = YearCategory.fifth;
                            });
                          },
                          child: RoundedContainer(
                            title: '5th Year',
                            yellowBg: _selectedYear == YearCategory.fifth,
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
                                _selectedSem = SemesterCategory.first;
                              });
                            },
                            child: RoundedContainer(
                              title: '1st Semester',
                              yellowBg: _selectedSem == SemesterCategory.first,
                            )),
                        const SizedBox(width: 10),
                        GestureDetector(
                            onTap: () {
                              _setState!(() {
                                _selectedSem = SemesterCategory.second;
                              });
                            },
                            child: RoundedContainer(
                              title: '2nd Semester',
                              yellowBg: _selectedSem == SemesterCategory.second,
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
                              _selectedBranch = BranchCategory.eni;
                            });
                          },
                          child: RoundedContainer(
                              title: 'ENI',
                              yellowBg: _selectedBranch == BranchCategory.eni),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.ece;
                            });
                          },
                          child: RoundedContainer(
                            title: 'ECE',
                            yellowBg: _selectedBranch == BranchCategory.ece,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.eee;
                            });
                          },
                          child: RoundedContainer(
                            title: 'EEE',
                            yellowBg: _selectedBranch == BranchCategory.eee,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.cs;
                            });
                          },
                          child: RoundedContainer(
                            title: 'CS',
                            yellowBg: _selectedBranch == BranchCategory.cs,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.chemical;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Chemical',
                            yellowBg:
                                _selectedBranch == BranchCategory.chemical,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.manufacturing;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Manufacturing',
                            yellowBg:
                                _selectedBranch == BranchCategory.manufacturing,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.civil;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Civil',
                            yellowBg: _selectedBranch == BranchCategory.civil,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.bioDual;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Bio Dual',
                            yellowBg: _selectedBranch == BranchCategory.bioDual,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.phyDual;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Phy Dual',
                            yellowBg: _selectedBranch == BranchCategory.phyDual,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.chemDual;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Chem Dual',
                            yellowBg:
                                _selectedBranch == BranchCategory.chemDual,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.ecoDual;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Eco Dual',
                            yellowBg: _selectedBranch == BranchCategory.ecoDual,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        searchBook(query);
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
