import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_grocery/store/store.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cart_page.dart';

class StoreDetailsPage extends StatelessWidget {
  final Store store;
  final Function() onPressed;
  final List<String> cartItems = []; // List for cart items

  StoreDetailsPage({super.key, required this.onPressed, required this.store});

  @override
  Widget build(BuildContext context) {
    // Map of ingredients and their prices
    final Map<String, double> ingredientsWithPrices = {
      'Whole Wheat Bread': 2.99,
      'Peanut Butter': 3.50,
      'Grape Jelly': 2.45,
      'Bananas': 0.40,
      'Almond Milk': 3.99,
      'Green Tea': 4.50,
      'Honey': 5.25,
      'Oats': 1.99,
      'Yogurt': 0.99,
      'Almonds': 6.99,
      'Dark Chocolate': 2.50,
      'Granola': 3.95,
      'Apples': 0.75,
      'Oranges': 0.60,
      'Blueberries': 4.00,
      'Spaghetti': 1.50,
      'Tomato Sauce': 2.20,
      'Parmesan Cheese': 4.00,
      'Olive Oil': 6.50,
      'Garlic': 0.30,
      'Basil': 2.00,
      'Oregano': 1.50,
      'Ground Beef': 5.00,
      'Red Wine': 10.00,
      'Mushrooms': 2.50,
      'Onions': 0.70,
      'Bell Peppers': 1.20,
      'Zucchini': 1.35,
      'Spinach': 2.50,
      'Cherry Tomatoes': 3.00,
      'Basmati Rice': 3.75,
      'Cumin Seeds': 1.25,
      'Green Peas': 1.90,
      'Chicken Thighs': 4.50,
      'Turmeric': 2.00,
      'Ginger': 0.60,
      'Coconut Milk': 2.80,
      'Lime': 0.50,
      'Cilantro': 1.25,
      'Chili Powder': 1.75,
      'Naan Bread': 2.50,
      'Eggplant': 1.50,
      'Cauliflower': 2.00,
      'Green Beans': 2.30,
      'Potatoes': 1.00,
      'Carrots': 0.80,
      'Cabbage': 1.25,
      'Lettuce': 1.50,
      'Avocado': 1.75,
      'Lemon': 0.50,

      // You can continue to add more items here

    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(store.name),
        actions: [
          IconButton(
            icon: Icon(Icons.directions),
            onPressed: () => _launchMapsUrl(store.address),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: ingredientsWithPrices.length,
        itemBuilder: (context, index) {
          String ingredient = ingredientsWithPrices.keys.elementAt(Random().nextInt(ingredientsWithPrices.keys.length));
          double price = ingredientsWithPrices.values.elementAt(index);

          return ListTile(
            leading: Icon(Icons.food_bank_outlined, color: Colors.orangeAccent),
            title: Text('$ingredient - \$${price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart, color: Colors.teal),
              onPressed: () {
                cartItems.add(ingredient);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$ingredient added to cart'),
                    duration: Duration(milliseconds: 500),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartPage(cartItems: cartItems, store: store, prices: ingredientsWithPrices)),
        ),
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  Future<void> _launchMapsUrl(String address) async {
    final Uri googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}');

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }
}
