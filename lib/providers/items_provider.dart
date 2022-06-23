import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'item_model.dart';

class Items with ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  final List<Item> _items = [
    Item(
      imageList: [
        'https://images-na.ssl-images-amazon.com/images/I/51wOfaRpwxL._SX313_BO1,204,203,200_.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/41cFXZ-3+9L._SY344_BO1,204,203,200_.jpg',
        'https://images-na.ssl-images-amazon.com/images/I/41cFXZ-3+9L._SY344_BO1,204,203,200_.jpg',
      ],
      title: 'Differential Equations: Theory - Technique and Practice',
      description:
          'Sometimes the scent of seasonal hand wash is all we need to rouse our holiday spirits. Available in an array of festive fragrances, our naturally derived gel hand wash will leave your hands soft, clean and ready to be tucked into a pair of fair isle mittens. It really is the most wonderful time of the year.',
      price: 4500,
      category: Category.books,
      id: '1',
      profileId: 'abcd',
      year: YearCategory.fifth,
      branch: BranchCategory.ecoDual,
      sem: SemesterCategory.second,
    ),
    Item(
      imageList: [
        'https://apollo-singapore.akamaized.net/v1/files/kd2ua2xtc1q2-IN/image;s=780x0;q=60',
        'https://apollo-singapore.akamaized.net/v1/files/9qhf6utn3ehz-IN/image;s=780x0;q=60',
        'https://apollo-singapore.akamaized.net/v1/files/9t4gb01g12dt2-IN/image;s=780x0;q=60',
      ],
      title: 'New fat tyre folding mountain bike available now',
      description:
          'Sometimes the scent of seasonal hand wash is all we need to rouse our holiday spirits. Available in an array of festive fragrances, our naturally derived gel hand wash will leave your hands soft, clean and ready to be tucked into a pair of fair isle mittens. It really is the most wonderful time of the year.',
      price: 11000,
      category: Category.cycles,
      id: '2',
      profileId: 'abce',
    ),
    Item(
      imageList: [
        'https://m.media-amazon.com/images/I/81aV57iUikL._SX679_.jpg',
        'https://m.media-amazon.com/images/I/81aV57iUikL._SX679_.jpg',
        'https://m.media-amazon.com/images/I/81iJwJx2F1L._SX679_.jpg',
      ],
      title:
          'Zebronics, ZEB-NC3300 USB Powered Laptop Cooling Pad with Dual Fan, Dual USB Port and Blue LED Lights',
      description:
          'Sometimes the scent of seasonal hand wash is all we need to rouse our holiday spirits. Available in an array of festive fragrances, our naturally derived gel hand wash will leave your hands soft, clean and ready to be tucked into a pair of fair isle mittens. It really is the most wonderful time of the year.',
      price: 599,
      category: Category.electronics,
      id: '3',
      profileId: 'abcf',
    ),
    Item(
      imageList: [
        'https://m.media-amazon.com/images/I/51fLFFu9leL._SX522_.jpg',
        'https://m.media-amazon.com/images/I/51fLFFu9leL._SX522_.jpg',
        'https://m.media-amazon.com/images/I/51l7P1miDoL._SX522_.jpg',
        'https://m.media-amazon.com/images/I/511iK3XF0oL._SX522_.jpg',
      ],
      title:
          'Kuber Industries Square Multipurposes Plastic Bucket For Bathing Home Cleaning & Storage Purpose, 16Ltr. (Black)-47KM01185',
      description:
          'Sometimes the scent of seasonal hand wash is all we need to rouse our holiday spirits. Available in an array of festive fragrances, our naturally derived gel hand wash will leave your hands soft, clean and ready to be tucked into a pair of fair isle mittens. It really is the most wonderful time of the year.',
      price: 249,
      category: Category.others,
      id: '4',
      profileId: 'abcd',
    ),
    Item(
      imageList: [
        'https://m.media-amazon.com/images/I/51fLFFu9leL._SX522_.jpg',
        'https://m.media-amazon.com/images/I/51fLFFu9leL._SX522_.jpg',
        'https://m.media-amazon.com/images/I/51l7P1miDoL._SX522_.jpg',
        'https://m.media-amazon.com/images/I/511iK3XF0oL._SX522_.jpg',
      ],
      title: 'Hi bro',
      description:
          'Sometimes the scent of seasonal hand wash is all we need to rouse our holiday spirits. Available in an array of festive fragrances, our naturally derived gel hand wash will leave your hands soft, clean and ready to be tucked into a pair of fair isle mittens. It really is the most wonderful time of the year.',
      price: 249,
      category: Category.others,
      id: '5',
      profileId: 'abcd',
    ),
  ];
  Future<void> fileUpload(pickedFile, i, String id, Item editedItem) async {
    if (pickedFile != null) {
      Reference reference =
          storageRef.ref().child('items').child(id).child(i.toString());
      UploadTask uploadTask = reference.putFile(File(pickedFile));
      uploadTask.snapshotEvents.listen((event) {
        print(event.bytesTransferred.toString() +
            "\t" +
            event.totalBytes.toString());
      });
      await uploadTask.whenComplete(() async {
        editedItem.imageList[i] =
            await uploadTask.snapshot.ref.getDownloadURL();
      });
    }
  }

  Future<void> addItem(Item item) async {
    item.imageList.removeWhere((element) => element == 'a');
    final newItem = Item(
      category: item.category,
      id: item.id,
      title: item.title,
      description: item.description,
      price: item.price,
      imageList: item.imageList,
      profileId: item.profileId,
      year: item.year,
      branch: item.branch,
      sem: item.sem,
    );
    for (int i = 0; i < newItem.imageList.length; i++) {
      await fileUpload(newItem.imageList[i], i, newItem.id, newItem);
    }
    FirebaseFirestore.instance
        .collection('items')
        .doc(
          newItem.id,
        )
        .set(
          {
            'title': newItem.title.toString(),
            'description': newItem.description.toString(),
            'price': newItem.price.toString(),
            'category': newItem.category.toString(),
            'profileId': newItem.profileId.toString(),
            'imageList': newItem.imageList.toString(),
            'id': newItem.id,
            'uid': user?.uid.toString()
          },
        )
        .then((_) {})
        .catchError((e) {
          print(e);
        });
    _items.add(newItem);
    notifyListeners();
  }

  void updateitem(String id, Item newItem) {
    newItem.imageList.removeWhere((element) => element == 'a');
    final itemIndex = _items.indexWhere((element) => element.id == id);
    _items[itemIndex] = newItem;
    notifyListeners();
  }

  void deleteItem(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  List<Item> searchBookItems(String query, YearCategory? year,
      SemesterCategory? sem, BranchCategory? branch) {
    return _items.where((item) {
      final titleLower = item.title.toLowerCase();
      final descriptionLower = item.description.toLowerCase();
      final searchLower = query.toLowerCase();
      if (year != null && year != item.year) {
        return false;
      }
      if (sem != null && sem != item.sem) {
        return false;
      }
      if (branch != null && branch != item.branch) {
        return false;
      }
      return (titleLower.contains(searchLower) ||
              descriptionLower.contains(searchLower)) &&
          item.category == Category.books;
    }).toList();
  }

  List<Item> searchAllItems(String query) {
    return _items.where((item) {
      final titleLower = item.title.toLowerCase();
      final descriptionLower = item.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          descriptionLower.contains(searchLower);
    }).toList();
  }

  List<Item> searchCycleItems(String query) {
    return _items.where((item) {
      final titleLower = item.title.toLowerCase();
      final descriptionLower = item.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return (titleLower.contains(searchLower) ||
              descriptionLower.contains(searchLower)) &&
          item.category == Category.cycles;
    }).toList();
  }

  List<Item> searchElectronicItems(String query) {
    return _items.where((item) {
      final titleLower = item.title.toLowerCase();
      final descriptionLower = item.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return (titleLower.contains(searchLower) ||
              descriptionLower.contains(searchLower)) &&
          item.category == Category.electronics;
    }).toList();
  }

  List<Item> searchOtherItems(String query) {
    return _items.where((item) {
      final titleLower = item.title.toLowerCase();
      final descriptionLower = item.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return (titleLower.contains(searchLower) ||
              descriptionLower.contains(searchLower)) &&
          item.category == Category.others;
    }).toList();
  }

  List<Item> searchYourItems(List<String> ids, String query) {
    List<Item> temp = [];
    for (String id in ids) {
      temp.add(_items.firstWhere((element) => element.id == id));
    }
    temp.sort((a, b) => a.price.compareTo(b.price));
    return temp.where((item) {
      final titleLower = item.title.toLowerCase();
      final descriptionLower = item.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          descriptionLower.contains(searchLower);
    }).toList();
  }

  List<Item> searchYourFavoriteItems(List<String> ids, String query) {
    List<Item> temp = [];
    for (String id in ids) {
      temp.add(_items.firstWhere((element) => element.id == id));
    }
    temp.sort((a, b) => a.price.compareTo(b.price));
    return temp.where((item) {
      final titleLower = item.title.toLowerCase();
      final descriptionLower = item.description.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          descriptionLower.contains(searchLower);
    }).toList();
  }
}
