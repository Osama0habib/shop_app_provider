import 'package:flutter/cupertino.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shop_app_course/helper/dio_helper.dart';

class AuthModel {


}

class AuthProvider with ChangeNotifier{


  String token = "" ;
  void signUp(SignupData data){

    DioHelper dio = DioHelper();
    dio.authPost(url : "signUp",data: {
      "email" : data.name,
      "password" : data.password,
      "returnSecureToken" : true,
    }).then((value) {
     token = value?.data["idToken"];
    });
  }

  void signIn(LoginData data){
    DioHelper dio = DioHelper();
    dio.authPost(url : "signInWithPassword",data: {
      "email" : data.name,
      "password" : data.password,
      "returnSecureToken" : true,
    }).then((value) {
      token = value?.data["idToken"];
    });


  }

}