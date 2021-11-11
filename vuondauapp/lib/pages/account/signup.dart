import 'package:flutter/material.dart';
import 'package:vuondauapp/pages/account/profile_update.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_password_field.dart';
import 'package:vuondauapp/widgets/compoment/already_have_account_check.dart';
import 'package:vuondauapp/widgets/compoment/or_divider.dart';
import 'package:vuondauapp/widgets/compoment/social_icon.dart';
import 'package:vuondauapp/pages/account/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'createAccount.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential user;
  String  email='';
  String  password='';

  Future<void> _handleSignUp() async{
    try{
      user = await auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch(error){
      print(error);
    }
  }

  Future<void> _handleGoogleSignUp() async{
    try {
      final GoogleSignInAccount? googleSignInAccount
      = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication
        = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        _googleSignIn.signOut();
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        // Here i can use size.width but use double.infinity because both work as a same
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/signup_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                "assets/images/signup_bottom.png",
                width: size.width * 0.25,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/iconVuondau.png",
                    height: size.height * 0.35,
                  ),
                  RoundedInputField(
                    icon: Icons.email,
                    hintText: "Email của bạn",
                    onChanged: (value) {
                      email=value;
                    },
                  ),
                  RoundedPasswordField(
                    hint: 'Mật khẩu',
                    onChanged: (value) {
                      password=value;
                    },
                  ),
                  RoundedButton(
                    text: "ĐĂNG KÝ",
                    press: () async {
                      _handleSignUp();
                      await Navigator.push(context,MaterialPageRoute(
                        builder: (context) => CreateAccount(email:email),
                        settings: RouteSettings(
                          arguments: null,
                        ),
                      ));
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                  OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocalIcon(
                        iconSrc: "assets/images/Google.png",
                        press: () {
                          _handleGoogleSignUp();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}