import 'package:ecommerce_app/features/details/data/models/review_model.dart';
import 'package:ecommerce_app/features/details/domain/entity/details_entity.dart';

class DetailsModel extends DetailsEntity {
  DetailsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.tags,
    required super.brand,
    required super.sku,
    required super.weight,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required super.reviews,
    required super.returnPolicy,
    required super.minimumOrderQuantity,
    required super.images,
    required super.thumbnail,
    required super.quantity,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      tags: List<String>.from(json['tags'] ?? []),
      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      warrantyInformation: json['warrantyInformation'] ?? '',
      shippingInformation: json['shippingInformation'] ?? '',
      availabilityStatus: json['availabilityStatus'] ?? '',
      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((review) => ReviewModel.fromJson(review))
          .toList(),
      returnPolicy: json['returnPolicy'] ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 0,
      images: List<String>.from(json['images'] ?? []),
      thumbnail: json['thumbnail'] ?? '',
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((review) {
        if (review is ReviewModel) {
          return review.toJson();
        }
        return {}; // fallback if it's just a ReviewEntity
      }).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'images': images,
      'thumbnail': thumbnail,
      'quantity': quantity,
    };
  }
}
