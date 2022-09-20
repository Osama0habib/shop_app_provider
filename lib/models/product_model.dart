class ProductModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool? favorite;

  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
      this.favorite});
}
