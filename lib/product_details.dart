import 'package:app_backend/models/product.dart';
import 'package:app_backend/utils/http_utils.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Future<Product> productFuture;
  @override
  void initState() {
    super.initState();
    productFuture = HttpUtils.getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<Product>(
            future: productFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    alignment: Alignment.center,
                    child: Text(
                      snapshot.data!.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
