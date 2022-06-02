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
      favouriteItemsId: ['1', '2'],
      theirAdIds: ['1'],
    ),
    Profile(
      name: 'Prathamesh Awnekar',
      profileId: 'abce',
      bhawanName: 'Shankar Bhawan',
      rommNo: 2142,
      phoneNumber: 9856781255,
      favouriteItemsId: ['2'],
      theirAdIds: ['3'],
    ),
    Profile(
      name: 'Pritham Raghunath',
      profileId: 'abcf',
      bhawanName: 'Shankar Bhawan',
      rommNo: 2139,
      phoneNumber: 9756127573,
      favouriteItemsId: ['2', '3'],
      theirAdIds: ['4', '2', '1', '3'],
    ),
  ];
  Profile getProfile(String profileId) {
    return _profiles.firstWhere((element) => element.profileId == profileId);
  }

  List<String> getFavouriteItems(String profileId) {
    return _profiles
        .firstWhere((element) => element.profileId == profileId)
        .favouriteItemsId;
  }
}
