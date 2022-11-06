import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static Future<void> initialize()async{
    prefs = await SharedPreferences.getInstance();

  }


 static Future<void> saveCache(key,value)async{
    print("key : $key , value : $value" );
    print("runtimeType ${value.runtimeType}");
    switch(value.runtimeType){
      case String :{
       await prefs.setString(key, value);
      }
      break;
      case int :{
        await prefs.setInt(key, value);

      }
      break;
      case bool :{
        await prefs.setBool(key, value);

      }
      break;
      case double :{
        await prefs.setDouble(key, value);

      }
      break;
      default:{
        await prefs.setStringList(key, value);
      }
    }
  }

 static dynamic getCache(key)async{
      return prefs.get(key);
    }


}