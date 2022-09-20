import 'package:flutter/material.dart';
import 'package:shop_app_course/models/product_model.dart';
import 'package:shop_app_course/screens/product_details_screen.dart';

class GridItem extends StatelessWidget {
  const GridItem({Key? key,required this.product,}) : super(key: key);

  final ProductModel product ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context,ProductDetailsScreen.routeName,arguments: product);
        // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const ProductDetailsScreen(),settings: RouteSettings(arguments: product)));
      },
      child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20),
          child: GridTile(
            child: Image(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover),
            footer: GridTileBar(title: Text(product.title,style: TextStyle(fontSize: 12)),backgroundColor: Colors.black45,leading:  Icon(Icons.favorite_border,size: 16),trailing: Icon(Icons.shopping_cart_outlined,size: 16,),),
          )),
    );
  }
}
