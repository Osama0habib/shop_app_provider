import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/models/product_model.dart';
import 'package:shop_app_course/providers/product_provider.dart';
import 'package:shop_app_course/screens/cart_screen.dart';
import 'package:shop_app_course/screens/my_product_screen.dart';
import 'package:shop_app_course/screens/order_screen.dart';
import 'package:shop_app_course/widgets/grid_item.dart';
import 'package:shop_app_course/widgets/product_gridview.dart';
enum filter {allProduct,favorite}

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  static const routeName = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, CartScreen.routeName);
          }, icon: Icon(Icons.shopping_cart)),
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<filter>>[
              PopupMenuItem<filter>(
                value: filter.allProduct,
                child: Text("All Product"),
              ),
              PopupMenuItem<filter>(
                value: filter.favorite,
                child: Text("Favorite"),
              ),
            ],
            icon: Icon(Icons.menu),
            onSelected: (filter value) {
              print(value);
              if(value == filter.favorite){
                setState(() {
                  isFavorite = true;
                });
              }else{
                setState(() {
                  isFavorite = false;
                });
              }


            },
          )
        ],
      ),
      drawer: Drawer(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(),

          TextButton(child: Text("Orders"),onPressed: (){
            Navigator.pushNamed(context, OrderScreen.routeName );
          },),
          TextButton(child: Text("My Product"),onPressed: (){
            Navigator.pushNamed(context, MyProductScreen.routeName );
          },),
        ],
      )),
      body: ProductGridView( isFavorite: isFavorite,),
    );
  }
}
