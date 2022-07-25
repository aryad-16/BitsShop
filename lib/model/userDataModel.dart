import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final currentUserDataProvider = StateProvider((ref) => userData);
UserData? userData;

class UserData {
  String username;
  String bhawanName;
  String roomNo;
  String phoneNumber;
  String uid;
  String profilePicUrl;
  String favouriteItemsId;
  String theirAdIds;
  String email;

  UserData(
      {required this.username,
      required this.uid,
      required this.profilePicUrl,
      required this.email,
      required this.phoneNumber,
      required this.bhawanName,
      required this.roomNo,
      required this.favouriteItemsId,
      required this.theirAdIds});

  factory UserData.fromDocument(DocumentSnapshot doc) {
    var docData = doc.data().toString();
    return UserData(
      email: docData.contains('email') ? doc.get('email') : 'not set',
      username: docData.contains('username') ? doc.get('username') : 'not set',
      profilePicUrl: docData.contains('profilePicUrl')
          ? doc.get('profilePicUrl')
          : 'not set',
      uid: docData.contains('uid') ? doc.get('uid') : 'not set',
      phoneNumber:
          docData.contains('phoneNumber') ? doc.get('phoneNumber') : 'not set',
      bhawanName:
          docData.contains('bhawanName') ? doc.get('bhawanName') : 'not set',
      roomNo: docData.contains('roomNo') ? doc.get('roomNo') : 'not set',
      favouriteItemsId: docData.contains('favouriteItemsId')
          ? doc.get('favouriteItemsId')
          : '[]',
      theirAdIds: docData.contains('theirAdIds') ? doc.get('theirAdIds') : '[]',
    );
  }
}
