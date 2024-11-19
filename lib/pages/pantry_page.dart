import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_grocery/appState.dart';
import 'package:smart_grocery/models/ingredients_tile.dart';

import 'package:smart_grocery/pages/ingredients_page.dart';

import 'camera_page.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({super.key});

  @override
  State<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends State<PantryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantry'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CameraScreen()),
              );
            },
            icon: Icon(Icons.camera_alt),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => IngredientsAddPage()),
              );
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              Provider.of<AppData>(context, listen: false).ClearAllIngredients();
            },
            icon: Icon(Icons.delete_forever),
          )
        ],
      ),
      body: Provider.of<AppData>(context, listen: false).listOfIngredients.isEmpty
          ? buildEmptyPantry(context)
          : buildIngredientList(context),
    );
  }

  Widget buildEmptyPantry(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Tap the "Plus Icon" on the top right or Add button below to add ingredients to your pantry.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => IngredientsAddPage()),
              );
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }

  Widget buildIngredientList(BuildContext context) {
    return Consumer<AppData>(
      builder: (context, database, child) {
        return ListView.builder(
          itemCount: database.listOfIngredients.length,
          itemBuilder: (context, index) {
            return IngredientTile(
              name: database.listOfIngredients[index].name,
              quantity: database.listOfIngredients[index].qty_available,
              deleteIngrident: () => database.RemoveIngredientAt(index),
            );
          },
        );

  });
  }
}


