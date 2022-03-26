import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/Pages/forgot_password.dart';
import 'package:money_management_app/Pages/home_page.dart';
import 'package:money_management_app/Pages/login_page.dart';
import 'package:money_management_app/Pages/signup_page.dart';
import 'package:money_management_app/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.signUp: (context) => SignUpPage(),
        MyRoutes.homePage: (context) => HomePage(),
        MyRoutes.forgotPassword: (context) => ForgotPassword(),
      },
    );
  }
}