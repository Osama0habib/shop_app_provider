import 'package:dio/dio.dart';

class DioHelper {

  void getHttp({url}) async {
    try {
      var response = await Dio().get("https://shopapp-course-b43f8-default-rtdb.firebaseio.com/${url}.json");
      print("response : $response");
    } catch (e) {
      print(e);
    }
  }

  void postHttp({url,data}) async {
    try {
      var response = await Dio().patch("https://shopapp-course-b43f8-default-rtdb.firebaseio.com/${url}.json",data: data);
      print(response);
    } catch (e) {
      print(e);
    }
  }


}
