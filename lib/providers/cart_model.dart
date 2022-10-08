import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_course/models/product_model.dart';

import '../models/product_model.dart';

class CartModel {
  String id;
  int itemCount;
  ProductModel productModel;
  double price;

  CartModel(
      {required this.id,
      required this.itemCount,
      required this.productModel,
      required this.price});


  Map<String,dynamic> toMap(){
    Map<String,dynamic> data = <String,dynamic>{};
    data["id"] = id;
    data["itemCount"] = itemCount;
    data["price"] = price ;
    data["product"] = productModel.toMap();
    print("cartModel map : $data");
    return data;
  }
}

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartitem = {};

  Map<String, CartModel> get cartitem {
    return {..._cartitem};
  }

  void addToCart(ProductModel product, context) {
    _cartitem.update(product.id!, (givinItem) {
      return CartModel(
          id: givinItem.id,
          itemCount: givinItem.itemCount += 1,
          productModel: givinItem.productModel,
          price: givinItem.itemCount * product.price!);
    }, ifAbsent: () {
      return CartModel(
          id: product.id!,
          itemCount: 1,
          productModel: product,
          price: product.price!);
    });
    ScaffoldMessenger.maybeOf(context)?.clearSnackBars();
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(
        content: Text(
            "You have just added ${product.title} ${_cartitem[product.id]?.itemCount}X") ,action: SnackBarAction(onPressed: (){
              removeSingleItem(product.id,context);
    },label: "UNDO"),));


    notifyListeners();
    print(_cartitem);
  }

  double totalprice() {
    double total = 0.0;
    _cartitem.forEach((key, value) {
      total += value.price;
    });
    return total;
  }

  void removeFromCart(id) {
    _cartitem.remove(id);
    notifyListeners();
  }

  void removeSingleItem(id,context) {
    _cartitem.forEach((key, value) {
      if (key == id) {
        if (value.itemCount > 1) {
          _cartitem.update(id, (value) {
            return CartModel(
                price: value.price,
                productModel: value.productModel,
                id: value.id,
                itemCount: value.itemCount - 1);
          });
          notifyListeners();
        } else {
          removeFromCart(id);
          ScaffoldMessenger.maybeOf(context)?.clearSnackBars();

        }
      }
    });
  }

  void clearCart(){
    _cartitem.clear();
    notifyListeners();
  }
}
