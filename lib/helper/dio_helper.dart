import 'package:dio/dio.dart';

class DioHelper {
  Future<Response?> getHttp({url,query}) async {
    try {
      return await Dio().get(
        "https://shopapp-course-b43f8-default-rtdb.firebaseio.com/${url}.json?$query",
        );
      // print("response : $response");
    } catch (error) {
      return null;
      // print(e);
    }
  }

  void patchHttp({url, data}) async {
    try {
      var response = await Dio().patch(
          "https://shopapp-course-b43f8-default-rtdb.firebaseio.com/${url}.json",
          data: data);
      print(response);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteHttp({url, data}) async {
    try {
      var response = await Dio().delete(
          "https://shopapp-course-b43f8-default-rtdb.firebaseio.com/${url}.json",
          data: data);
      print(response);
    } catch (e) {
      print(e);
    }
  }

  void postHttp({url, data}) async {
    try {
      var response = await Dio().post(
          "https://shopapp-course-b43f8-default-rtdb.firebaseio.com/${url}.json",
          data: data);
      print(response);
    } catch ( e) {
      print(e);
    }
  }

//   Future<Response> uploadImage({}) async{
//
//     await Dio().post("prodcut",data: ,options: Options(contentType: "multipart/form-data",));
//     return
// }

  Future<Response?> authPost({url, data}) async {
    try {
      return await Dio().post(
          "https://identitytoolkit.googleapis.com/v1/accounts:$url?key=AIzaSyDZ6aV3Sh3SBNsiOsTICP8FbDEgc1D45kA",
          options: Options(
              contentType: "application/json",
              responseType: ResponseType.json,
              receiveDataWhenStatusError: true,
              headers: {
                "contentType": "application/json",
                "Accept" : "*/*",
                "Accept-Encoding" : "gzip, deflate, br"
              }),
          data: data);
    } catch (e) {
     DioError error = e as DioError;
     print("error : ${error.response?.data}");
     throw error;
    }
  }
}
