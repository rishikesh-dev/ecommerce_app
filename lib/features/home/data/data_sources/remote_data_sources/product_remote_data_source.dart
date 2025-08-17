import 'dart:convert';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/core/models/product_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDataSource {
  final String baseUrl;

  ProductRemoteDataSource({required this.baseUrl});

  /// Get all products
  Future<Either<Failure, List<ProductModel>>> getProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      if (response.statusCode != 200) {
        return left(Failure(message: 'Failed to load products'));
      }

      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic> && decoded['products'] is List) {
        final result = (decoded['products'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
        return right(result);
      }
      return left(Failure(message: 'Invalid API response format'));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  /// Search products by query
  Future<Either<Failure, List<ProductModel>>> searchProducts(
    String query,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/search?q=$query'),
      );
      if (response.statusCode != 200) {
        return left(Failure(message: 'Search failed'));
      }

      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic> && decoded['products'] is List) {
        final result = (decoded['products'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
        return right(result);
      }
      return left(Failure(message: 'Invalid search response format'));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  /// Get product by ID
  Future<Either<Failure, ProductModel>> getProductById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/$id'));
      if (response.statusCode != 200) {
        return left(Failure(message: 'Failed to load product'));
      }

      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) {
        return right(ProductModel.fromJson(decoded));
      }
      return left(Failure(message: 'Invalid API response format'));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
