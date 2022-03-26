import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management_app/Pages/home_page.dart';
import 'package:money_management_app/routes/routes.dart';
import 'package:money_management_app/utils/user_format.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
    String? errorMessage;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController fullNameController = new TextEditingController();
  final TextEditingController confirmPasswordController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    'assets/images/financeblue.gif',
                    height: 270,
                    width: 500,
                    fit: BoxFit.contain,
                    // height: 240,
                    alignment: Alignment.center,
                  ),
                ),
                Text(
                  'Let\'s get started!',
                  style: GoogleFonts.pacifico(
                    textStyle: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                ),
                Text(
                  'Begin saving for the future today.',
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
                          controller: fullNameController,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            fullNameController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            hintText: 'Enter Your Full Name',
                            filled: true,
                            prefixIcon: Icon(IconlyBold.user2),
                            labelText: 'Full Name',
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{4,}$');
                            if (value!.isEmpty) {
                              return ("First Name cannot be Empty");
                            }
                            if (!regex.hasMatch(value)) {
                              return ("Enter Valid name(Min. 4 Character)");
                            }
                            return null;
                          }),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 28.0,
                        ),
                      ),
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Email can't be empty.");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Invalid Email, Please enter a valid email address.");
                          }
                          return null;
                        },
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
                        textInputAction: TextInputAction.next,
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
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password can't be empty.");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter a Valid Password(Min. 6 Character)");
                          }
                          return null;
                        },
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
                        controller: confirmPasswordController,
                        onSaved: (value) {
                          confirmPasswordController.text = value!;
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
                          hintText: 'Confirm Your Password',
                          labelText: 'Confirm Password',
                        ),
                        validator: (value) {
                          if (confirmPasswordController.text !=
                              passwordController.text) {
                            return "Password don't match!";
                          }
                          return null;
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 28.0,
                        ),
                      ),
                      InkWell(
                        onTap: (() {
                          signUp(emailController.text, passwordController.text);
                        }),
                        child: Container(
                          width: 150,
                          height: 40,
                          alignment: Alignment.center,
                          child: const Text(
                            'Sign Up',
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
                          Text('Already have an account?'),
                          TextButton(
                            onPressed: (() {
                              Navigator.popAndPushNamed(
                                  context, MyRoutes.loginRoute);
                            }),
                            child: Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      Text(
                        'By signing up you agree to our terms, conditions and privacy Policy.',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
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
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullName = fullNameController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "You are a thrifter now🥳");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false);
  }
}
