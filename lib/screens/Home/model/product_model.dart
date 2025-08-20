class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  final int? id;
  final String? title;
  final String? slug;
  final int? price;
  final String? description;
  final Category? category;
  final List<String> images;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      title: json["title"],
      slug: json["slug"],
      price: json["price"],
      description: json["description"],
      category: json["category"] == null
          ? null
          : Category.fromJson(json["category"]),
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
    );
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.slug,
  });

  final int? id;
  final String? name;
  final String? image;
  final String? slug;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      slug: json["slug"],
    );
  }
}