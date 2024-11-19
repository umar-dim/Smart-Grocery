import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_grocery/appState.dart';
import 'package:smart_grocery/food/recipe.dart';
import 'package:smart_grocery/models/recipe_tile.dart';
import 'package:smart_grocery/pages/recipe_details_page.dart';

class RecipePage extends StatefulWidget {
  final void Function() onPressed;

  const RecipePage({super.key, required this.onPressed});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  String searchRecipe = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipes"), actions: [
        Consumer<AppData>(builder: (context, database, child) {
          return IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: MySearchDelegate(database.listOfRecipes));
              },
              icon: Icon(Icons.search));
        })
      ]),
      body: getRecipelist(),
    );
  }

  Widget getRecipelist() {
    return Consumer<AppData>(builder: (context, database, child) {
      if (Provider.of<AppData>(context, listen: false).listOfRecipes.isEmpty)
        return Center(
          child: CircularProgressIndicator(), // The loading indicator
        );
      return ListView.builder(
        itemCount: database.listOfRecipes.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              RecipeTile(
                // recipeName: database.listOfRecipes[index].Recipe_title,
                // recipeImage: database.listOfRecipes[index].image_name,
                recipe: database.listOfRecipes[index],
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return RecipeDetailPage(
                      title: database.listOfRecipes[index].Recipe_title,
                      instruction: database.listOfRecipes[index].instructions,
                      ingredient: database.listOfRecipes[index].ingredients,
                      recipeImage: database.listOfRecipes[index].image_name,
                      onPressed: widget.onPressed,
                    );
                  }));
                },
                onPressed: () {
                  database.AddFavorites(true, index);
                },
              ),
              Divider(
                thickness: 3,
              ), // Add this line to insert a divider after each item
            ],
          );
        },
      );
    });
  }
}

class MySearchDelegate extends SearchDelegate {
  List<Recipe> recipes;
  List<Map<String, dynamic>> recipesResults = [];

  MySearchDelegate(this.recipes);

  static List<String> _previousSearchKeywords = [];

  List<Map<String, dynamic>> listOfMaps = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty)
              close(context, null);
            else
              query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    doSearch();
    if (recipesResults.isEmpty) {
      // Display a message when no results are found
      return Center(
        child: Text(
          'No results found',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );
    }
    return ListView.builder(
      itemCount: recipesResults.length,
      itemBuilder: (context, index) {
        return RecipeTile(
          recipe: Recipe.fromMap2(recipesResults[index]),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return RecipeDetailPage(
                title: recipesResults[index]["Recipe_title"],
                instruction: recipesResults[index]["instructions"],
                ingredient: recipesResults[index]["ingredients"],
                recipeImage: recipesResults[index]["image_name"],
                onPressed: () {},
              );
            }));
          },
          onPressed: () {},
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = _previousSearchKeywords.where((element) {
      final result = element.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    if (suggestions.length == 0 && query.length == 0)
      suggestions = _previousSearchKeywords;
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        ); // ListTile
      },
    ); // ListView.builder I
  }

  void doSearch() {
    recipesResults.clear();
    recipesResults = recipes
        .where((recipe) {
          String title = recipe.Recipe_title.toLowerCase();
          return title.contains(query.toLowerCase());
        })
        .map((recipe) => recipe.toMap())
        .toList();
  }
}
