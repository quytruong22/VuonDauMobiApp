import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_password_field.dart';
import 'package:vuondauapp/widgets/compoment/already_have_account_check.dart';
import 'package:vuondauapp/pages/account/signup.dart';
import 'package:vuondauapp/widgets/compoment/or_divider.dart';
import 'package:vuondauapp/widgets/compoment/social_icon.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
  ],
);

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount
      = await _googleSignIn.signIn();
      if (googleSignInAccount != null){
        final GoogleSignInAuthentication googleSignInAuthentication
        = await googleSignInAccount.authentication;
        print(googleSignInAccount.id);
        print(googleSignInAuthentication.accessToken);
      }
      await _googleSignIn.signOut();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/login_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: size.width * 0.4,
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
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    icon: Icons.email,
                    hintText: "Your Email",
                    onChanged: (value) {},
                  ),
                  RoundedPasswordField(
                    hint: 'Password',
                    onChanged: (value) {},
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () {
                      print('l');
                      Navigator.pushReplacementNamed(context, '/dashboard');
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
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
                          _handleSignIn();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

