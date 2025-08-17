import 'dart:convert';
import 'package:ecommerce_app/core/failures/failure.dart';
import 'package:ecommerce_app/features/home/data/models/category_model.dart';
import 'package:ecommerce_app/core/entities/entities/category_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class CategoryRemoteDataSource {
  final String baseUrl;

  CategoryRemoteDataSource({required this.baseUrl});

  /// Get categories
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/categories'),
      );
      if (response.statusCode != 200) {
        return left(Failure(message: 'Failed to load categories'));
      }

      final decoded = jsonDecode(response.body);
      if (decoded is List) {
        final categories = decoded
            .map((item) => CategoryModel.fromJson(item))
            .toList();
        return right(categories);
      }
      return left(Failure(message: 'Unexpected response format'));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Future<Either<Failure, List<CategoryEntity>>> filterProductByCategory(
    String categoryName,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products?category=$categoryName'),
      );
      if (response.statusCode != 200) {
        return left(Failure(message: 'Failed to load products'));
      }

      final decoded = jsonDecode(response.body);
      if (decoded is List) {
        final products = decoded
            .map((item) => CategoryModel.fromJson(item))
            .toList();
        return right(products);
      }
      return left(Failure(message: 'Unexpected response format'));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
