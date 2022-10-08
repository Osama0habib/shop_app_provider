import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/helper/dio_helper.dart';
import 'package:shop_app_course/providers/order_provider.dart';
import 'package:shop_app_course/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routeName = "Order-screen";


  @override
  Widget build(BuildContext context) {
    DioHelper dio = DioHelper();
    dio.getHttp(url: "orders/1");
    List<OrderModel> orderList = Provider.of<OrderProvider>(context,listen: false).orders;
    return Scaffold(appBar: AppBar(title: Text("My Orders"),),
        body: ListView.builder(itemBuilder:(ctx,index){
          return OrderItem(order :orderList[index]);
        },itemCount: orderList.length),);
  }
}
