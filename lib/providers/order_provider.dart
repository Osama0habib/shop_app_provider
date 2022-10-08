import 'package:flutter/material.dart';
import 'package:shop_app_course/helper/dio_helper.dart';
import 'package:shop_app_course/providers/cart_model.dart';

class OrderModel {
   String? id;
   List<CartModel>? product;
   double? amount;
   DateTime? dateTime;

  OrderModel(
      {required this.product,
      required this.amount,
      required this.id,
      required this.dateTime});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data["id"] = id;
    data["amount"] = amount;
    data["dateTime"] = dateTime.toString();
    data["product"] = [...product!.map((e) {
     return e.toMap();
    }).toList()];
    print("data : $data");
    return data;
  }

  OrderModel.fromMap(Map<String,dynamic> data) {
    id = data["id"] ;
    amount = data["amount"];
    dateTime = DateTime.parse(data["dateTime"]);
    product = data["product"];
  }
}



class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders {
    return [..._orders];
  }

  void addOrder(List<CartModel> cartProducts, double total) async {
    DioHelper dio = DioHelper();
    OrderModel order = OrderModel(
        id: DateTime.now().toString(),
        product: cartProducts,
        amount: total,
        dateTime: DateTime.now());
    dio.getHttp(url: "orders/1/",);
    _orders.insert(0, order);
    notifyListeners();
  }
}
