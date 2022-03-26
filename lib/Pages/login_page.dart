import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management_app/Pages/home_page.dart';
import 'package:money_management_app/routes/routes.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //form_key
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  // firebase
  final _auth = FirebaseAuth.instance;
  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      'assets/images/welcomeanimation.gif',
                      height: 320,
                      width: 320,
                      alignment: Alignment.center,
                    ),
                  ),
                  Text(
                    'Hello Thrifter!',
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Text(
                    'Login to continue thrifting Pal!',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          autofocus: false,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            hintText: 'Enter Your Email',
                            filled: true,
                            prefixIcon: Icon(IconlyBold.message),
                            labelText: 'Email',
                          ),
                          validator: Validators.compose([
                            Validators.required(
                                'Email can\'t be empty, Please enter your Email.'),
                            Validators.email(
                                'Please, Enter a valid Email Address!'),
                          ]),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 28.0,
                          ),
                        ),
                        TextFormField(
                          obscureText: true,
                          autofocus: false,
                          controller: passwordController,
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  20.0,
                                ),
                              ),
                            ),
                            filled: true,
                            prefixIcon: Icon(IconlyBold.password),
                            hintText: 'Enter Your Password',
                            labelText: 'Password',
                          ),
                          validator: Validators.required(
                              'Password can\'t be empty, Please enter your Password.'),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, MyRoutes.forgotPassword);
                            },
                            child: const Text(
                              'Forgot Password?',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 0,
                          width: 0,
                        ),
                        InkWell(
                          onTap: (() {
                            signIn(
                                emailController.text, passwordController.text);
                          }),
                          child: Container(
                            width: 150,
                            height: 40,
                            alignment: Alignment.center,
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade500,
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: (() {
                                Navigator.pushNamed(context, MyRoutes.signUp);
                              }),
                              child: const Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  // Fluttertoast.showToast(msg: "Login Successful"),
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Logged in successfully!'),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.blue,
                    behavior: SnackBarBehavior.floating,
                  )),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage())),
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "auth/invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "invalid-credential":
            errorMessage = "Invalid Credentials.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          case "ERROR_INVALID_EMAIL":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "ERROR_WRONG_PASSWORD":
            errorMessage = "Your password is wrong.";
            break;
          case "ERROR_USER_NOT_FOUND":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "ERROR_USER_DISABLED":
            errorMessage = "User with this email has been disabled.";
            break;
          case "ERROR_TOO_MANY_REQUESTS":
            errorMessage = "Too many requests. Try again later.";
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$errorMessage'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
        debugPrint(error.code);
      }
    }
  }
}
