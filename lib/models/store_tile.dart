import 'package:flutter/material.dart';
import 'package:smart_grocery/store/store.dart';

String path = 'assets/data/grocery_store_icons/';


class StoreTile extends StatefulWidget {
  final Store store;
  final void Function() onTap;
  StoreTile(
      {super.key,
        required this.onTap,
        required this.store,});

  @override
  State<StoreTile> createState() => _StoreTileState();
}

class _StoreTileState extends State<StoreTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(image: AssetImage(path + widget.store.image_path)),
      title: Text(widget.store.name),
      subtitle: Text(widget.store.address),
      onTap: widget.onTap,
    );
  }
}