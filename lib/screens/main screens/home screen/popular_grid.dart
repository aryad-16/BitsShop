import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';
import 'package:login_singup_screen_ui/screens/main%20screens/Item%20Detail%20Screen/item_detail_screen.dart';

Widget singleItemWidget(int index, BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ItemDetailScreen(
          title: 'Differential equations by Edwin Garold 12th edition',
          imageURL:
              'https://images-na.ssl-images-amazon.com/images/I/919N4Tj2qRL.jpg',
        ),
      ),
    ),
    child: Container(
      padding: const EdgeInsets.only(bottom: 10),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 150,
      width: 200,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  index % 4 == 0
                      ? 'https://5.imimg.com/data5/ES/XX/ED/SELLER-66915681/bmw-power-black-mtb-cycle-500x500.jpg'
                      : index % 4 == 1
                          ? 'https://images-na.ssl-images-amazon.com/images/I/919N4Tj2qRL.jpg'
                          : index % 4 == 2
                              ? 'https://www.reliancedigital.in/medias/Reconnect-RHTRG0001-Trimmer-491332808-i-2-1200Wx1200H-300Wx300H?context=bWFzdGVyfGltYWdlc3w0NTIyMXxpbWFnZS9qcGVnfGltYWdlcy9oM2IvaDZjLzkzMjY5NDU0MzU2NzguanBnfGM5YmNlZWIxYTgyMzA5ZTVhY2VlYWYzY2EyNTU2YmZmZDkwMGJlNTlhOGRkZGYwOGM3YTI3NzYxYWUxMWQ5MmQ'
                              : 'https://static.toiimg.com/photo/msid-82706812/82706812.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: AutoSizeText(
                'Differential equations by Edwin Garold 12th edition',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                minFontSize: 14,
                style: TextStyle(
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
                  '\u{20B9} ${4500}',
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
