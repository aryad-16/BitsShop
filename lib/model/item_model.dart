enum Category { books, cycles, electronics, others }

class Item {
  List<String> imageList;
  String title;
  String description;
  double price;
  Category category;
  bool isFavourite;
  final String id;

  Item({
    required this.id,
    required this.imageList,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    this.isFavourite = false,
  });
}
