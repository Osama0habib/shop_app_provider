import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier{
   String? id;
   String? title;
   String? description;
   String? imageUrl;
   double? price;
  bool? favorite ;

  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
      this.favorite = false});


  void toggleFav(){
    favorite = !favorite!;
    notifyListeners();
}

}

