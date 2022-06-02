import 'package:flutter/cupertino.dart';

import '../model/profile_model.dart';

class Profiles with ChangeNotifier {
  final List<Profile> _profiles = [
    Profile(
      name: 'Arya D',
      profileId: 'abcd',
      bhawanName: 'Shankar Bhawan',
      rommNo: 2140,
      phoneNumber: 8220585181,
    ),
    Profile(
      name: 'Prathamesh Awnekar',
      profileId: 'abce',
      bhawanName: 'Shankar Bhawan',
      rommNo: 2142,
      phoneNumber: 9856781255,
    ),
    Profile(
      name: 'Pritham Raghunath',
      profileId: 'abcf',
      bhawanName: 'Shankar Bhawan',
      rommNo: 2139,
      phoneNumber: 9756127573,
    ),
  ];
  List<Profile> get bookitems {
    return [
      ..._profiles
    ]; //returns a copy of the list, so as to not edit it anywhere else in the app
  }
}
