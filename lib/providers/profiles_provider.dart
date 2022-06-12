import 'package:flutter/cupertino.dart';

import '../model/profile_model.dart';

class Profiles with ChangeNotifier {
  final List<Profile> _profiles = [
    Profile(
      name: 'Arya D',
      profileId: 'abcd',
      bhawanName: 'Shankar Bhawan',
      rommNo: 2140,
      profilePicUrl:
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      phoneNumber: 8220585181,
      favouriteItemsId: ['1', '2'],
      theirAdIds: ['1'],
      email: 'f20200425@pilani.bits-pilani.ac.in',
    ),
    Profile(
      name: 'Prathamesh Awnekar',
      profileId: 'abce',
      bhawanName: 'Shankar Bhawan',
      rommNo: 2142,
      profilePicUrl:
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      phoneNumber: 7888209001,
      favouriteItemsId: ['2'],
      theirAdIds: ['3'],
      email: 'f20201039@pilani.bits-pilani.ac.in',
    ),
    Profile(
      name: 'Pritham Raghunath',
      profileId: 'abcf',
      bhawanName: 'Shankar Bhawan',
      rommNo: 2139,
      profilePicUrl:
          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      phoneNumber: 9756127573,
      favouriteItemsId: ['2', '3'],
      theirAdIds: ['4', '2', '1', '3', '5'],
      email: 'f20201556@pilani.bits-pilani.ac.in',
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

  void addItem(String profileId, String id) {
    final profile =
        _profiles.firstWhere((element) => element.profileId == profileId);
    profile.theirAdIds.add(id);
    notifyListeners();
  }

  void deleteItem(String profileId, String id) {
    final profile =
        _profiles.firstWhere((element) => element.profileId == profileId);
    profile.theirAdIds.removeWhere((element) => element == id);
    notifyListeners();
  }
}
