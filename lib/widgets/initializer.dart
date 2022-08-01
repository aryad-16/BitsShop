import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_singup_screen_ui/providers/item_model.dart';
import 'package:login_singup_screen_ui/providers/items_provider.dart';
import 'package:login_singup_screen_ui/widgets/userCheck.dart';

final itemsStreamProvider = StreamProvider.autoDispose<List<Item>>((ref)async* {
  final _stream =  Items().getItemsList();
  await for (var event in _stream) {
    yield event;
  }
});

class InitializerWidget extends ConsumerStatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  static const routeName = 'initializer';

  @override
  ConsumerState<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends ConsumerState<InitializerWidget> {
  @override
  void initState() {
    userCheck(ref, context);
    // getItemsList();
    super.initState();
  }

  // Stream<List<Item>> getItemsList() =>
  //     // await FirebaseFirestore.instance.collection('items').get().then((value) {
  //     //   print(value.docs[0].data());
  //     //   value.docs.forEach((element) {
  //     //     itemsList.add(Item.fromDocument(element));
  //     //   });
  //     // });
  //     FirebaseFirestore.instance.collection('items').snapshots().map(
  //         (snapshot) =>
  //             snapshot.docs.map((doc) => Items.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
