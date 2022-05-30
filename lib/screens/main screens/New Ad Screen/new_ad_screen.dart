import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Constants/constants.dart';
import 'add_photo.dart';
import 'custom_bg_painter.dart';

class NewAdScreen extends StatefulWidget {
  const NewAdScreen({Key? key}) : super(key: key);

  @override
  State<NewAdScreen> createState() => _NewAdScreenState();
}

List<String> _dropDownList = ['Books', 'Cycles', 'Electronics', 'Others'];
bool _isOpened = false;
String? _selectedCategory;
TextEditingController titlecontroller = TextEditingController();
TextEditingController desccontroller = TextEditingController();
TextEditingController conditioncontroller = TextEditingController();
TextEditingController pricecontroller = TextEditingController();
final FocusNode _titleFocus = FocusNode();
final FocusNode _descFocus = FocusNode();
final FocusNode _priceFocus = FocusNode();
var _formkey = GlobalKey<FormState>();
_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

class _NewAdScreenState extends State<NewAdScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: const Color.fromARGB(255, 245, 245, 245)),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 260,
                      // width: 240,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: width * 0.23,
                            ),
                            AddPicture(
                              context: context,
                            ),
                            AddPicture(
                              context: context,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height - kBottomNavigationBarHeight - 220,
                      child: Stack(
                        children: <Widget>[
                          CustomPaint(
                            size: Size(width, height),
                            painter: CustomBgPainter(),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 50),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 25, right: 25),
                                    width: width - 50,
                                    height: 65,
                                    child: AwesomeDropDown(
                                        dropStateChanged: (isOpened) {
                                          setState(() {
                                            _isOpened = isOpened;
                                          });
                                        },
                                        selectedItem:
                                            _selectedCategory ?? 'Category',
                                        dropDownBorderRadius: 0,
                                        dropDownTopBorderRadius: 10,
                                        dropDownBottomBorderRadius: 10,
                                        selectedItemTextStyle: const TextStyle(
                                          fontFamily: 'ManRope Regular',
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                        dropDownList: _dropDownList,
                                        dropDownListTextStyle: const TextStyle(
                                          fontFamily: 'ManRope Regular',
                                          color: Color.fromRGBO(34, 26, 69, 1),
                                          fontSize: 18,
                                          backgroundColor: Colors.transparent,
                                        ),
                                        padding: 10,
                                        dropDownIcon: Icon(
                                          _isOpened // Create a switching animation here, looks very weird
                                              ? Icons.keyboard_arrow_up_outlined
                                              : Icons
                                                  .keyboard_arrow_down_outlined,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        elevation: 6,
                                        dropDownBGColor: const Color.fromRGBO(
                                            247, 154, 0, 1),
                                        numOfListItemToShow: 4,
                                        onDropDownItemClick: (selectedItem) {
                                          _selectedCategory = selectedItem;
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 40, right: 40),
                                    child: TextFormField(
                                      focusNode: _titleFocus,
                                      controller: titlecontroller,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.text,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return "Field cannot be empty";
                                        } else {
                                          return null;
                                        }
                                      },
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(
                                            context, _titleFocus, _descFocus);
                                      },
                                      cursorColor: Constant.yellowColor,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom: -10.0, left: 12),
                                        hintText: 'Advertisement Title',
                                        hintStyle: TextStyle(
                                          fontFamily: 'ManRope Regular',
                                          fontSize: 22,
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                        ),
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.25),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color.fromRGBO(27, 27, 27,
                                                1), // or (247, 154, 0, 1)
                                          ),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'ManRope Regular',
                                        fontSize: 22,
                                        color: Color.fromRGBO(27, 27, 27, 1),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 28, left: 40, right: 40),
                                    child: TextFormField(
                                      focusNode: _descFocus,
                                      cursorColor: Constant.yellowColor,
                                      controller: desccontroller,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.multiline,
                                      // expands: true,
                                      minLines: 5,
                                      maxLines: 6,
                                      style: const TextStyle(
                                        fontFamily: 'ManRope Regular',
                                        fontSize: 22,
                                        color: Color.fromRGBO(27, 27, 27, 1),
                                      ),
                                      maxLength: 400,
                                      onFieldSubmitted: (term) {
                                        _fieldFocusChange(
                                            context, _descFocus, _priceFocus);
                                      },
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 20, left: 12, right: 12),
                                        hintText: 'Product Description',
                                        hintStyle: TextStyle(
                                          fontFamily: 'ManRope Regular',
                                          fontSize: 22,
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                        ),
                                        filled: true,
                                        fillColor:
                                            Color.fromRGBO(242, 242, 242, 1),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(6),
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       top: 5, left: 40, right: 40),
                                  //   child: TextFormField(
                                  //     focusNode: _conditionFocus,
                                  //     controller: conditioncontroller,
                                  //     maxLength: 100,
                                  //     textInputAction: TextInputAction.next,
                                  //     keyboardType: TextInputType.text,
                                  //     validator: (val) {
                                  //       if (val!.isEmpty) {
                                  //         return "Field cannot be empty";
                                  //       } else {
                                  //         return null;
                                  //       }
                                  //     },
                                  //     onFieldSubmitted: (term) {
                                  //       _fieldFocusChange(context,
                                  //           _conditionFocus, _priceFocus);
                                  //     },
                                  //     decoration: const InputDecoration(
                                  //       contentPadding: EdgeInsets.only(
                                  //           bottom: -10.0, left: 12),
                                  //       hintText: 'Condition',
                                  //       hintStyle: TextStyle(
                                  //         fontFamily: 'Avenir',
                                  //         fontSize: 22,
                                  //         color: Color.fromRGBO(0, 0, 0, 0.25),
                                  //       ),
                                  //       border: UnderlineInputBorder(
                                  //         borderSide: BorderSide(
                                  //           color: Color.fromRGBO(0, 0, 0, 0.25),
                                  //         ),
                                  //       ),
                                  //       focusedBorder: UnderlineInputBorder(
                                  //         borderSide: BorderSide(
                                  //           color: Color.fromRGBO(27, 27, 27,
                                  //               1), // or (247, 154, 0, 1)
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     style: const TextStyle(
                                  //       fontFamily: 'Avenir',
                                  //       fontSize: 22,
                                  //       color: Color.fromRGBO(27, 27, 27, 1),
                                  //     ),
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 40, right: 40),
                                    child: Row(
                                      children: <Widget>[
                                        const Text(
                                          'Expected Price',
                                          style: TextStyle(
                                            fontFamily: 'ManRope Regular',
                                            color: Colors.black,
                                            fontSize: 20,
                                            letterSpacing: 0.1,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const Expanded(
                                          child: SizedBox(),
                                        ),
                                        Container(
                                          height: 35,
                                          margin: const EdgeInsets.only(
                                              bottom: 10, right: 8),
                                          child: TextFormField(
                                            cursorColor: Constant.yellowColor,
                                            cursorHeight: 10,
                                            focusNode: _priceFocus,
                                            textInputAction:
                                                TextInputAction.done,
                                            controller: pricecontroller,
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return "Field cannot be empty";
                                              } else {
                                                return null;
                                              }
                                            },
                                            onFieldSubmitted: (term) {
                                              _priceFocus.unfocus();
                                            },
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontFamily: 'ManRope Regular',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22,
                                              color:
                                                  Color.fromRGBO(27, 27, 27, 1),
                                            ),
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 2,
                                                  color: Colors.black
                                                      .withOpacity(0.9),
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 2,
                                                  color: Colors.black
                                                      .withOpacity(0.9),
                                                  style: BorderStyle.solid,
                                                ),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 4),
                                            ),
                                          ),
                                          width: 78,
                                        ),
                                        const Text(
                                          '/per day',
                                          style: TextStyle(
                                              fontFamily: 'ManRope Regular',
                                              fontSize: 19),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 25, right: 25, top: 25),
                                  //   child: Row(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceAround,
                                  //     crossAxisAlignment: CrossAxisAlignment.end,
                                  //     children: <Widget>[
                                  //       Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.center,
                                  //         children: <Widget>[
                                  //           const Text(
                                  //             'From',
                                  //             style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontSize: 20,
                                  //               letterSpacing: 0.1,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           ),
                                  //           const SizedBox(
                                  //             height: 8,
                                  //           ),
                                  //           Container(
                                  //             height: 30,
                                  //             // width: 65,
                                  //             child: const Text(
                                  //               "24 Nov'21",
                                  //               style: TextStyle(
                                  //                 color: Color.fromRGBO(
                                  //                     247, 154, 0, 1),
                                  //                 fontSize: 22,
                                  //                 letterSpacing: 0.1,
                                  //                 fontFamily: 'Avenir',
                                  //                 fontWeight: FontWeight.w400,
                                  //               ),
                                  //             ),
                                  //             decoration: const BoxDecoration(
                                  //               border: Border(
                                  //                 bottom: BorderSide(
                                  //                   width: 3,
                                  //                   color: Colors.black,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       const Icon(
                                  //         Icons.arrow_right_alt_outlined,
                                  //         size: 38,
                                  //       ),
                                  //       Column(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.center,
                                  //         children: <Widget>[
                                  //           const Text(
                                  //             'To',
                                  //             style: TextStyle(
                                  //               color: Colors.black,
                                  //               fontSize: 20,
                                  //               letterSpacing: 0.1,
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           ),
                                  //           const SizedBox(
                                  //             height: 8,
                                  //           ),
                                  //           Container(
                                  //             height: 30,
                                  //             // width: 65,
                                  //             child: const Text(
                                  //               "28 Nov'21",
                                  //               style: TextStyle(
                                  //                 color: Color.fromRGBO(
                                  //                     247, 154, 0, 1),
                                  //                 fontSize: 22,
                                  //                 letterSpacing: 0.1,
                                  //                 fontFamily: 'Avenir',
                                  //                 fontWeight: FontWeight.w400,
                                  //               ),
                                  //             ),
                                  //             decoration: const BoxDecoration(
                                  //               border: Border(
                                  //                 bottom: BorderSide(
                                  //                   width: 3,
                                  //                   color: Colors.black,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 30,
                                      left: 25,
                                      right: 25,
                                      bottom: 25,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        FocusScope.of(context).unfocus();
                                        if (_selectedCategory == null) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Alert'),
                                              content: const Text(
                                                  "Category can't be empty"),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Ok"),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else if (_formkey.currentState!
                                            .validate()) {
                                          // add the post for moderation
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [Constant.boxShadow],
                                          gradient: Constant.yellowlinear,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18, vertical: 14),
                                        child: const Text(
                                          'Post Ad',
                                          style: TextStyle(
                                            fontFamily: 'ManRope Regular',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.9,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
