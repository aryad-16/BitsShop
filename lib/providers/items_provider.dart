import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'item_model.dart';

class Items with ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  final List<Item> _items = [];
  Stream<List<Item>> getItemsList() => FirebaseFirestore.instance
      .collection('items')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Items.fromJson(doc.data())).toList());

  static Item fromJson(Map<String, dynamic> json) {
    final string2Itemcategory =
        ItemCategory.values.asMap().map((k, v) => MapEntry("$v", v));
    final string2Sem =
        SemesterCategory.values.asMap().map((k, v) => MapEntry("$v", v));
    final string2year =
        YearCategory.values.asMap().map((k, v) => MapEntry("$v", v));
    final string2Branch =
        BranchCategory.values.asMap().map((k, v) => MapEntry("$v", v));
    List<String> imageList = json['imageList']
        ;
    
    for (var url in imageList) {
      url.trim();
    }
    return Item(
      category: string2Itemcategory[json['category']] ?? ItemCategory.all,
      description: json['description'],
      id: json['id'],
      imageList: FieldValue.arrayUnion(imageList),
      title: json['title'],
      price: json['price'],
      profileId: json['profileId'],
      sem: string2Sem[json['semester']],
      branch: string2Branch[json['branch']],
      year: string2year[json['year']],
    );
  }

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
            'imageList': newItem.imageList,
            'id': newItem.id,
            'uid': user?.uid.toString(),
            'year': newItem.year,
            'branch': newItem.branch.toString(),
            'semester': newItem.sem.toString()
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

  List<Item> searchItems(ItemCategory category, String query,
      YearCategory? year, SemesterCategory? sem, BranchCategory? branch) {
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
      if (category == ItemCategory.all) {
        return (titleLower.contains(searchLower) ||
            descriptionLower.contains(searchLower));
      } else {
        return (titleLower.contains(searchLower) ||
                descriptionLower.contains(searchLower)) &&
            item.category == category;
      }
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
