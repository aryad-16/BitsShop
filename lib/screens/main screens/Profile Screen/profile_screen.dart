import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    FocusNode nameFocusNode = FocusNode();
    FocusNode emailFocusNode = FocusNode();
    FocusNode phoneNumberFocusNode = FocusNode();
    FocusNode roomNoFocusNode = FocusNode();
    TextEditingController bhawanNameController =
        TextEditingController(text: 'Shankar Bhawan');
    final List<String> _bhawanNames = [
      'Shankar Bhawan',
      'vyas Bhawan',
      'Ram Bhawan',
      'Budh Bhawan',
      'Krishna Bhawan',
      'Ghandhi Bhawan',
      'Meera Bhawan'
    ];
    _fieldFocusChange(
        BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }

    void _showModalSheet() {
      showModalBottomSheet(
        context: context,
        builder: (context) => ListView.builder(
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () {
                bhawanNameController.text = _bhawanNames[index];
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  _bhawanNames[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'ManRope Regular',
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
          itemCount: _bhawanNames.length,
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        leading: const SizedBox(),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 21,
            fontFamily: 'Poppins Medium',
            color: Color.fromRGBO(14, 20, 70, 1),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: Image.network(
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      child: buildCircle(
                        child: buildCircle(
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                          color: Colors.blue,
                          padding: 8,
                        ),
                        color: Colors.white,
                        padding: 3,
                      ),
                      bottom: 12,
                      right: 0,
                    )
                  ],
                ),
                const Divider(
                  color: Colors.black87,
                  indent: 22,
                  height: 25,
                  endIndent: 22,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    focusNode: nameFocusNode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      labelText: 'Name',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      isDense: true,
                    ),
                    onSubmitted: (_) {
                      _fieldFocusChange(context, nameFocusNode, emailFocusNode);
                    },
                    style: const TextStyle(
                      fontFamily: 'ManRope Regular',
                      fontSize: 18,
                    ),
                    controller: TextEditingController()..text = 'Arya D',
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    focusNode: emailFocusNode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      labelText: 'Email',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      isDense: true,
                    ),
                    onSubmitted: (_) {
                      _fieldFocusChange(
                          context, emailFocusNode, phoneNumberFocusNode);
                    },
                    style: const TextStyle(
                      fontFamily: 'ManRope Regular',
                      fontSize: 18,
                    ),
                    controller: TextEditingController()
                      ..text = 'f20201556@pilani.bits-pilani.ac.in',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    focusNode: phoneNumberFocusNode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      isDense: true,
                    ),
                    style: const TextStyle(
                      fontFamily: 'ManRope Regular',
                      fontSize: 18,
                    ),
                    controller: TextEditingController()..text = '8220585181',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      _fieldFocusChange(
                          context, phoneNumberFocusNode, roomNoFocusNode);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: InkWell(
                    onTap: () => _showModalSheet(),
                    child: IgnorePointer(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          disabledBorder: OutlineInputBorder(),
                          labelText: 'Bhawan',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 18, horizontal: 12),
                          isDense: true,
                        ),
                        style: const TextStyle(
                          fontFamily: 'ManRope Regular',
                          fontSize: 18,
                        ),
                        controller: bhawanNameController,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    focusNode: roomNoFocusNode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      labelText: 'Room Number',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                      isDense: true,
                    ),
                    style: const TextStyle(
                      fontFamily: 'ManRope Regular',
                      fontSize: 18,
                    ),
                    controller: TextEditingController()..text = '2140',
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCircle(
          {required Widget child,
          required Color color,
          required double padding}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(padding),
          color: color,
          child: child,
        ),
      );
}
