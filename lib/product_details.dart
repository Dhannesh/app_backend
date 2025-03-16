import 'package:app_backend/models/product.dart';
import 'package:app_backend/utils/http_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Future<Product> productFuture;
  // @override
  // void initState() {
  //   super.initState();
  //   productFuture = HttpUtils.getProduct();
  // }

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)?.settings.arguments as Map;
    var productId = arguments['product_id'] as String;
    productFuture = HttpUtils.getProduct(productId);
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
                return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          snapshot.data!.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.network(snapshot.data!.image),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Buy @ \$${snapshot.data!.price}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: Text(snapshot.data!.category,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ))),
                      Container(
                          alignment: Alignment.center,
                          child: RatingBarIndicator(
                            rating: snapshot.data!.rating,
                            itemCount: 5,
                            itemSize: 60.0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ))
                    ]);
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
