import 'dart:io';
import 'dart:async';
// import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
// import 'package:csv/csv.dart';
import 'dart:convert';
import 'package:smart_grocery/food/recipe.dart';
import 'package:smart_grocery/food/ingredient.dart';
import 'package:smart_grocery/store/store.dart';

class DatabaseHelper {
  // setup of the database
  static final _dbName = 'smartGrocery.db';
  static final _dbVersion = 1;

  // add table vars here
  static final usersTable = 'users';
  // the columns in the users.csv file
  static final columnUserId = 'ID';
  static final columnName = 'Name';
  static final columnEmail = 'Email';
  static final columnPhoneNumber = 'PhoneNumber';
  static final columnUserName = 'Username';
  static final columnLocation = 'Location';
  static final columnPaymentInfo = 'PaymentINFO';
  static final columnFoodPreferences = 'FoodPreference';

  // recipes
  static final recipeTable = 'recipes';
  static final columnRecipeTitle = 'Recipe_title';
  static final columnInstructions = 'instructions';
  static final columnIngredients = 'ingredients';
  static final columnRecipeId = 'recipe_id';
  static final columnIsFavorite = 'isFavorite';
  static final columnImagePath = 'image_name';

  // Ingredients
  static final ingredientsTable = 'ingredients';
  static final columnIngredientName = 'name';
  static final columnIngredientId = 'ingredient_id';
  static final columnIngredientCost = 'cost';
  static final columnIngredientQty = 'inventory_qty';

  // Stores
  static final groceryStoresTable = 'grocery_stores';
  static final columnStoreName = 'store_name';
  static final columnStoreAddress = 'Address';
  static final columnStoreZip = 'Zip';
  static final columnStoreLocation = 'Location';
  static final columnStoreId = 'store_id';
  static final columnStoreImage = 'image_path';

  // Making it a Singleton
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // getter
  Future<Database> get database async {
    if (_database != null) return _database!;
    //
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // create the tables
    await db.execute('''
            CREATE TABLE $recipeTable (
              $columnRecipeId INTEGER PRIMARY KEY,
              $columnRecipeTitle TEXT NOT NULL,
              $columnInstructions LONGTEXT,
              $columnIngredients LONGTEXT NOT NULL,
              $columnIsFavorite INTEGER NOT NULL,
              $columnImagePath TEXT NOT NULL
            )
            ''');
    await db.execute('''
          CREATE TABLE $ingredientsTable(
            $columnIngredientId INTEGER PRIMARY KEY,
            $columnIngredientName LONGTEXT NOT NULL,
            $columnIngredientCost DOUBLE,
            $columnIngredientQty DOUBLE
            )
            ''');

    await db.execute('''
          CREATE TABLE $groceryStoresTable(
            $columnStoreId INTEGER PRIMARY KEY,
            $columnStoreName LONGTEXT NOT NULL,
            $columnStoreAddress LONGTEXT NOT NULL,
            $columnStoreZip TEXT,
            $columnStoreLocation LONGTEXT NOT NULL,
            $columnStoreImage TEXT NOT NULL
            )
            ''');

    bool recipesPopulated = await _isTablePopulated(db, recipeTable);
    bool ingredientsPopulated = await _isTablePopulated(db, ingredientsTable);
    bool storesPopulated = await _isTablePopulated(db, groceryStoresTable);

    if (!recipesPopulated) {

      String recipesJsonString =
          await rootBundle.loadString('assets/data/recipes_with_images.json');

      // print(recipesJsonString);

      List<dynamic> recipes = json.decode(recipesJsonString);
      // Insert recipes into the database
      for (var recipe in recipes) {
        await db.insert(recipeTable, {
          columnRecipeTitle: recipe['Recipe_title'],
          columnInstructions: json.encode(recipe['instructions']),
          // Assuming it's a JSON array or object
          columnIngredients: json.encode(recipe['ingredients']),
          // Assuming it's a JSON array or object
          columnRecipeId: recipe['recipe_id'],
          columnIsFavorite: recipe['isFavorite'],
          columnImagePath: recipe['image_name']
        });
      }
    }

    if (!ingredientsPopulated) {
      String ingredientsJsonString = await rootBundle.loadString(
          'assets/data/ingredients_with_costs_and_zero_inventory.json');
      // print(ingredientsJsonString);

      List<dynamic> ingredients = json.decode(ingredientsJsonString);

      for (var ing in ingredients) {
        await db.insert(ingredientsTable, {
          columnIngredientName: ing['name'],
          columnIngredientId: ing['ingredient_id'],
          columnIngredientCost: ing['cost'],
          columnIngredientQty: ing['inventory_qty'],
        });
      }
    }

    if (!storesPopulated) {
      String groceryStoresJsonString =
          await rootBundle.loadString('assets/data/storeswithPhotos.json');
      // print(groceryStoresJsonString);
      List<dynamic> stores = json.decode(groceryStoresJsonString);

      for (var store in stores) {
        await db.insert(groceryStoresTable, {
          columnStoreName: store['store_name'],
          columnStoreAddress: store['Address'],
          columnStoreZip: store['Zip'],
          columnStoreLocation: store['Location'],
          columnStoreId: store['store_id'],
          columnStoreImage: store['image_path'],
        });
      }
    }
  }

  // RECIPE OPERATIONS

  // the updated version of inserting a recipe
  Future<int> insertRecipe(Recipe recipe) async {
    Database db = await instance.database;
    return await db.insert(recipeTable, recipe.toMap());
  }

  // Read: fetch all recipes from the DB
  // updated version of get all recipes
  Future<List<Recipe>> getAllRecipes() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(recipeTable);
    return List.generate(maps.length, (i) {
      return Recipe.fromMap(maps[i]);
    });
  }

  // updated version of updating a recipe
  Future<int> updateRecipe(Recipe recipe) async {
    Database db = await instance.database;
    return await db.update(recipeTable, recipe.toMap(),
        where: '$columnRecipeId = ?', whereArgs: [recipe.recipe_id]);
  }

  Future<int> deleteRecipe(int id) async {
    Database db = await instance.database;
    return await db
        .delete(recipeTable, where: '$columnRecipeId = ?', whereArgs: [id]);
  }

  Future<void> toggleFavoriteStatus(int recipeId, int isFavorite) async {
    final db = await instance.database;
    // Here we assume isFavorite is already an integer with value 0 or 1.
    await db.update(
      recipeTable,
      {'isFavorite': isFavorite},
      where: 'recipe_id = ?',
      whereArgs: [recipeId],
    );
  }

  Future<List<Recipe>> getFavoriteRecipes() async {
    final db = await instance.database;
    final maps = await db.query(
      recipeTable,
      where: 'isFavorite = ?',
      whereArgs: [1], // We look for recipes where is_favorite is 1
    );
    return maps.map((map) => Recipe.fromMap(map)).toList();
  }

  // INGREDIENT OPERATIONS

  Future<int> insertIngredient(Ingredient ingredient) async {
    Database db = await instance.database;
    return await db.insert(ingredientsTable, ingredient.toMap());
  }

  Future<List<Ingredient>> getAllIngredients() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(ingredientsTable);
    return List.generate(maps.length, (i) {
      return Ingredient.fromMap(maps[i]);
    });
  }

  // updated version of updating a recipe
  Future<int> updateIngredient(Ingredient ingredient) async {
    Database db = await instance.database;
    return await db.update(ingredientsTable, ingredient.toMap(),
        where: '$columnIngredientId = ?',
        whereArgs: [ingredient.ingredient_id]);
  }

  Future<int> deleteIngredient(int id) async {
    Database db = await instance.database;
    return await db.delete(ingredientsTable,
        where: '$columnIngredientId = ?', whereArgs: [id]);
  }

  // Store operations

  Future<int> insertStore(Store store) async {
    Database db = await instance.database;
    return await db.insert(groceryStoresTable, store.toMap());
  }

  Future<List<Store>> getAllStores() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(groceryStoresTable);
    return List.generate(maps.length, (i) {
      return Store.fromMap(maps[i]);
    });
  }

  // updated version of updating a recipe
  Future<int> updateStore(Store store) async {
    Database db = await instance.database;
    return await db.update(groceryStoresTable, store.toMap(),
        where: '$columnStoreId = ?', whereArgs: [store.id]);
  }

  Future<int> deleteStore(int id) async {
    Database db = await instance.database;
    return await db.delete(groceryStoresTable,
        where: '$columnStoreId = ?', whereArgs: [id]);
  }

  // Load the recipes

  List<dynamic> jsonData = [];

  Future<List<dynamic>> loadJsonAsset(String fileName) async {
    String jsonString = await rootBundle.loadString(fileName);
    List<dynamic> data = jsonDecode(jsonString);
    return data;
  }

  Future<bool> _isTablePopulated(Database db, String tableName) async {
    final data = await db.query(tableName, limit: 1);
    return data.isNotEmpty;
  }
}
