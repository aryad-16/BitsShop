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
      favouriteItemsId: [],
      theirAdIds: [],
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
      favouriteItemsId: [],
      theirAdIds: [],
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
      favouriteItemsId: [],
      theirAdIds: [],
      email: 'f20201556@pilani.bits-pilani.ac.in',
    ),
  ];
  Profile getProfile(String profileId) {
    return _profiles.firstWhere((element) => element.profileId == profileId);
  }

  List<String> getFavoriteItems(String profileId) {
    return _profiles
        .firstWhere((element) => element.profileId == profileId)
        .favouriteItemsId;
  }

  void addFavouriteItem(String profileId, String id) {
    _profiles
        .firstWhere((element) => element.profileId == profileId)
        .favouriteItemsId
        .add(id);
    notifyListeners();
  }

  void deleteFavouriteItem(String profileId, String id) {
    _profiles
        .firstWhere((element) => element.profileId == profileId)
        .favouriteItemsId
        .removeWhere((element) => element == id);
    notifyListeners();
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

  void updateProfile(String profileId, int number, String change) {
    final profile =
        _profiles.firstWhere((element) => element.profileId == profileId);
    switch (number) {
      case 1:
        {
          profile.profilePicUrl = change;
        }
        break;

      case 2:
        {
          profile.phoneNumber = int.parse(change);
        }
        break;

      case 3:
        {
          profile.bhawanName = change;
        }
        break;

      case 4:
        {
          profile.rommNo = int.parse(change);
        }
        break;
    }
    notifyListeners();
  }
}
