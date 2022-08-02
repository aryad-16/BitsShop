import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:login_singup_screen_ui/data/data.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/Item%20Detail%20Screen/item_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../../providers/item_model.dart';
import '../../../providers/items_provider.dart';
import '../../../providers/profiles_provider.dart';
import '../Edit Screen/edit_screen.dart';

class SingleItemWidget extends StatelessWidget {
  final item;
  final bool isEdit;
  const SingleItemWidget({
    Key? key,
    required this.isEdit,required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: null,
      child: Container(
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
                margin: EdgeInsets.only(top: isEdit ? 6 : 0),
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
                      color: Constant.yellowColor,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      item.toggleFavouriteStatus();
                      if (item.isFavourite) {
                        Provider.of<Profiles>(context, listen: false)
                            .addFavouriteItem(profileID, item.id);
                      } else {
                        Provider.of<Profiles>(context, listen: false)
                            .deleteFavouriteItem(profileID, item.id);
                      }
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
                  ? SizedBox(
                      height: 40,
                      child: Row(
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
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  insetPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Color.fromRGBO(237, 92, 90, 1),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Row(
                                          children: <Widget>[
                                            const Spacer(flex: 1),
                                            const Text(
                                              'Confirm',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const Spacer(flex: 10),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: const Icon(
                                                Icons.close_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 30),
                                        child: Row(
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              'assets/icons/cancel_sign.svg',
                                              width: 40,
                                              color: const Color.fromRGBO(
                                                  237, 92, 90, 1),
                                            ),
                                            const SizedBox(width: 20),
                                            Flexible(
                                              child: Text(
                                                'Are you sure you want to delete this item?',
                                                style: TextStyle(
                                                  color: Constant.greyColor1,
                                                ),
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7, horizontal: 12),
                                        margin:
                                            const EdgeInsets.only(bottom: 12),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Constant.greyColor1,
                                          ),
                                        ),
                                        child: Text(
                                          'NO',
                                          style: TextStyle(
                                            color: Constant.greyColor1,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Provider.of<Items>(context,
                                                listen: false)
                                            .deleteItem(item.id);
                                        Provider.of<Profiles>(context,
                                                listen: false)
                                            .deleteItem(profileID, item.id);
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7, horizontal: 28),
                                        margin: const EdgeInsets.only(
                                            bottom: 12, right: 12),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color.fromRGBO(
                                                237, 92, 90, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromRGBO(
                                              237, 92, 90, 1),
                                        ),
                                        child: const Text(
                                          'YES',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(Icons.delete_forever_rounded),
                            color: const Color.fromRGBO(237, 92, 90, 1),
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
