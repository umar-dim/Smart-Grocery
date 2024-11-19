import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../appState.dart';
import '../food/ingredient.dart';

class IngredientsAddPage extends StatefulWidget {
  @override
  _IngredientsAddPageState createState() => _IngredientsAddPageState();
}

class _IngredientsAddPageState extends State<IngredientsAddPage> {
  late TextEditingController tController;
  double quantity = 1.0; // State variable for the quantity
  String selectedUnit = ''; // State variable for selected unit
  @override
  void initState() {
    super.initState();
    tController = TextEditingController();
  }

  @override
  void dispose() {
    tController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Ingredient"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AppData>(builder: (context, database, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
                  ),
                  autofocus: true,
                  controller: tController,
                ),
                SizedBox(height: 20),
                Text("Quantity: ${quantity.toStringAsFixed(1)}"),
                Slider(
                  value: quantity,
                  min: 0.0,
                  max: 10.0,
                  divisions: 20,
                  label: quantity.toStringAsFixed(1),
                  onChanged: (double newValue) {
                    setState(() {
                      quantity = newValue;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _unitButton('lbs'),
                    _unitButton('oz'),
                    _unitButton('pieces'),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final newIngredient = tController.text;
                    if (newIngredient.isNotEmpty) {
                      database.AddIngredient(Ingredient(
                        name: newIngredient,
                        ingredient_id: -1,
                        cost: 0.0,
                        qty_available: quantity,
                      ));
                      tController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add"),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
Widget _unitButton(String unit) {
  return ElevatedButton(
    onPressed: () {
      setState(() {
        selectedUnit = unit;
      });
    },
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: selectedUnit == unit ? Colors.deepPurple[300] : Colors.grey,
    ),
    child: Text(unit.toUpperCase()),
  );
}
}

