import 'dart:convert';

import 'package:ecommerce_app/features/details/data/models/details_model.dart';
import 'package:http/http.dart' as http;

class DetailsRemoteDataSource {
  final String baseUrl;

  DetailsRemoteDataSource({required this.baseUrl});
  Future<DetailsModel> getDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode == 200) {
      return DetailsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load details');
    }
  }
}
