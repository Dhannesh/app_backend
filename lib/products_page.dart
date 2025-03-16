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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetails()));
                },
                child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Fetch Product Details',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(
            productInfoResult,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ))
      ],
    );
  }
}
