import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/item_model.dart';
import '../home screen/grid_item.dart';

class ItemsGridView extends StatelessWidget {
  final bool isEdit;
  final List<Item> items;
  const ItemsGridView({
    Key? key,
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
                  child: SingleItemWidget(item: items[index],
                    isEdit: isEdit,
                  ),
                ),
                itemCount: items.length,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
