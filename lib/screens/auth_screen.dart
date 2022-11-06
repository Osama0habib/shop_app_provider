import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_course/home_screen.dart';
import 'package:shop_app_course/providers/auth_provider.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: 2250);
  static const routeName = "auth_screen";


  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      loginAfterSignUp: true,

      additionalSignupFields: const [
        UserFormField(keyName: "Username",userType: LoginUserType.name),

      ],
      title: 'Shop App',

      // logo: Text("Shop APP"),
      onLogin: (LoginData data) async {

     return  await Provider.of<AuthProvider>(context,listen: false).signIn(data).then((value) {
         if(Provider.of<AuthProvider>(context,listen: false).token == null ){
           return Provider.of<AuthProvider>(context,listen: false).errorMessage;
         }else{
           return null;
         }
       });

      },
      onSignup: (SignupData data) async {
        return  await Provider.of<AuthProvider>(context,listen: false).signUp(data).then((value) {
          if(Provider.of<AuthProvider>(context,listen: false).token == null ){
            return Provider.of<AuthProvider>(context,listen: false).errorMessage;
          }else{
            return null;
          }
        });      },
      onSubmitAnimationCompleted: () {
        print(Provider.of<AuthProvider>(context,listen: false).token);
        if(Provider.of<AuthProvider>(context,listen: false).token != null  ){
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        }
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => DashboardScreen(),
        // ));
      },
      onRecoverPassword: (_){

      },
    );
  }
}