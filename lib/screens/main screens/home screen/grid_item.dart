import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/Item%20Detail%20Screen/item_detail_screen.dart';

import '../../../model/item_model.dart';

class SingleItemWidget extends StatelessWidget {
  final Item item;

  const SingleItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ItemDetailScreen(item: item),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 150,
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
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: SvgPicture.asset(
                        'assets/icons/bookmark.svg',
                        width: 20,
                        height: 20,
                        color: const Color.fromARGB(180, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
