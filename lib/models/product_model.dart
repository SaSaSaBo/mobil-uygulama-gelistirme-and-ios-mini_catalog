class Product {
  final String name;
  final String explanation;
  final String price;
  final String image;
  bool isFavorite;

  Product({
    required this.name,
    required this.explanation,
    required this.price,
    required this.image,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      explanation: json['explanation'],
      price: json['price'],
      image: json['image'],
    );
  }
}