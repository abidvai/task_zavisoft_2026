import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/api_end_points.dart';
import '../model/product_model.dart';

/// This is the class responsible for talk with the backend that hey this app need data and call the backed to get data
/// Initially i use the try-case block i know it can be better error handling in future
class ProductService {
  Future<List<ProductModel>> fetchProduct() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.products),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        /// If we fetch many products then it can slow our ui rendering because of parsing here we can use compute to do multi-treading to avoid bad user experience.
        /// here it parse the data from json map to dart class by the help of factory constructor of Model class
        final List<ProductModel> products = data
            .map((product) => ProductModel.fromJson(product))
            .toList();

        /// returning the product list to waiter in our case it is our controller
        return products;
      } else {
        final error = jsonDecode(response.body);
        print(response.statusCode);
        return error;
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
