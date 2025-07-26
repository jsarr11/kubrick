class Product {
  final int id;
  final String nameEn;
  final String nameEl;
  final bool isActive;
  final double price;
  final String descriptionEn;
  final String descriptionEl;
  final String image;

  Product({
    required this.id,
    required this.nameEn,
    required this.nameEl,
    required this.isActive,
    required this.price,
    required this.descriptionEn,
    required this.descriptionEl,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nameEn: json['name-en'],
      nameEl: json['name-el'],
      isActive: json['isActive'],
      price: (json['price'] as num).toDouble(),
      descriptionEn: json['description-en'],
      descriptionEl: json['description-el'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name-en': nameEn,
    'name-el': nameEl,
    'isActive': isActive,
    'price': price,
    'description-en': descriptionEn,
    'description-el': descriptionEl,
    'image': image,
  };
}
