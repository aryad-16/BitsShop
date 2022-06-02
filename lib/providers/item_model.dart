import 'package:flutter/foundation.dart';

enum Category { books, cycles, electronics, others }

class Item with ChangeNotifier {
  List<String> imageList;
  String title;
  String description;
  int price;
  Category category;
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
