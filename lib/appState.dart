import 'package:flutter/foundation.dart';
import 'package:smart_grocery/databaseHelper.dart';
import 'package:smart_grocery/food/ingredient.dart';
import 'package:smart_grocery/food/recipe.dart';
import 'package:smart_grocery/store/store.dart';

class AppData extends ChangeNotifier {
  List<Recipe> listOfRecipes = [];
  List<Ingredient> listOfIngredients = [];
  List<Store> listOfStores = [];
  List<Recipe> listOffavoriteRecipe = [];
  DatabaseHelper _dbHelper = DatabaseHelper.instance;

  AppData() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    // Load the recipes from the database in to local variable
    listOfRecipes = await _dbHelper.getAllRecipes();
    notifyListeners();

    // for (int i = 0; i < listOfRecipes.length; i++) {
    //   if (listOfRecipes[i].image_name == null)
    //     print('The image at index $i is null.');
    // }
    print('Recipes for recipes page: ${listOfRecipes.length}');

    // Load the ingredients from the database in to local variable
    listOfIngredients = await _dbHelper.getAllIngredients();
    notifyListeners();
    print('Ingredients for Pantry page: ${listOfIngredients.length}');

    // Load the Store from the database in to local variable
    listOfStores = await _dbHelper.getAllStores();
    notifyListeners();
    print('Stores for store page: ${listOfStores.length}');
  }



  ClearAllIngredients() {
    listOfIngredients = [];
    notifyListeners();
  }

  RemoveIngredientAt(int index) {
    listOfIngredients.removeAt(index);
    notifyListeners();
  }

  AddIngredient(Ingredient item) {
    // listOfIngredients.add(item);
    listOfIngredients.insert(0, item);
    notifyListeners();
  }

  AddFavorites(bool value, int index) {
    if (value && !listOffavoriteRecipe.contains(listOfRecipes[index])) {
      listOffavoriteRecipe.add(listOfRecipes[index]);
      listOfRecipes[index].isFavorite = 1;
    } else {
      RemoveFavorites(listOffavoriteRecipe.indexOf(listOfRecipes[index]));
    }
    notifyListeners();
  }

  RemoveFavorites(int index) {
    print(
        'index in recipe is ${listOfRecipes.indexOf(listOffavoriteRecipe[index])}');
    listOfRecipes[listOfRecipes.indexOf(listOffavoriteRecipe[index])]
        .isFavorite = 0;
    listOffavoriteRecipe.remove(listOffavoriteRecipe[index]);
    notifyListeners();
  }
}
