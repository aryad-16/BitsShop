import 'package:flutter/material.dart';

import 'item_model.dart';

class Items with ChangeNotifier {
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
  ];

  List<Item> get bookitems {
    return [
      ..._items
    ]; //returns a copy of the list, so as to not edit it anywhere else in the app
  }

  List<Item> get cycleitems {
    return [
      ..._items
    ]; //returns a copy of the list, so as to not edit it anywhere else in the app
  }

  List<Item> get electronicsitems {
    return [
      ..._items
    ]; //returns a copy of the list, so as to not edit it anywhere else in the app
  }

  List<Item> get othersitems {
    return [
      ..._items
    ]; //returns a copy of the list, so as to not edit it anywhere else in the app
  }

  List<Item> getItems(List<String> ids) {
    List<Item> temp = [];
    for (String id in ids) {
      temp.add(_items.firstWhere((element) => element.id == id));
    }
    return temp;
  }

  void addItem(Item item) {
    item.imageList.removeWhere((element) => element == 'a');
    final newItem = Item(
      category: item.category,
      id: item.id,
      title: item.title,
      description: item.description,
      price: item.price,
      imageList: item.imageList,
      profileId: item.profileId,
    );
    _items.add(newItem);
    notifyListeners();
  }

  void updateitem(String id, Item newItem) {
    newItem.imageList.removeWhere((element) => element == 'a');
    final itemIndex = _items.indexWhere((element) => element.id == id);
    _items[itemIndex] = newItem;
    notifyListeners();
  }
}
