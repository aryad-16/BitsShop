import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum ItemCategory { books, cycles, electronics, others, all, yourItems }

enum YearCategory { first, second, third, fourth, fifth }

enum SemesterCategory { first, second }

enum BranchCategory {
  eni,
  ece,
  eee,
  cs,
  chemical,
  manufacturing,
  civil,
  bioDual,
  phyDual,
  chemDual,
  ecoDual
}

class Item with ChangeNotifier {
  final List<String> imageList;
  final String title;
  final String description;
  final int price;
  final ItemCategory category;
  bool isFavourite;
  final String id;
  final String profileId;
  final YearCategory? year;
  final SemesterCategory? sem;
  final BranchCategory? branch;

  Item({
    required this.id,
    required this.profileId,
    required this.imageList,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    this.isFavourite = false,
    this.branch,
    this.year,
    this.sem,
  });

  void toggleFavouriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }

  factory Item.fromDocument(DocumentSnapshot doc) {
    var docData = doc.data().toString();
    return Item(
      title: docData.contains('title') ? doc.get('title') : 'not set',
      description:
          docData.contains('description') ? doc.get('description') : 'not set',
      price: docData.contains('price') ? doc.get('price') : 0,
      category: docData.contains('category')
          ? ItemCategory.values[doc.get('category')]
          : ItemCategory.others,
      isFavourite:
          docData.contains('isFavourite') ? doc.get('isFavourite') : false,
      id: docData.contains('id') ? doc.get('id') : 'not set',
      profileId:
          docData.contains('profileId') ? doc.get('profileId') : 'not set',
      imageList: docData.contains('imageList') ? doc.get('imageList') : [],
      branch: docData.contains('branch')
          ? BranchCategory.values[doc.get('branch')]
          : null,
      year: docData.contains('year')
          ? YearCategory.values[doc.get('year')]
          : null,
      sem: docData.contains('sem')
          ? SemesterCategory.values[doc.get('sem')]
          : null,
    );
  }
}
