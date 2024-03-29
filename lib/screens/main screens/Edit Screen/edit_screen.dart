import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../Constants/constants.dart';
import '../../../data/data.dart';
import '../../../providers/item_model.dart';
import '../../../providers/items_provider.dart';
import '../../../widgets/add_photo.dart';
import '../../../widgets/error_snackbar.dart';
import '../../../widgets/rounded_containers.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);
  static const routeName = '/edit-item';
  @override
  State<EditScreen> createState() => EditScreenState();
}

int _activeindex = 0;
List<String> _dropDownList = ['Books', 'Cycles', 'Electronics', 'Others'];
bool _isOpened = false;
String? _selectedCategory;
final FocusNode _titleFocus = FocusNode();
final FocusNode _descFocus = FocusNode();
final FocusNode _priceFocus = FocusNode();
_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

class EditScreenState extends State<EditScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  StateSetter? _setState;
  YearCategory? _selectedYear;
  SemesterCategory? _selectedSem;
  BranchCategory? _selectedBranch;
  bool _isinit = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Item _editeditem = Item(
    imageList: ['a', 'a', 'a', 'a', 'a'],
    title: '',
    description: '',
    price: 0,
    category: ItemCategory.books,
    id: '',
    profileId: profileID,
  );

  @override
  void didChangeDependencies() {
    if (_isinit) {
      final item = ModalRoute.of(context)!.settings.arguments as Item;
      _editeditem = item;
      _selectedCategory = toBeginningOfSentenceCase(
          _editeditem.category.toString().substring(9));
      _selectedBranch = item.branch;
      _selectedSem = item.sem;
      _selectedYear = item.year;
      for (int i = _editeditem.imageList.length; i < 5; i++) {
        _editeditem.imageList.add('a');
      }
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  void _saveForm() {
    _formkey.currentState!.save();
    _editeditem = Item(
      year: _selectedYear,
      branch: _selectedBranch,
      sem: _selectedSem,
      title: _editeditem.title,
      description: _editeditem.description,
      price: _editeditem.price,
      category: _editeditem.category,
      profileId: _editeditem.profileId,
      imageList: _editeditem.imageList,
      id: _editeditem.id,
    );
    Provider.of<Items>(context, listen: false)
        .updateitem(_editeditem.id, _editeditem);
    _formkey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _addPictures = [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AddPicture(
          isEdit: true,
          imageList: _editeditem.imageList,
          context: context,
          index: 0,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AddPicture(
          isEdit: true,
          imageList: _editeditem.imageList,
          context: context,
          index: 1,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AddPicture(
          isEdit: true,
          imageList: _editeditem.imageList,
          context: context,
          index: 2,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AddPicture(
          isEdit: true,
          imageList: _editeditem.imageList,
          context: context,
          index: 3,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AddPicture(
          isEdit: true,
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
            'Edit Ad',
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
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color.fromRGBO(14, 20, 70, 1),
            ),
          ),
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
                    height: _selectedCategory == 'Books'
                        ? (height - kBottomNavigationBarHeight - 220)
                        : (height - kBottomNavigationBarHeight - 260),
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
                              selectedItem: _selectedCategory ??
                                  '${_editeditem.category.toString().substring(9).capitalize}',
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
                                selectedItem == 'Books'
                                    ? _showTagsDialog(context)
                                    : null;
                                _selectedCategory = selectedItem;
                                _editeditem = Item(
                                  title: _editeditem.title,
                                  description: _editeditem.description,
                                  price: _editeditem.price,
                                  category: selectedItem == 'Books'
                                      ? ItemCategory.books
                                      : selectedItem == 'Cycles'
                                          ? ItemCategory.cycles
                                          : selectedItem == 'Electronics'
                                              ? ItemCategory.electronics
                                              : ItemCategory.others,
                                  profileId: _editeditem.profileId,
                                  imageList: _editeditem.imageList,
                                  id: _editeditem.id,
                                );
                              },
                            ),
                          ),
                          _selectedCategory == 'Books'
                              ? GestureDetector(
                                  onTap: () => _showTagsDialog(context),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 5),
                                    margin: const EdgeInsets.only(top: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Constant.yellowColor,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      'Add Tags',
                                      style: TextStyle(
                                        fontFamily: 'ManRope Regular',
                                        fontSize: 20,
                                        letterSpacing: 0.9,
                                        color: Constant.yellowColor,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          Padding(
                            padding: EdgeInsets.only(
                              top: _selectedCategory == 'Books' ? 0 : 12,
                              left: 40,
                              right: 40,
                            ),
                            child: TextFormField(
                              focusNode: _titleFocus,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              initialValue: _editeditem.title,
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
                                  year: _editeditem.year,
                                  branch: _editeditem.branch,
                                  sem: _editeditem.sem,
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
                              // controller: desccontroller,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.multiline,
                              textCapitalization: TextCapitalization.sentences,
                              initialValue: _editeditem.description,
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
                                  year: _editeditem.year,
                                  branch: _editeditem.branch,
                                  sem: _editeditem.sem,
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Price',
                                  style: TextStyle(
                                    fontFamily: 'ManRope Regular',
                                    color: Colors.black,
                                    fontSize: 20,
                                    letterSpacing: 0.1,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
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
                                    // controller: pricecontroller,
                                    initialValue: _editeditem.price.toString(),
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
                                        year: _editeditem.year,
                                        branch: _editeditem.branch,
                                        sem: _editeditem.sem,
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
                                if (_editeditem.imageList[0] == 'a') {
                                  errorSnackbar(context, "Add Atleast 1 image");
                                } else if (_formkey.currentState!.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content:
                                          const Text("Ad edited succesfully!"),
                                      actions: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            Navigator.pop(context);
                                            _saveForm();
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
                                  'Edit Ad',
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

  Future<dynamic> _showTagsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          _controller.forward();
          return FadeTransition(
            opacity: _animation,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                _setState = setState;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Tags',
                          style: TextStyle(
                            fontFamily: 'manRope Regular',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              _setState!(() {
                                _selectedBranch = null;
                                _selectedSem = null;
                                _selectedYear = null;
                              });
                            },
                            child: const RoundedContainer(
                              title: 'Reset',
                              yellowBg: false,
                            )),
                      ],
                    ),
                    const Divider(
                      color: Colors.black87,
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        'YEAR',
                        style: TextStyle(
                          fontFamily: 'manRope Regular',
                          fontSize: 16,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Wrap(
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      runSpacing: 6,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = YearCategory.first;
                            });
                          },
                          child: RoundedContainer(
                            title: '1st Year',
                            yellowBg: _selectedYear == YearCategory.first,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = YearCategory.second;
                            });
                          },
                          child: RoundedContainer(
                            title: '2nd Year',
                            yellowBg: _selectedYear == YearCategory.second,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = YearCategory.third;
                            });
                          },
                          child: RoundedContainer(
                            title: '3rd Year',
                            yellowBg: _selectedYear == YearCategory.third,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = YearCategory.fourth;
                            });
                          },
                          child: RoundedContainer(
                            title: '4th Year',
                            yellowBg: _selectedYear == YearCategory.fourth,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedYear = YearCategory.fifth;
                            });
                          },
                          child: RoundedContainer(
                            title: '5th Year',
                            yellowBg: _selectedYear == YearCategory.fifth,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'SEMESTER',
                        style: TextStyle(
                          fontFamily: 'manRope Regular',
                          fontSize: 16,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Wrap(
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      runSpacing: 6,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _setState!(() {
                                _selectedSem = SemesterCategory.first;
                              });
                            },
                            child: RoundedContainer(
                              title: '1st Semester',
                              yellowBg: _selectedSem == SemesterCategory.first,
                            )),
                        const SizedBox(width: 10),
                        GestureDetector(
                            onTap: () {
                              _setState!(() {
                                _selectedSem = SemesterCategory.second;
                              });
                            },
                            child: RoundedContainer(
                              title: '2nd Semester',
                              yellowBg: _selectedSem == SemesterCategory.second,
                            )),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'BRANCH',
                        style: TextStyle(
                          fontFamily: 'manRope Regular',
                          fontSize: 16,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Wrap(
                      alignment: WrapAlignment.start,
                      direction: Axis.horizontal,
                      runSpacing: 6,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.eni;
                            });
                          },
                          child: RoundedContainer(
                              title: 'ENI',
                              yellowBg: _selectedBranch == BranchCategory.eni),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.ece;
                            });
                          },
                          child: RoundedContainer(
                            title: 'ECE',
                            yellowBg: _selectedBranch == BranchCategory.ece,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.eee;
                            });
                          },
                          child: RoundedContainer(
                            title: 'EEE',
                            yellowBg: _selectedBranch == BranchCategory.eee,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.cs;
                            });
                          },
                          child: RoundedContainer(
                            title: 'CS',
                            yellowBg: _selectedBranch == BranchCategory.cs,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.chemical;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Chemical',
                            yellowBg:
                                _selectedBranch == BranchCategory.chemical,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.manufacturing;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Manufacturing',
                            yellowBg:
                                _selectedBranch == BranchCategory.manufacturing,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.civil;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Civil',
                            yellowBg: _selectedBranch == BranchCategory.civil,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.bioDual;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Bio Dual',
                            yellowBg: _selectedBranch == BranchCategory.bioDual,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.phyDual;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Phy Dual',
                            yellowBg: _selectedBranch == BranchCategory.phyDual,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.chemDual;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Chem Dual',
                            yellowBg:
                                _selectedBranch == BranchCategory.chemDual,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            _setState!(() {
                              _selectedBranch = BranchCategory.ecoDual;
                            });
                          },
                          child: RoundedContainer(
                            title: 'Eco Dual',
                            yellowBg: _selectedBranch == BranchCategory.ecoDual,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [Constant.boxShadow],
                            gradient: Constant.yellowlinear,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 14),
                          margin: const EdgeInsets.only(top: 28),
                          child: const Text(
                            'Add Tags',
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
                    )
                  ],
                );
              }),
            ),
          );
        });
  }
}
