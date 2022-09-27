import 'package:flutter/cupertino.dart';
import 'package:shop_app_course/models/product_model.dart';

import '../models/product_model.dart';

class CartModel {
  String id;
  int itemCount;
  ProductModel productModel;
  double price;

  CartModel({required this.id, required this.itemCount, required this.productModel, required this.price});
}

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartitem = {};

  Map<String, CartModel> get cartitem {
    return {..._cartitem};
  }

  void addToCart(ProductModel product) {
    _cartitem.update(product.id!, (givinItem) {
      return CartModel(id:
          givinItem.id,itemCount:  givinItem.itemCount += 1,productModel:  givinItem.productModel,
          price: givinItem.itemCount * product.price!);
    }, ifAbsent: () {
      return CartModel(id: product.id!,itemCount:  1,productModel:  product,price:  product.price!);
    });
    notifyListeners();
    print(_cartitem);
  }

  double totalprice() {
    double total = 0.0;
    _cartitem.forEach((key, value) {
      total += value.price ;
    });
    return total ;
  }


}
