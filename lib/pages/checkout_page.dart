import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_grocery/pages/store_details_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smart_grocery/appState.dart';

import '../food/ingredient.dart';
import '../store/store.dart';

class CheckoutPage extends StatefulWidget {
  final Store store;
  final List<String> cartItems;
  const CheckoutPage({Key? key, required this.store, required this.cartItems}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late TextEditingController cardNumberController;
  late TextEditingController expiryDateController;
  late TextEditingController cvvController;
  late TextEditingController cardHolderNameController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with demo values
    cardNumberController = TextEditingController(text: "1234 5678 9012 3456");
    expiryDateController = TextEditingController(text: "12/23");
    cvvController = TextEditingController(text: "***");
    cardHolderNameController = TextEditingController(text: "John Doe");
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    cardHolderNameController.dispose();
    super.dispose();
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

  void addToPantry(BuildContext context) {
    final appData = Provider.of<AppData>(context, listen: false);

    // Assuming each cart item has a default quantity of 1.0
    // You might want to adjust this logic based on your app's requirements
    for (var itemName in widget.cartItems) {
      appData.AddIngredient(Ingredient(
        name: itemName,
        ingredient_id: -1, // Use appropriate ID or logic
        cost: 0.0, // Update cost if available
        qty_available: 1.0, // Update quantity if different for each item
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Information'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: cardNumberController,
                decoration: InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: expiryDateController,
                decoration: InputDecoration(
                  labelText: 'Card Expiry Date (MM/YY)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: cvvController,
                decoration: InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: cardHolderNameController,
                decoration: InputDecoration(
                  labelText: 'Cardholder Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Place Order'),
                onPressed: () {
                  addToPantry(context);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Order Placed'),
                      content: Text('Your order has been placed successfully!'),
                      actions: [
                        TextButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }

                        ),
                        TextButton(
                          child: Text('Directions'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            _launchMapsUrl(widget.store.address);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
