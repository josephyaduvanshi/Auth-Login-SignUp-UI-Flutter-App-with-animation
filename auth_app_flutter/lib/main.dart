import 'package:flutter/material.dart';
import 'package:auth_app_flutter/Screens/forgot_password.dart';
import 'package:auth_app_flutter/Screens/home_screen.dart';
import 'package:auth_app_flutter/Screens/login_screen.dart';
import 'package:auth_app_flutter/Screens/signup.dart';
import 'package:auth_app_flutter/Utilities/routes.dart';

void main() => runApp(const AuthApp());

class AuthApp extends StatelessWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        MyRoutes.homeScreen: (context) => HomeScreen(),
        MyRoutes.loginScreen: (context) => LoginScreen(),
        MyRoutes.signUp: (context) => SignUp(),
        MyRoutes.forgotPassword: (context) => ForgotPassword(),
      },
    );
  }
}
