import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_singup_screen_ui/providers/item_model.dart';
import 'package:login_singup_screen_ui/providers/profiles_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Constants/constants.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

openWhatsapp(String phoneNumber) async {
  var _url = "https://api.whatsapp.com/send?phone=91";
  try {
    await launch(_url + phoneNumber);
  } catch (e) {
    print(e);
  }
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int _activeindex = 0;
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context, listen: false);
    final profile = Provider.of<Profiles>(context).getProfile(item.profileId);
    return Scaffold(
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
            color: const Color.fromRGBO(14, 20, 70, 1),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, left: 12.4),
            child: GestureDetector(
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
          ),
        ],
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: CarouselSlider.builder(
                        itemCount: item.imageList.length,
                        itemBuilder: (context, index, realindex) => ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(item.imageList[index]),
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
                      count: item.imageList.length,
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
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 15, right: 15, top: 20),
                      child: Column(
                        children: [
                          Text(
                            item.title,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(34, 26, 69, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '\u{20B9} ${item.price}',
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
                  ],
                ),
                padding: const EdgeInsets.only(top: 10),
                margin: const EdgeInsets.only(bottom: 8),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 254, 254),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 254, 254),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(8, 4), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontFamily: 'ManRope Regular',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.9,
                        color: Color.fromRGBO(34, 26, 69, 1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        item.description,
                        style: TextStyle(
                          fontFamily: 'ManRope Regular',
                          fontSize: 15,
                          color: Constant.greyColor1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 30),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 254, 254),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(8, 4), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact Details',
                      style: TextStyle(
                        fontFamily: 'ManRope Regular',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.9,
                        color: Color.fromRGBO(34, 26, 69, 1),
                      ),
                    ),
                    const SizedBox(height: 6),
                    ContactDetailsRow(
                      title1: 'Name: ',
                      title2: profile.name,
                    ),
                    ContactDetailsRow(
                      title1: 'Bhawan & Room No: ',
                      title2: '${profile.rommNo},  ${profile.bhawanName}',
                    ),
                    ContactDetailsRow(
                      title1: 'Phone No: ',
                      title2: '${profile.phoneNumber}',
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        boxShadow: [Constant.boxShadow],
                        gradient: Constant.yellowlinear,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              launchUrl(
                                  Uri.parse("tel://${profile.phoneNumber}"));
                            },
                            child: SvgPicture.asset(
                              'assets/icons/call.svg',
                              width: 35,
                              height: 35,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 20),
                          GestureDetector(
                            onTap: () =>
                                openWhatsapp(profile.phoneNumber.toString()),
                            child: SvgPicture.asset(
                              'assets/icons/whatsapp.svg',
                              width: 35,
                              height: 35,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactDetailsRow extends StatelessWidget {
  final String title1;
  final String title2;
  const ContactDetailsRow({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Text(
            title1,
            style: const TextStyle(
              fontFamily: 'ManRope Regular',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(180, 0, 0, 0),
            ),
          ),
          Text(
            title2,
            style: TextStyle(
              fontFamily: 'ManRope Regular',
              fontSize: 15,
              color: Constant.greyColor1,
            ),
          )
        ],
      ),
    );
  }
}
