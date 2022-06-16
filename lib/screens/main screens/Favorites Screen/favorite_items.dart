import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../Data/data.dart';
import '../../../providers/items_provider.dart';
import '../../../providers/profiles_provider.dart';
import '../../../widgets/drawer.dart';
import '../../../widgets/search_widget.dart';
import '../Item Category Screen/items_grid_view.dart';

class FavoriteItemScreen extends StatefulWidget {
  const FavoriteItemScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteItemScreen> createState() => _FavoriteItemScreenState();
}

class _FavoriteItemScreenState extends State<FavoriteItemScreen> {
  String query = '';
  @override
  Widget build(BuildContext context) {
    final _profile = Provider.of<Profiles>(context).getProfile(profileID);
    final List<String> ids = _profile.favouriteItemsId;
    final items =
        Provider.of<Items>(context).searchYourFavoriteItems(ids, query);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Favorite Items',
          style: TextStyle(
            fontSize: 21,
            fontFamily: 'Poppins Medium',
            color: Color.fromRGBO(14, 20, 70, 1),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, right: 5),
          child: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Transform.scale(
                  scale: 0.95,
                  child: SvgPicture.asset(
                    'assets/icons/menu.svg',
                  ),
                ),
              );
            },
          ),
        ),
      ),
      drawer: DrawerWidget(profile: _profile),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              SearchWidget(
                text: query,
                hintText: 'Search Favorite Items',
                onChanged: searchBook,
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ItemsGridView(
                  items: items,
                  isEdit: false,
                ),
              ),
            ],
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
