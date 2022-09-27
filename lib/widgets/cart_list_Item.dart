import 'package:flutter/material.dart';
import 'package:shop_app_course/providers/cart_model.dart';

class CartListItem extends StatelessWidget {
  const CartListItem({Key? key, required this.cartITem}) : super(key: key);

  final CartModel cartITem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(cartITem.productModel.imageUrl!),
      ),
      title: Text(cartITem.productModel.title!),
      subtitle: Text(cartITem.productModel.price!.toString()),
      trailing: Text("${cartITem.itemCount.toString()}X"),

    );
  }
}
