import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Constants/constants.dart';
import '../../../providers/item_model.dart';
import 'add_photo.dart';

class NewAdScreen extends StatefulWidget {
  const NewAdScreen({Key? key}) : super(key: key);

  @override
  State<NewAdScreen> createState() => _NewAdScreenState();
}

int _activeindex = 0;
List<String> _dropDownList = ['Books', 'Cycles', 'Electronics', 'Others'];
bool _isOpened = false;
String? _selectedCategory;
TextEditingController titlecontroller = TextEditingController();
TextEditingController desccontroller = TextEditingController();
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
  Item _editeditem = Item(
    imageList: ['a', 'a', 'a', 'a', 'a'],
    title: '',
    description: '',
    price: 0,
    category: Category.books,
    id: '',
    profileId: '',
  );

  @override
  void dispose() {
    _titleFocus.dispose();
    titlecontroller.dispose();
    desccontroller.dispose();
    pricecontroller.dispose();
    _descFocus.dispose();
    _priceFocus.dispose();
    super.dispose();
  }

  void _saveForm() {
    _formkey.currentState!.save();
    print('${_editeditem.category}');
    print(_editeditem.title);
    print(_editeditem.description);
    print('${_editeditem.price}');
    print(_editeditem.imageList[0]);
    print(_editeditem.imageList[1]);
    print(_editeditem.imageList[2]);
    print(_editeditem.imageList[3]);
    print(_editeditem.imageList[4]);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _addPictures = [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AddPicture(
          imageList: _editeditem.imageList,
          context: context,
          index: 0,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AddPicture(
          imageList: _editeditem.imageList,
          context: context,
          index: 1,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AddPicture(
          imageList: _editeditem.imageList,
          context: context,
          index: 2,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AddPicture(
          imageList: _editeditem.imageList,
          context: context,
          index: 3,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AddPicture(
          imageList: _editeditem.imageList,
          context: context,
          index: 4,
        ),
      ),
    ];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: const Color.fromARGB(255, 245, 245, 245)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'New Ad',
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
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: const Color.fromARGB(255, 245, 245, 245),
                          // color: Colors.red,
                          margin: const EdgeInsets.only(left: 60, right: 60),
                          child: CarouselSlider(
                            items: _addPictures,
                            options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _activeindex = index;
                                });
                              },
                              viewportFraction: 1,
                              height: 340,
                              scrollPhysics: const BouncingScrollPhysics(),
                              enableInfiniteScroll: false,
                            ),
                          ),
                        ),
                        AnimatedSmoothIndicator(
                          activeIndex: _activeindex,
                          count: 5,
                          effect: CustomizableEffect(
                            activeDotDecoration: DotDecoration(
                              width: 22,
                              height: 3.5,
                              color: Constant.yellowColor,
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
                    padding: const EdgeInsets.only(bottom: 30),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 245, 245, 245),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                  ),
                  Container(
                    height: height - kBottomNavigationBarHeight - 260,
                    padding: const EdgeInsets.only(top: 20),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            width: width - 50,
                            height: 65,
                            child: AwesomeDropDown(
                              dropStateChanged: (isOpened) {
                                setState(() {
                                  _isOpened = isOpened;
                                });
                              },
                              selectedItem: _selectedCategory ?? 'Category',
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
                                    : Icons.keyboard_arrow_down_outlined,
                                color: Colors.white,
                                size: 28,
                              ),
                              elevation: 6,
                              dropDownBGColor:
                                  const Color.fromRGBO(247, 154, 0, 1),
                              numOfListItemToShow: 4,
                              onDropDownItemClick: (selectedItem) {
                                _selectedCategory = selectedItem;
                                _editeditem = Item(
                                  title: _editeditem.title,
                                  description: _editeditem.description,
                                  price: _editeditem.price,
                                  category: selectedItem == 'Books'
                                      ? Category.books
                                      : selectedItem == 'Cycles'
                                          ? Category.cycles
                                          : selectedItem == 'Electronics'
                                              ? Category.electronics
                                              : Category.others,
                                  profileId: _editeditem.profileId,
                                  imageList: _editeditem.imageList,
                                  id: _editeditem.id,
                                );
                              },
                            ),
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
                              onFieldSubmitted: (_) {
                                _fieldFocusChange(
                                    context, _titleFocus, _descFocus);
                              },
                              onSaved: (value) {
                                _editeditem = Item(
                                  title: value!,
                                  description: _editeditem.description,
                                  price: _editeditem.price,
                                  category: _editeditem.category,
                                  profileId: _editeditem.profileId,
                                  imageList: _editeditem.imageList,
                                  id: _editeditem.id,
                                );
                              },
                              cursorColor: Constant.yellowColor,
                              decoration: const InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(bottom: -10.0, left: 12),
                                hintText: 'Advertisement Title',
                                hintStyle: TextStyle(
                                  fontFamily: 'ManRope Regular',
                                  fontSize: 22,
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(0, 0, 0, 0.25),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(
                                        27, 27, 27, 1), // or (247, 154, 0, 1)
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
                              onFieldSubmitted: (_) {
                                _fieldFocusChange(
                                    context, _descFocus, _priceFocus);
                              },
                              onSaved: (value) {
                                _editeditem = Item(
                                  title: _editeditem.title,
                                  description: value!,
                                  price: _editeditem.price,
                                  category: _editeditem.category,
                                  profileId: _editeditem.profileId,
                                  imageList: _editeditem.imageList,
                                  id: _editeditem.id,
                                );
                              },
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Field cannot be empty";
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 20, left: 12, right: 12),
                                hintText: 'Description',
                                hintStyle: TextStyle(
                                  fontFamily: 'ManRope Regular',
                                  fontSize: 22,
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                ),
                                filled: true,
                                fillColor: Color.fromRGBO(242, 242, 242, 1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
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
                                    cursorHeight: 28,
                                    focusNode: _priceFocus,
                                    textInputAction: TextInputAction.done,
                                    controller: pricecontroller,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Field cannot be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onFieldSubmitted: (_) {
                                      _priceFocus.unfocus();
                                    },
                                    onSaved: (value) {
                                      _editeditem = Item(
                                        title: _editeditem.title,
                                        description: _editeditem.description,
                                        price: int.parse(value!),
                                        category: _editeditem.category,
                                        profileId: _editeditem.profileId,
                                        imageList: _editeditem.imageList,
                                        id: _editeditem.id,
                                      );
                                    },
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontFamily: 'ManRope Regular',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                      color: Color.fromRGBO(27, 27, 27, 1),
                                    ),
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Colors.black.withOpacity(0.9),
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Colors.black.withOpacity(0.9),
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.only(bottom: 4),
                                    ),
                                  ),
                                  width: 78,
                                ),
                                const Text(
                                  '/per day',
                                  style: TextStyle(
                                    fontFamily: 'ManRope Regular',
                                    fontSize: 19,
                                  ),
                                )
                              ],
                            ),
                          ),
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
                                      title: const Text('Error'),
                                      content:
                                          const Text("Category can't be empty"),
                                      actions: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            margin: const EdgeInsets.only(
                                                right: 10, bottom: 5),
                                            child: const Text(
                                              'Ok',
                                              style: TextStyle(
                                                fontFamily: 'ManRope Regular',
                                                fontSize: 19,
                                                color: Colors.white,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              boxShadow: [Constant.boxShadow],
                                              gradient: Constant.yellowlinear,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (_formkey.currentState!.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content:
                                          const Text("Ad posted succesfully!"),
                                      actions: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 10),
                                            margin: const EdgeInsets.only(
                                                right: 10, bottom: 5),
                                            child: const Text(
                                              'Ok',
                                              style: TextStyle(
                                                fontFamily: 'ManRope Regular',
                                                fontSize: 19,
                                                color: Colors.white,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                10,
                                              ),
                                              boxShadow: [Constant.boxShadow],
                                              gradient: Constant.yellowlinear,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                  _saveForm();
                                  // item.title = titlecontroller.text;
                                  // item.description = desccontroller.text;
                                  // item.category = _selectedCategory == 'Books'
                                  //     ? Category.books
                                  //     : _selectedCategory == 'Cycles'
                                  //         ? Category.cycles
                                  //         : _selectedCategory == 'Electronics'
                                  //             ? Category.electronics
                                  //             : Category.others;
                                  // item.price = int.parse(pricecontroller.text);
                                  // print('${item.category}');
                                  // print(item.title);
                                  // print(item.description);
                                  // print('${item.price}');
                                  // print(item.imageList[0]);
                                  // print(item.imageList[1]);
                                  // print(item.imageList[2]);
                                  // print(item.imageList[3]);
                                  // print(item.imageList[4]);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [Constant.boxShadow],
                                  gradient: Constant.yellowlinear,
                                  borderRadius: BorderRadius.circular(25),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
