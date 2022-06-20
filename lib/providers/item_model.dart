import 'package:flutter/foundation.dart';

enum Category { books, cycles, electronics, others }
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
  final Category category;
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
}
