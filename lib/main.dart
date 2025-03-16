import 'package:app_backend/products_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insta Store',
      theme: ThemeData(
      primarySwatch: Colors.red,
        fontFamily: 'Raleway'
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Insta Store"),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: const ProductsPage(),
      ),
    );
  }
}

