import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_grocery/pages/pantry_page.dart';
import 'package:smart_grocery/pages/recipe_page.dart';
import 'package:smart_grocery/pages/recommendations_page.dart';
import 'package:smart_grocery/pages/store_page.dart';
import 'package:smart_grocery/pages/favorites_page.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  late Widget WidgetRecipePage;
  late Widget WidgetStores;
  late Widget WidgetPantryPage;
  late Widget WidgetFavoritesPage;
  late Widget WidgetReccomendationsPage;
  // late Widget WidgetLoginPage;

  // TODO : change to get user pantry
  List<String> userPantry = ['ingredients', 'recipes', 'stores'];

  void onPressed() {
    setState(() {
      currentPageIndex = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetRecipePage = RecipePage(
      onPressed: onPressed,
    );
    WidgetStores = StorePage();
    // WidgetLoginPage = LoginPage();
    WidgetPantryPage = PantryPage();
    WidgetFavoritesPage = FavoritesPage(
      onPressed: onPressed,
    );
    WidgetReccomendationsPage = RecommendationsPage();
  }

  late Future<List<Map<String, dynamic>>> listOfRecipes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Smart Grocery'),
      ),
      body: <Widget>[
        WidgetRecipePage,
        WidgetStores,
        WidgetPantryPage,
        WidgetFavoritesPage,
        WidgetReccomendationsPage
        // WidgetLoginPage,
      ][currentPageIndex],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(Icons.person, size: 50.0, color: Colors.blueGrey),
                    backgroundColor: Colors.grey[300],
                    radius: 40.0,
                  ),
                  SizedBox(height: 10), // Spacing between icon and text
                  Text(
                    "Guest User",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "noEmail@email.com",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book, color: Colors.red),
              title: const Text('Recipes', style: TextStyle(fontSize: 20.0)),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentPageIndex = 0;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.store, color: Colors.green),
              title: const Text('Stores', style: TextStyle(fontSize: 20.0)),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentPageIndex = 1;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.shelves, color: Colors.brown,),
              title: const Text('Pantry', style: TextStyle(fontSize: 20.0)),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentPageIndex = 2;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.orange),
              title: const Text('Favorites', style: TextStyle(fontSize: 20.0)),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentPageIndex = 3;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.recommend_outlined, color: Colors.blue),
              title: const Text('Recommendations', style: TextStyle(fontSize: 20.0)),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentPageIndex = 4;
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Exit', style: TextStyle(fontSize: 20.0)),
              onTap: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        labels: const ["Recipes", "Stores", "Pantry", "Favorites"],
        initialSelectedTab: "Recipes",
        tabBarColor: Theme.of(context).colorScheme.primary,
        tabIconColor: Colors.grey,
        tabSelectedColor: Theme.of(context).colorScheme.primary,
        onTabItemSelected: (int value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        icons:  [Icons.menu_book, Icons.store, Icons.shelves, Icons.favorite],
        textStyle: const TextStyle(color: Colors.white),
      ),

    );
  }
}

class MySearchDelegate extends SearchDelegate {
  static List<String> _previousSearchKeywords = [];
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
    return Center(
        child: Text(
      query,
      style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold), // Text
    ));
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
}
