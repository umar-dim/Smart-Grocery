import 'package:flutter/material.dart';
import 'package:smart_grocery/pages/home_page.dart';

class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recommendations"),
        actions: [IconButton(onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }, icon: Icon(Icons.home))
        ],
      ),
      body: Center(
        child: Text(
          "Uh-oh! No Recommendations found.\n Please check back Later.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 45, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
