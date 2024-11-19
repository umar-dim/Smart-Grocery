import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_grocery/appState.dart';
import 'package:smart_grocery/food/recipe.dart';
import 'package:smart_grocery/models/recipe_tile.dart';
import 'package:smart_grocery/pages/recipe_details_page.dart';

class FavoritesPage extends StatefulWidget {
  final void Function() onPressed;
  const FavoritesPage({super.key, required this.onPressed});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String searchRecipe = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorites"), actions: [
        IconButton(
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: MySearchDelegate(
                      Provider.of<AppData>(context, listen: false)
                          .listOffavoriteRecipe));
            },
            icon: Icon(Icons.search))
      ]),
      body: getRecipelist(),
    );
  }

  Widget getRecipelist() {
    return Consumer<AppData>(builder: (context, databsse, child) {
      if (databsse.listOffavoriteRecipe.isEmpty) {
        return Center(
          child: Text("No Favorites Found\n Add Favorites by clicking the heart icon on the Recipes page",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
        );
      }
      return ListView.builder(
          itemCount: databsse.listOffavoriteRecipe.length,
          itemBuilder: (context, index) {
            return RecipeTile(
            recipe: databsse.listOffavoriteRecipe[index],
              // recipeName: databsse.listOffavoriteRecipe[index].Recipe_title,
              // recipeImage: databsse.listOffavoriteRecipe[index].image_name,
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return RecipeDetailPage(
                    title: databsse.listOffavoriteRecipe[index].Recipe_title,
                    instruction:
                        databsse.listOffavoriteRecipe[index].instructions,
                    ingredient:
                        databsse.listOffavoriteRecipe[index].ingredients,
                    recipeImage:
                        databsse.listOffavoriteRecipe[index].image_name,
                    onPressed: widget.onPressed,
                  );
                }));
              },
              onPressed: () {
                databsse.RemoveFavorites(index);
              },
            );
          });
    });
  }
}

class MySearchDelegate extends SearchDelegate {
  List<Recipe> recipes;
  List<Map<String, dynamic>> recipesResults = [];
  MySearchDelegate(this.recipes);
  // MySearchDelegate({required this.})
  static List<String> _previousSearchKeywords = [];

  List<Map<String, dynamic>> listOfMaps = [];

  // void getSearch () (
  //   for(var recipeObj in recipes){
  //     listOfMap.a
  //   }
  //   recipesResults = recipes.where((map) {
  //   // Assuming you want a case-insensitive search
  //   String name = map['name']?.toLowerCase() ?? '';
  //   return name.contains(query.toLowerCase());
  // }).toList();
  // )

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
    // TODO: Return a list view that contains all the recipes matching the result
    // TODO: use the same class used to build the recommendation page which is a list
    // TODO: of cards i.e. listview
    if (!_previousSearchKeywords.contains(query))
      _previousSearchKeywords.add(query);
    return ListView.builder(
      itemCount: recipesResults.length,
      itemBuilder: (context, index) {
        return RecipeTile(
          recipe: Recipe.fromMap( recipesResults[index]),
          // recipeName: recipesResults[index]["Recipe_title"],
          // recipeImage: recipesResults[index]["image_name"],
          // recipeName: recipeData[index].toMap()["Recipe_title"],
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return RecipeDetailPage(
                title: recipesResults[index]["Recipe_title"],
                instruction: recipesResults[index]["instructions"],
                ingredient: recipesResults[index]["ingredients"],
                recipeImage: "ackee-tacos-with-island-guacamole", onPressed: () {  },
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
    for (var r in recipes) {
      listOfMaps.add(r.toMap());
    }

    recipesResults = listOfMaps.where((map) {
      String name = map['Recipe_title']?.toLowerCase() ?? '';
      return name.contains(query.toLowerCase());
    }).toList();
  }
}
