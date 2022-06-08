import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/Item%20Detail%20Screen/item_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../../providers/item_model.dart';
import '../Edit Screen/edit_screen.dart';

class SingleItemWidget extends StatelessWidget {
  final bool isEdit;
  const SingleItemWidget({
    Key? key,
    required this.isEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context, listen: false);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider.value(
            value: item,
            child: const ItemDetailScreen(),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(bottom: isEdit ? 0 : 10, top: isEdit ? 0 : 10),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 200,
        child: Card(
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          shadowColor: Colors.grey.withOpacity(0.25),
          elevation: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 170,
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    item.imageList[0],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AutoSizeText(
                  item.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  minFontSize: 14,
                  style: const TextStyle(
                    fontFamily: 'ManRope Regular',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                    color: Color.fromRGBO(14, 20, 70, 1),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  AutoSizeText(
                    '\u{20B9} ${item.price}',
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Poppins Medium',
                      // fontWeight: FontWeight.bold,
                      color: Constant.yellowColor,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      item.toggleFavouriteStatus();
                    },
                    child: Consumer<Item>(
                      builder: (context, item, _) => Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(
                          item.isFavourite
                              ? Icons.bookmark_added_rounded
                              : Icons.bookmark_add_outlined,
                          size: 24,
                          color: const Color.fromARGB(180, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              isEdit
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              EditScreen.routeName,
                              arguments: item,
                            );
                          },
                          icon: const Icon(Icons.edit_rounded),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete_forever_rounded),
                          color: Colors.red,
                        )
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
