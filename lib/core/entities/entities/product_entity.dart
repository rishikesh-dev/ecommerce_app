class ProductEntity {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  final String category;
  final int quantity;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.category,
    this.quantity = 1,
  });

  ProductEntity copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? thumbnail,
    String? category,
    int? quantity,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
