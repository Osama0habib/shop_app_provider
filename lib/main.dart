import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/helper/cache_helper.dart';
import 'package:shop_app_course/helper/const.dart';
import 'package:shop_app_course/providers/auth_provider.dart';
import 'package:shop_app_course/providers/cart_model.dart';
import 'package:shop_app_course/providers/order_provider.dart';
import 'package:shop_app_course/providers/product_provider.dart';
import 'package:shop_app_course/screens/auth_screen.dart';
import 'package:shop_app_course/screens/cart_screen.dart';
import 'package:shop_app_course/screens/edit_my_Product_screen.dart';
import 'package:shop_app_course/screens/my_product_screen.dart';
import 'package:shop_app_course/screens/order_screen.dart';
import 'package:shop_app_course/screens/product_details_screen.dart';

import 'home_screen.dart';
import 'models/product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.initialize();
  AuthModel? user;
  String? token;
  print("token bool ${CacheHelper.prefs.containsKey("token")}");
  print("userData bool ${CacheHelper.prefs.containsKey("userData")}");

  if (CacheHelper.prefs.containsKey("token")) {
    print("first token $token");

    token = await CacheHelper.getCache("token");
  }

  if (CacheHelper.prefs.containsKey("userData")) {
    print(await CacheHelper.getCache("userData"));

    String userData = await CacheHelper.getCache("userData");

    user = AuthModel.fromJson(json.decode(userData));
  }
  print("token : $token");

  runApp(MyApp(
    token: token,
    user: user,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, this.token, this.user}) : super(key: key);

  String? token;
  AuthModel? user;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    userUID = user?.userId;
    print("userUIDddd $userUID");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(token, user),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ProductProvider()..getMyProduct(),),
        // ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
        //     create: (ctx) => ProductProvider(token != null ? token! : "", []),
        //     update: (ctx, auth, prevousProduct) => ProductProvider(auth.token!,prevousProduct!.product)),
        ChangeNotifierProvider(
          create: (ctx) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
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
        home: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            // print("email :${provider.user?.email}");
            return provider.isAuth ? HomeScreen() : LoginScreen();
          },
        ),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          MyProductScreen.routeName: (ctx) => MyProductScreen(),
          EditMyProductScreen.routeName: (ctx) => EditMyProductScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
        },
      ),
    );
  }
}
