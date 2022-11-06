import 'package:flutter/material.dart';
import 'package:shop_app_course/helper/dio_helper.dart';

import '../helper/const.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {

  // ProductProvider(this.token, this._productList);
  // String token;


  List<ProductModel> _myProduct = [];

  List<ProductModel> _productList = [
    // ProductModel(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //   'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // ProductModel(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //   'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // ProductModel(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //   'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // ProductModel(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //   'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<ProductModel> get product {
    return [..._productList];
  }

  List<ProductModel> get myProduct{
    return [..._myProduct];
  }


  List<ProductModel> get getFavList => product.where((element) => element.favorite == true).toList();

  ProductModel getById(id){
    return product.firstWhere((element) => element.id == id);
  }

  void addProduct(data){
    DioHelper dio = DioHelper();
    dio.postHttp(url: "product",data: data.toMap()) ;
    getMyProduct();


  }

//   Map<String,dynamic> map = {};
// map.forEach((key, value) {
//   ProductModel model = ProductModel(id: key,title: value["title"], description: value["disc"], imageUrl: imageUrl, price: price)
//
// })

Future<void> getProduct() async {
  DioHelper dio = DioHelper();
  await dio.getHttp(url:"product",).then((response) {
    print(response?.data);
  final data = response?.data as Map<String,dynamic> ;
  data.forEach((key, value) {
    _productList.add(ProductModel.formDB(key ,value));
  });
  notifyListeners();
  });
}

  Future<void> getMyProduct() async {
    // Map  query = {
    //   "orderBy" : "userId",
    //   "equalTo" : userId,
    // };
        // "orderBy='userId'&equalTo='oECydZReICXLVe1Pyp3rWYXply22'";

    DioHelper dio = DioHelper();
    await dio.getHttp(url:"product",query: 'orderBy="userId"&equalTo="$userUID"').then((response) {
      print("myProduct : ${response?.data}");
      final data = response?.data as Map<String,dynamic> ;
      _myProduct = [];
      data.forEach((key, value) {
        
        _myProduct.add(ProductModel.formDB(key ,value));
      });
      notifyListeners();
    });
  }
  void updateProduct(ProductModel data){
    print("update : ${data.toMap()}");
    DioHelper dio = DioHelper();
    dio.patchHttp(url: "product/${data.id}/",data: data.toMap()) ;
    getMyProduct();
    notifyListeners();
  }

  bool loading = false;
  Future<void> deleteProduct(data) async {
    loading = true;
    notifyListeners();
    DioHelper dio = DioHelper();
    await dio.deleteHttp(url: "product/${data.id}") ;
    await getMyProduct().then((value) {
      loading = false;
      notifyListeners();
    });
  }
}




