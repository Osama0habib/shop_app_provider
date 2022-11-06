import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shop_app_course/helper/cache_helper.dart';
import 'package:shop_app_course/helper/const.dart';
import 'package:shop_app_course/helper/dio_helper.dart';

class AuthModel {
  late final String? userId;
  late final String? email;
  late final String? name;
  late final DateTime? expiresIn;

  AuthModel(
      {this.userId,
       this.email,
       this.name,
       this.expiresIn});


  Map<String,dynamic> toJson(){
   Map<String,dynamic> data= {};
   data["name"] = name;
   data["email"] = email;
   data["userId"] = userId;
   data["expiresIn"] = expiresIn?.toIso8601String();
   return data;

  }

  AuthModel.fromJson(data){
    name = data["name"];
    email = data["email"];
    userId = data["userId"];
    expiresIn = DateTime.tryParse(data["expiresIn"]);
  }
}

class AuthProvider with ChangeNotifier {

  AuthProvider(this._token,this.user);
  String? _token ;
  String errorMessage = "";
  AuthModel? user = AuthModel();

  bool get isAuth {
    return token != null;
  }

  DateTime? get expiryDate {
    return user?.expiresIn;
  }

  String? get token {
    if (user?.expiresIn != null &&
        user!.expiresIn!.isAfter(DateTime.now()) && _token != null) {
      return _token;
    } else {
      return null;
    }
  }

  String? get userId {
    return user?.userId!;
  }




  Future<void> signUp(SignupData data) async {
    DioHelper dio = DioHelper();
    print(data.additionalSignupData);
    await dio.authPost(url: "signUp", data: {
      "email": data.name,
      "password": data.password,
      "displayName" : data.additionalSignupData?.values.first,
      "returnSecureToken": true,
    }).then((value) async {
      print("value : $value");
     user = AuthModel(
          name: value?.data["displayName"],
          userId: value?.data["localId"],
          expiresIn: DateTime.now().add(Duration(seconds: int.parse(value?.data["expiresIn"]))),
          email: value?.data["email"]);
      _token = value?.data["idToken"];
      final userData = json.encode(user?.toJson());

     await CacheHelper.saveCache("userData", userData);
     await CacheHelper.saveCache("token", _token);

    }).catchError((error) {
      print("error1 : ${error.response?.data["error"]["message"]}");

      errorMessage = error.response?.data["error"]["message"];
    });
  }

  Future<void> signIn(LoginData data) async {
    DioHelper dio = DioHelper();
    await dio.authPost(url: "signInWithPassword", data: {
      "email": data.name,
      "password": data.password,
      "returnSecureToken": true,
    }).then((value) async {
      print("value : $value");
     user = AuthModel(
          name: value?.data["displayName"],
          userId: value?.data["localId"],
          expiresIn: DateTime.now().add(Duration(seconds: int.parse(value?.data["expiresIn"]))),
          email: value?.data["email"]);
      // print("token : ${value?.data["idToken"]}");

      _token = value?.data["idToken"];
      final userData = json.encode(user?.toJson());
      await CacheHelper.saveCache("userData", userData);
      await CacheHelper.saveCache("token", _token);
    }).catchError((error) {
        if(error is DioError){
          print("error1 : ${error.response?.data["error"]["message"].toString()}");
          errorMessage = error.response?.data["error"]["message"];

        }else{
          print(error);
        }

    });
  }


 // Future<void> getUserData() async {
 //    if(token != null){
 //      DioHelper dio = DioHelper();
 //      await dio.authPost(url: "lookup", data: {
 //        "idToken": _token,
 //
 //      }).then((value) {
 //        print("value : $value");
 //        user = AuthModel(
 //            name: value?.data["users"][0]["displayName"],
 //            userId: value?.data["users"][0]["localId"],
 //            // expiresIn: DateTime.now().add(Duration(seconds: int.parse(value?.data["users"][0]["expiresIn"]))),
 //            email: value?.data["users"][0]["email"]);
 //        // _token = value?.data["users"][0]["idToken"];
 //        userUID = user?.userId!;
 //      }).catchError((error) {
 //        print(error);
 //        // print("error1 : ${error.response?.data["error"]["message"]}");
 //
 //        // errorMessage = error.response?.data["error"]["message"];
 //      });
 //    }
 //
 // }

  Future<void> logout() async {
    _token = null;
    CacheHelper.prefs.clear();
    notifyListeners();
  }
}
