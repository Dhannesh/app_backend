import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';

class HttpUtils {
  // static const String baseProductUri = "https://fakestoreapi.com/products";
  static const String baseProductUri = "http://192.168.1.5:4040/";
  static const JsonDecoder decoder = JsonDecoder();
  static const JsonEncoder encoder = JsonEncoder.withIndent(' ');

  static Future<Product> getProduct(String productId) async {
    // String productUri = "$baseProductUri/${Random().nextInt(19) + 1}";
    String productUri = "$baseProductUri/$productId";
    var response = await http.get(Uri.parse(productUri));
    if(response.statusCode == 200){
      // var object = decoder.convert(response.body);
      // var formattedJsonString = encoder.convert(object);

      return Product.fromJson(decoder.convert(response.body));
    }else
      {
        throw Exception("Failed to load");
      }
  }

  static Future<List<Product>> getProducts () async{
    var response = await http.get(Uri.parse(baseProductUri));
    if(response.statusCode == 200) {
     return compute(parseProducts, response.body);
    }else{
      throw Exception("Failed to load");
    }
  }

  static Future<List<Product>> getProductsForCategory(String category) async{
    String productUri = "$baseProductUri/category/$category";
    var response = await http.get(Uri.parse(productUri));
    if(response.statusCode == 200) {
      return compute(parseProducts, response.body);
    }else{
      throw Exception("Failed to load");
    }
  }

  static List<Product> parseProducts(String responseBody)
  {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  static Future<List<Product>> addProduct(Map<String, dynamic> product) async{
    final url = Uri.parse(baseProductUri);
    final headers = {"content-type":"application/json"};
    final res = await http.post(url, headers: headers, body: json.encode(product));
    if(res.statusCode == 200){
      return compute(parseProducts, res.body);
    }else{
      throw Exception("Failed to add product");
    }
  }

}
