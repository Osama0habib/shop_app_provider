import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/providers/cart_model.dart';
import 'package:shop_app_course/providers/product_provider.dart';
import 'package:shop_app_course/screens/cart_screen.dart';
import 'package:shop_app_course/screens/product_details_screen.dart';

import 'home_screen.dart';
import 'models/product_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


   return MultiProvider(
       providers: [
       ChangeNotifierProvider(
       create: (ctx) => ProductProvider(),),
       ChangeNotifierProvider(
       create: (ctx) => CartProvider(),),


   ],child: MaterialApp(
   debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
    // This is the theme of your application.
    //
    // Try running your application with "flutter run". You'll see the
    // application has a blue toolbar. Then, without quitting the app, try
    // changing the primarySwatch below to Colors.green and then invoke
    // "hot reload" (press "r" in the console where you ran "flutter run",
    // or simply save your changes to "hot reload" in a Flutter IDE).
    // Notice that the counter didn't reset back to zero; the application
    // is not restarted.
    primarySwatch: Colors.blue,
    ),
    routes: {
    ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
    HomeScreen.routeName: (ctx) => HomeScreen(),
    CartScreen.routeName: (ctx) => CartScreen(),
    },
    initialRoute: HomeScreen.routeName,
    ),);

  }
}
