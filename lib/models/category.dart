import './product.dart';

class Categories {
  final int id;
  final String nameEn;
  final String nameEl;
  final int displayOrder;
  final String image;
  final List<Product> products;

  Categories({
    required this.id,
    required this.nameEn,
    required this.nameEl,
    required this.displayOrder,
    required this.image,
    required this.products,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    var productsJson = json['products'] as List<dynamic>;
    List<Product> productsList = productsJson
        .map((p) => Product.fromJson(p))
        .toList();

    return Categories(
      id: json['id'],
      nameEn: json['name-en'],
      nameEl: json['name-el'],
      displayOrder: json['display_order'],
      image: json['image'],
      products: productsList,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name-en': nameEn,
    'name-el': nameEl,
    'display_order': displayOrder,
    'image': image,
    'products': products.map((p) => p.toJson()).toList(),
  };
}
