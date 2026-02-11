import 'package:mini_product_showcase_app/features/products/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    super.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      price: (json["price"] as num).toDouble(),
      description: json["description"],
      category: json["category"],
      image: json["image"],
      rating: json["rating"] == null
          ? null
          : Rating(
              rate: (json["rating"]["rate"] as num).toDouble(),
              count: json["rating"]["count"],
            ),
    );
  }
}
