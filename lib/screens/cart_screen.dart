import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/providers/cart_model.dart';
import 'package:shop_app_course/providers/order_provider.dart';

import '../models/product_model.dart';
import '../widgets/cart_list_Item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = "cart_screen";


  @override
  Widget build(BuildContext context) {
    CartProvider provider =Provider.of<CartProvider>(context,listen: true);
    List<CartModel> cartModel = provider.cartitem.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(child: Row(children: [Text("Total Price") ,Spacer(), Chip(label: Text("${provider.totalprice().toStringAsFixed(2)} EGP")) , TextButton(onPressed: () {

            Provider.of<OrderProvider>(context,listen: false).addOrder(cartModel, provider.totalprice());
            provider.clearCart();
          }, child: Text("Order Now"))],),),
        ),
        Expanded(
          child: ListView.builder(itemCount: cartModel.length,itemBuilder: (ctx,index) {
            return Dismissible(
              key: Key(cartModel[index].id),
              direction: DismissDirection.endToStart,
              background: Container(
                  color: Colors.red,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Icon(
                      Icons.delete_forever_sharp,
                      color: Colors.white,
                    ),
                  )),
              confirmDismiss: (direction) async {

                return await showDialog<bool>(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        actionsAlignment: MainAxisAlignment.spaceBetween,
                        title: Text("remove from cart"),
                        content: Text(
                            "are you sure you want ro remove ${cartModel[index].productModel.title} from your cart"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                ProductModel product = cartModel[index].productModel;
                                ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "you have just removed item ${product.title} from your cart "),
                                    action: SnackBarAction(
                                      label: "UNDO",
                                      onPressed: () {
                                        Provider.of<CartProvider>(context,listen: false).addToCart(product,context);
                                      },
                                    ),
                                  ),
                                );
                                return Navigator.pop(context, true);
                              },
                              child: Text("Sure")),
                        ],
                      );
                    });
              },
              onDismissed: (direction) {
                Provider.of<CartProvider>(context, listen: false)
                    .removeFromCart(cartModel[index].id);
              },
              child:  CartListItem(cartITem: cartModel[index]),
            );
              //
          }),
        ),

      ],),
    );
  }
}
