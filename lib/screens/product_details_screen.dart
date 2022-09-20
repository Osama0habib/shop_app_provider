import 'package:flutter/material.dart';
import 'package:shop_app_course/models/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);


  static const routeName = "product_details";
  @override
  Widget build(BuildContext context) {
 ProductModel product = ModalRoute.of(context)?.settings.arguments as ProductModel;

    return Scaffold(appBar: AppBar(title: Text(product.title),));
  }
}
