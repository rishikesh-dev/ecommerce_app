import 'package:ecommerce_app/core/entities/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.thumbnail,
    required super.category,
    required super.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'] as String,
      category: json['category'] as String,
      quantity: json['quantity'] ?? 1,
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      price: entity.price,
      thumbnail: entity.thumbnail,
      category: entity.category,
      quantity: entity.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'thumbnail': thumbnail,
      'category': category,
      'quantity': quantity + 1,
    };
  }

  @override
  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? thumbnail,
    double? price,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }
}
