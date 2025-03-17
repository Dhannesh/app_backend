import 'package:app_backend/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Product productFuture;

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)?.settings.arguments as Map;
    productFuture = arguments['product'] as Product;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Product Details"),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              productFuture.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 300,
            height: 300,
            child: Image.network(productFuture.image),
          ),

          Container(
            alignment: Alignment.center,
            child: Text(
              'Buy @ \$${productFuture.price}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: Text(productFuture.category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))),
          Container(
              alignment: Alignment.center,
              child: RatingBarIndicator(
                rating: productFuture.rating,
                itemCount: 5,
                itemSize: 60.0,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              )),
          Container(
            padding: EdgeInsets.all(12.0),
            alignment: Alignment.center,
            child: Text(
              productFuture.description,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.justify,
            ),
          ),
        ]));
  }
}
