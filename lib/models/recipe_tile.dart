
import 'package:flutter/material.dart';
import 'package:smart_grocery/food/recipe.dart';

String path = 'assets/data/Food_Images/';
String extension = '.jpeg';

class RecipeTile extends StatefulWidget {
  final Recipe recipe;
  final void Function() onTap;
  final void Function() onPressed;
  RecipeTile(
      {super.key,
      required this.onTap,
      required this.onPressed,
      required this.recipe});

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  late Color c;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.recipe.Recipe_title),
      leading: Hero(
          tag: widget.recipe.image_name + " hero",
          child: Image(
              image: AssetImage(path + widget.recipe.image_name + extension))),
      onTap: widget.onTap,
      trailing: IconButton(
        icon: Icon(Icons.favorite),
        onPressed: widget.onPressed,
        color: getColor(),
      ),
    );
  }

  Color getColor() {
    setState(() {
      c = Colors.grey;
      // print("favourite = ${widget.recipe.isFavorite}");
      if (widget.recipe.isFavorite == 1) {
        c = Colors.redAccent;
      }
    });
    return c;
  }
}
