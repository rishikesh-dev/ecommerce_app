import 'package:ecommerce_app/core/entities/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({required super.name, required super.slug, required super.url});
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      slug: json['slug'],
      url: json['url'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'slug': slug, 'url': url};
  }
}
