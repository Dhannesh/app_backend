import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';

class HttpUtils {
  static const String baseProductUri = "https://fakestoreapi.com/products";
  static const JsonDecoder decoder = JsonDecoder();
  static const JsonEncoder encoder = JsonEncoder.withIndent(' ');

  static Future<Product> getProduct() async {
    String productUri = "$baseProductUri/${Random().nextInt(19) + 1}";
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

}
