import 'package:flutter/foundation.dart';

enum Category { books, cycles, electronics, others }

class Item with ChangeNotifier {
  final List<String> imageList;
  final String title;
  final String description;
  final int price;
  final Category category;
  bool isFavourite;
  final String id;
  final String profileId;

  Item({
    required this.id,
    required this.profileId,
    required this.imageList,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    this.isFavourite = false,
  });

  void toggleFavouriteStatus() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
