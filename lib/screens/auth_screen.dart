import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/home_screen.dart';
import 'package:shop_app_course/providers/auth_provider.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: 2250);
  static const routeName = "auth_screen";

  // Future<String?> _authUser(LoginData data) {
  //   debugPrint('Name: ${data.name}, Password: ${data.password}');
  //   return Future.delayed(loginTime).then((_) {
  //     if (!users.containsKey(data.name)) {
  //       return 'User not exists';
  //     }
  //     if (users[data.name] != data.password) {
  //       return 'Password does not match';
  //     }
  //     return null;
  //   });
  // }
  //
  // Future<String?> _signupUser(SignupData data) {
  //   debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
  //   return Future.delayed(loginTime).then((_) {
  //     return null;
  //   });
  // }
  //
  // Future<String?> _recoverPassword(String name) {
  //   debugPrint('Name: $name');
  //   return Future.delayed(loginTime).then((_) {
  //     if (!users.containsKey(name)) {
  //       return 'User not exists';
  //     }
  //     return null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'ECORP',
      // logo: Text("Shop APP"),
      onLogin: (LoginData data){
        Provider.of<AuthProvider>(context,listen: false).signIn(data);

      },
      onSignup: (SignupData data){
        Provider.of<AuthProvider>(context,listen: false).signUp(data);
      },
      onSubmitAnimationCompleted: () {
        if(Provider.of<AuthProvider>(context,listen: false).token.isNotEmpty){
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        }else{

        }
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => DashboardScreen(),
        // ));
      },
      onRecoverPassword: (_){},
    );
  }
}