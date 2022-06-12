import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_singup_screen_ui/Constants/tags_dialog.dart';
import 'package:login_singup_screen_ui/widgets/search_widget.dart';
import 'package:provider/provider.dart';

import '../../../Data/data.dart';
import '../../../providers/items_provider.dart';
import '../../../providers/profiles_provider.dart';
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
            widget.category == 'Books'
                ? GestureDetector(
                    onTap: () => showNewDialog(
                        context,
                        'Filters',
                        'Refine Search',
                        _controller,
                        _animation,
                        _setState,
                        _selectedYear,
                        _selectedSem,
                        _selectedBranch),
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
}
