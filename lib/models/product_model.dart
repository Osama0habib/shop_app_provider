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


   Map<String,dynamic> toMap(){
     Map<String,dynamic> data = <String,dynamic>{};
     data["id"] = id;
     data["title"] = title;
     data["description"] = description ;
     data["imageUrl"] = imageUrl;
     data["price"] = price;
     return data;
   }

}

