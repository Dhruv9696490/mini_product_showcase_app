import 'package:mini_product_showcase_app/features/products/domain/entities/product.dart';

class ProductLocalModel extends Product {
  const ProductLocalModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.category,
    required super.image,
    super.rating,
    required super.isFavorite,
  });

  factory ProductLocalModel.fromMap(Map<String, dynamic> map) {
    return ProductLocalModel(
      id: map["id"],
      title: map["title"],
      price: map["price"],
      description: map["description"],
      category: map["category"],
      image: map["image"],
      rating: Rating(
        rate: map["rate"],
        count: map["count"],
      ),
      isFavorite: map["isFavorite"] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "price": price,
      "description": description,
      "category": category,
      "image": image,
      "rate": rating?.rate,
      "count": rating?.count,
      "isFavorite": isFavorite ? 1 : 0,
    };
  }
    factory ProductLocalModel.fromEntity(Product product) {
    return ProductLocalModel(
      id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      category: product.category,
      image: product.image,
      rating: product.rating,
      isFavorite: product.isFavorite,
    );
  }
}

