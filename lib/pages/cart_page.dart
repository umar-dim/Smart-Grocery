import 'package:flutter/material.dart';
import '../store/store.dart';
import 'checkout_page.dart';
import 'package:smart_grocery/appState.dart';

class CartPage extends StatelessWidget {
  final List<String> cartItems;
  final Store store;
  final Map<String, double> prices;

  const CartPage({Key? key, required this.cartItems, required this.store, required this.prices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double total = 0.0;
    for (var item in cartItems) {
      total += prices[item] ?? 0.0; // Calculate the total price
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: cartItems.length,
              separatorBuilder: (context, index) => Divider(color: Colors.grey),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: ListTile(
                  title: Text('${cartItems[index]} - \$${prices[cartItems[index]]?.toStringAsFixed(2)}'),
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total: \$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Background color
                    onPrimary: Colors.white, // Text Color (Foreground color)
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutPage(store: store, cartItems: cartItems,)),
                    );
                  },
                  child: Text(
                    'Checkout',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
