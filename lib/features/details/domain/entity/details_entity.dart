import 'package:ecommerce_app/core/entities/entities/product_entity.dart';
import 'package:ecommerce_app/features/details/domain/entity/review_entity.dart';

class DetailsEntity extends ProductEntity {
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final num weight;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<ReviewEntity> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final List<String> images;

  DetailsEntity({
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.images,
    required super.thumbnail,
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.category,
    required super.quantity,
  });
  @override
  DetailsEntity copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? thumbnail,
    String? category,
    int? quantity,
    double? discountPercentage,
    double? rating,
    int? stock,
    List<String>? tags,
    String? brand,
    String? sku,
    num? weight,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    List<ReviewEntity>? reviews,
    String? returnPolicy,
    int? minimumOrderQuantity,
    List<String>? images,
  }) {
    return DetailsEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      tags: tags ?? this.tags,
      brand: brand ?? this.brand,
      sku: sku ?? this.sku,
      weight: weight ?? this.weight,
      warrantyInformation: warrantyInformation ?? this.warrantyInformation,
      shippingInformation: shippingInformation ?? this.shippingInformation,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      reviews: reviews ?? this.reviews,
      returnPolicy: returnPolicy ?? this.returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
      images: images ?? this.images,
    );
  }
}
