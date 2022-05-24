import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_singup_screen_ui/Constants/constants.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const styleActive = TextStyle(
      fontFamily: 'manRope Regular',
      fontSize: 19,
      color: Colors.black,
    );
    final styleHint = TextStyle(
      fontFamily: 'manRope Regular',
      fontSize: 17,
      color: Constant.greyColor1,
    );
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 50,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.04),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.black45),
      ),
      padding: const EdgeInsets.only(
        left: 8,
        right: 2,
      ),
      child: TextField(
        cursorColor: Constant.yellowColor,
        textCapitalization: TextCapitalization.words,
        autofocus: true,
        controller: controller,
        decoration: InputDecoration(
          icon: SvgPicture.asset(
            'assets/icons/search.svg',
            height: 22,
          ),
          contentPadding: EdgeInsets.only(top: controller.text == '' ? 2 : 10),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Container(
                    // color: Colors.red,
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/clear_cross.svg',
                      // height: 22,
                      // width: 22,
                    ),
                  ),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
