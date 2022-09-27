import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/providers/cart_model.dart';

import '../widgets/cart_list_Item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = "cart_screen";


  @override
  Widget build(BuildContext context) {
    CartProvider provider =Provider.of<CartProvider>(context,listen: false);
    List cartModel = provider.cartitem.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(child: Row(children: [Text("Total Price") ,Spacer(), Chip(label: Text("${provider.totalprice().toStringAsFixed(2)} EGP")) , TextButton(onPressed: () {}, child: Text("Order Now"))],),),
        ),
        Expanded(
          child: ListView.builder(itemCount: cartModel.length,itemBuilder: (ctx,index) {
            return CartListItem(cartITem: cartModel[index]);
          }),
        ),

      ],),
    );
  }
}
