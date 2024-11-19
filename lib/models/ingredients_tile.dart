import 'package:flutter/material.dart';

class IngredientTile extends StatelessWidget {
  final String name;
  final double quantity;
  final void Function() deleteIngrident;

  IngredientTile(
      {super.key,
      required this.name,
      required this.quantity,
      required this.deleteIngrident});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$name'),
      subtitle: Text('Quanty: $quantity'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: deleteIngrident,
      ),
    );
  }
}
