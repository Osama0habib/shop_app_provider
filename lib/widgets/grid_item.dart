import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/models/product_model.dart';
import 'package:shop_app_course/providers/product_provider.dart';
import 'package:shop_app_course/screens/product_details_screen.dart';

class GridItem extends StatelessWidget {
  const GridItem({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductModel product = Provider.of<ProductModel>(context,listen: false);
    // Provider.of<ProductProvider>(context).getById(product.id);
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        footer: GridTileBar(title: Text(product.title!,style: TextStyle(fontSize: 12)),backgroundColor: Colors.black45,leading:  Consumer<ProductModel>(
  builder: (context, provider, child) {
  return GestureDetector(onTap: (){
    provider.toggleFav();
        },child: Icon(provider.favorite == true? Icons.favorite :Icons.favorite_border,size: 16));
  },
),trailing: Icon(Icons.shopping_cart_outlined,size: 16,),),
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context,ProductDetailsScreen.routeName,arguments: product);
            // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const ProductDetailsScreen(),settings: RouteSettings(arguments: product)));
          },
          child: Image(
                image: NetworkImage(product.imageUrl!),
                fit: BoxFit.cover),
        ),
      ),
    );
  }
}
