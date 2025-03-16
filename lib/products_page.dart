import 'dart:math';

import 'package:app_backend/product_details.dart';
import 'package:app_backend/utils/http_utils.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String productInfoResult = "No prouct details yet";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 12,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                onPressed: () {
                  Navigator.pushNamed(
                      context,'/products',
                    arguments: {'product_id': '${Random().nextInt(19) + 1}'}
                      );
                },
                child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Fetch Product Details',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            )),

      ],
    );
  }
}
