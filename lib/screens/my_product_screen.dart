import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/models/product_model.dart';
import 'package:shop_app_course/providers/product_provider.dart';
import 'package:shop_app_course/screens/edit_my_Product_screen.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({Key? key}) : super(key: key);
  static const routeName = "my_product_screen";

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = Provider.of<ProductProvider>(context).myProduct;
    return Scaffold(
        appBar: AppBar(title: Text("My Product"), actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, EditMyProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ]),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return  Provider.of<ProductProvider>(context,listen: false).loading ? CircularProgressIndicator() : ListTile(
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(products[index].imageUrl!),
              ),
              title: Text(products[index].title!),
              trailing: Row(mainAxisSize: MainAxisSize.min,
                children: [
                IconButton(onPressed: (){
                  Navigator.pushNamed(context, EditMyProductScreen.routeName,arguments: products[index]);
                }, icon: Icon(Icons.edit) ),
                IconButton(onPressed: (){
                  Provider.of<ProductProvider>(context,listen: false).deleteProduct(products[index]);
                }, icon: Icon(Icons.delete)),

              ],),
            );
          },
        ));
  }
}
