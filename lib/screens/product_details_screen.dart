import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/models/product_model.dart';
import 'package:shop_app_course/providers/cart_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  static const routeName = "product_details";

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)?.settings.arguments as ProductModel;

    return Scaffold(
      appBar: AppBar(

        title: Text(product.title!),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(product.imageUrl!),
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(product.title!),
              ),
              Positioned(child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.favorite),
              ),bottom: -25,right:20),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [Text("Price : "), Text(product.price.toString())],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Description"),
              SizedBox(
                height: 20,
              ),
              Card(
                child: Text(product.description!),
              ),
              SizedBox(height: 300,)
            ],
          )
        ]),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: MaterialButton(
            color: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              Provider.of<CartProvider>(context,listen: false).addToCart(product, context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.shopping_cart), Text("Add to cart")],
            )),
      ),
    );
  }
}
