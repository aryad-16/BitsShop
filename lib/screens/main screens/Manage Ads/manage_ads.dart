import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_singup_screen_ui/data/data.dart';
import 'package:login_singup_screen_ui/providers/profiles_provider.dart';
import 'package:provider/provider.dart';

import '../../../providers/items_provider.dart';
import '../Item Category Screen/items_grid_view.dart';

class ManageAds extends StatelessWidget {
  const ManageAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ids = Provider.of<Profiles>(context).getProfile(profileID).theirAdIds;
    final items = Provider.of<Items>(context).getItems(ids);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: const Text(
          'Manage Ads',
          style: TextStyle(
            fontSize: 21,
            fontFamily: 'Poppins Medium',
            color: Color.fromRGBO(14, 20, 70, 1),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        leading: const SizedBox(),
      ),
      body: ItemsGridView(
          category: 'ads', items: items, isEdit: true, searchInclude: true),
    );
  }
}
