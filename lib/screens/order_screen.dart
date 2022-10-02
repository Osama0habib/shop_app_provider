import 'package:flutter/material.dart';
import 'package:shop_app_course/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routeName = "Order-screen";


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("My Orders"),),
        body: ListView.builder(itemBuilder:(ctx,index){
          return OrderItem();
        },itemCount: 3),);
  }
}
