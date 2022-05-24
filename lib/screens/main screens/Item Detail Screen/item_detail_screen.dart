import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Constants/constants.dart';

class ItemDetailScreen extends StatefulWidget {
  final String title;
  final String imageURL;
  const ItemDetailScreen(
      {Key? key, required this.title, required this.imageURL})
      : super(key: key);

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int _activeindex = 0;
  @override
  Widget build(BuildContext context) {
    final imagelist = [
      'https://apollo-singapore.akamaized.net/v1/files/ezsysftziv8v-IN/image;s=272x0',
      'https://apollo-singapore.akamaized.net/v1/files/b0n1994mmf4y2-IN/image;s=272x0',
      'https://apollo-singapore.akamaized.net/v1/files/ryg7fvp9ft8b1-IN/image;s=272x0',
    ];
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 247, 246, 247),
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 6, top: 5),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 26,
            ),
            onPressed: () => Navigator.of(context).pop(),
            color: const Color.fromARGB(180, 0, 0, 0),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, left: 12.4),
            // width: 23,
            child: SvgPicture.asset(
              'assets/icons/bookmark.svg',
              width: 26,
              height: 26,
              color: const Color.fromARGB(180, 0, 0, 0),
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(
                            widget.title,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(34, 26, 69, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '\u{20B9} ${4500}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Constant.yellowColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      // color: Colors.red,
                      // width: double.infinity - 80,
                      child: CarouselSlider.builder(
                        itemCount: imagelist.length,
                        itemBuilder: (context, index, realindex) => Container(
                          // color: Colors.red,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(imagelist[index]),
                          ),
                        ),
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              _activeindex = index;
                            });
                          },
                          height: 300,
                          viewportFraction: 1,
                          enableInfiniteScroll: false,
                        ),
                      ),
                    ),
                    AnimatedSmoothIndicator(
                      activeIndex: _activeindex,
                      count: imagelist.length,
                      effect: CustomizableEffect(
                        activeDotDecoration: DotDecoration(
                          width: 22,
                          height: 3.5,
                          color: const Color.fromRGBO(247, 154, 0, 1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        dotDecoration: DotDecoration(
                          width: 10,
                          height: 3.5,
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(16),
                          verticalOffset: 0,
                        ),
                        spacing: 6.0,
                      ),
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(bottom: 25),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 254, 254),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
