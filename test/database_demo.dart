import 'package:flutter/material.dart';
import 'package:smart_grocery/databaseHelper.dart'; // Import your DatabaseHelper file
import 'package:smart_grocery/food/recipe.dart';
import 'package:smart_grocery/food/ingredient.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Database Check',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DatabaseCheckPage(),
    );
  }
}

class DatabaseCheckPage extends StatefulWidget {
  @override
  _DatabaseCheckPageState createState() => _DatabaseCheckPageState();
}

class _DatabaseCheckPageState extends State<DatabaseCheckPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _checkDatabase();
  }

  String s = "";

  Future<void> _checkDatabase() async {

    // Check recipes
    List<Recipe> recipes = await _dbHelper.getAllRecipes();
    print('Recipes: ${recipes.length}');

    setState(() {
    s += 'Recipes: ${recipes.length}'; 
      
    });
    // Check ingredients
    List<Ingredient> ingredients = await _dbHelper.getAllIngredients();
    print('Ingredients: ${ingredients.length}');
setState(() {
    s += 'Ingredients: ${ingredients.length}'; 
  
});

    // Check stores
  //   List<Store> stores = await _dbHelper.getAllStores();
  //   print('Stores: ${stores.length}');
  
  // setState(() {
  //   s += 'Stores: ${stores.length}'; 
    
  // });
  

  }

  @override
  Widget build(BuildContext context) {
    // Basic UI that just contains a Scaffold and AppBar
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Check'),
      ),
      body: Center(
        child: Text('Check the console for database data $s'),
      ),
    );
  }
}
