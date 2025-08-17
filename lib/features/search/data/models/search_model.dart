import 'package:ecommerce_app/features/search/domain/entities/search_entity.dart';

class SearchModel extends SearchEntity {
  SearchModel({required super.query});
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      query: json['query'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {'query': query};
  }
}
