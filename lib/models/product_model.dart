import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier{
   String? id;
   String? title;
   String? description;
   String? imageUrl;
   double? price;
   String? userId;
  bool? favorite ;

  ProductModel(
      { this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.price,
       required this.userId,
      this.favorite = false});


  void toggleFav(){
    favorite = !favorite!;
    notifyListeners();
}


   Map<String,dynamic> toMap(){
     Map<String,dynamic> data = <String,dynamic>{};
     data["title"] = title;
     data["description"] = description ;
     data["imageUrl"] = imageUrl;
     data["price"] = price;
     data["userId"] = userId;
     return data;
   }


   ProductModel.formDB(key,Map<String,dynamic> json){
   //TODO : convert from json to model
     print("fromdatabase : $key");
     id = key;
     title = json["title"].toString();
     description = json["description"];
     imageUrl = json["imageUrl"];
     price = json["price"];
     userId = json["userId"];

   }
}

