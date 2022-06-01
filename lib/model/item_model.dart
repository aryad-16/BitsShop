import 'dart:io';

enum Category { books, cycles, electronics, others }

class Item {
  List<File> imageList;
  String title;
  String description;
  int price;
  Category category;

  Item({
    required this.imageList,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
  });
}
