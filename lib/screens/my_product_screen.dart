import 'package:flutter/material.dart';
import 'package:shop_app_course/screens/edit_my_Product_screen.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({Key? key}) : super(key: key);
  static const routeName = "my_product_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("My Product"),
            actions: [IconButton(onPressed: () {
              Navigator.pushNamed(context, EditMyProductScreen.routeName);
            }, icon: Icon(Icons.add))]),
        body: ListView.builder(itemCount : 4,itemBuilder: (BuildContext context, int index) {
          return Container();
        },));
  }
}
