import 'dart:convert';
import 'package:http/http.dart' as http;

import '../core/api_end_points.dart';
import '../model/product_model.dart';

class ProductService {
  Future<List<ProductModel>> fetchProduct() async {
    try {
      final response = await http.get(
        Uri.parse(ApiEndPoints.BASE_URL + ApiEndPoints.products),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        /// If we fetch many products then it can slow our ui rendering because of parsing here we can use compute to do multi-treading to avoid bad user experience.
        final List<ProductModel> products = data
            .map((product) => ProductModel.fromJson(product))
            .toList();

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
