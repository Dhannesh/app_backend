import 'dart:math';

import 'package:app_backend/product_details.dart';
import 'package:app_backend/utils/http_utils.dart';
import 'package:flutter/material.dart';

import 'models/product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  var searchBoolean = false;
  var productCategory = "";
  late Future<List<Product>> productsFuture;
  Widget _searchTextField() {
    return TextField(
        onSubmitted: (value) {
          setState(() {
            productCategory = value;
          });
        },
        autofocus: true,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white, fontSize: 20),
        textInputAction: TextInputAction.search,
        decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white60, fontSize: 20)));
  }

  @override
  void initState() {
    super.initState();
    productsFuture = HttpUtils.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    if (productCategory.isEmpty) {
      productsFuture = HttpUtils.getProducts();
    } else {
      productsFuture = HttpUtils.getProductsForCategory(productCategory);
    }
    return Scaffold(
      appBar: AppBar(
        title: !searchBoolean ? const Text('Insta Store') : _searchTextField(),
        actions: !searchBoolean
            ? [
                IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        searchBoolean = true;
                      });
                    })
              ]
            : [
                IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        searchBoolean = false;
                        productCategory = "";
                      });
                    })
              ],
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder(
            future: productsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.all(12.0),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/products', arguments: {
                              'product_id': snapshot.data![index].id.toString()
                            });
                          },
                          child: Image.network(snapshot.data![index].image),
                        );
                      }),
                );
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
