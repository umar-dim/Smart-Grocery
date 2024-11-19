import 'package:flutter/material.dart';

String path = 'assets/data/Food_Images/';
String extension = '.jpeg';

class RecipeDetailPage extends StatefulWidget {
  final String title;
  final List instruction;
  final List ingredient;
  final void Function() onPressed;
  final String recipeImage;

  const RecipeDetailPage({
    super.key,
    required this.title,
    required this.instruction,
    required this.ingredient,
    required this.recipeImage,
    required this.onPressed,
  });

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late List<bool> instructionChecked;
  late List<bool> ingredientChecked;

  @override
  void initState() {
    super.initState();
    instructionChecked = List.generate(widget.instruction.length, (_) => false);
    ingredientChecked = List.generate(widget.ingredient.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onPressed();
              },
              icon: const Icon(Icons.store_sharp))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
        child: ListView(
          children: [
            Center(
              child: Hero(
                tag: widget.recipeImage + " hero",
                child: Image(
                    image: AssetImage(path + widget.recipeImage + extension)),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "Instructions:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ...List.generate(widget.instruction.length, (index) {
              return CheckboxListTile(
                activeColor: Colors.green,
                controlAffinity: ListTileControlAffinity.leading,
                value: instructionChecked[index],
                onChanged: (bool? newValue) {
                  setState(() {
                    instructionChecked[index] = newValue ?? false;
                  });
                },
                title: Text(widget.instruction[index]),
              );
            }),
            const SizedBox(height: 30),
            const Text(
              "Ingredients:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ...List.generate(widget.ingredient.length, (index) {
              return CheckboxListTile(
                activeColor: Colors.green,
                controlAffinity: ListTileControlAffinity.leading,
                value: ingredientChecked[index],
                onChanged: (bool? newValue) {
                  setState(() {
                    ingredientChecked[index] = newValue ?? false;
                  });
                },
                title: Text(widget.ingredient[index]),
              );
            }),
          ],
        ),
      ),
    );
  }
}
