import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smart_grocery/appState.dart';
import 'package:smart_grocery/databaseHelper.dart'; // Import your DatabaseHelper file
import 'package:smart_grocery/pages/login_page.dart';

void main() {
  DatabaseHelper.instance;
  runApp(
      ChangeNotifierProvider(create: (context) => AppData(), child: MyApp()));
}

Color c = const Color(0x726fddff);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color mainPurple = Color(0xFF736DDC); // Your RGB color
    MaterialColor purple = createMaterialColor(mainPurple);
    Color accentBlue = Color(0x309AB2);
    MaterialColor blue = createMaterialColor(accentBlue);


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Grocery',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: purple).copyWith(secondary: blue),
        textTheme: GoogleFonts.breeSerifTextTheme(Theme.of(context).textTheme),
      ),
      home: const LoginPage(),
    );
  }
}


MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((r - ds < 0 ? r : ds) * (ds < 0 ? -1 : 1)).round(),
      g + ((g - ds < 0 ? g : ds) * (ds < 0 ? -1 : 1)).round(),
      b + ((b - ds < 0 ? b : ds) * (ds < 0 ? -1 : 1)).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
