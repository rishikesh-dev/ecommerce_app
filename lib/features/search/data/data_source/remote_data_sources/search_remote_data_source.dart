import 'dart:convert';

import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class SearchRemoteDataSource {
  final String baseUrl;
  SearchRemoteDataSource(this.baseUrl);
  Future<Either<Failure, List<ProductModel>>> search(String query) async {
    try {
      if (kDebugMode) {
        print('Search query: "$query"');
      }

      if (query.trim().isEmpty) {
        return right([]); // skip search if no query
      }

      final uri = Uri.parse('$baseUrl/products/search?q=$query');
      final response = await http.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        final products = decoded['products'] as List<dynamic>;

        final results = products
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();

        return right(results);
      } else {
        return left(Failure(message: 'Failed to load search results'));
      }
    } on Exception catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
