import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/rounded_input_field.dart';
import 'package:vuondauapp/widgets/compoment/rounded_password_field.dart';
import 'package:vuondauapp/widgets/compoment/already_have_account_check.dart';
import 'package:vuondauapp/pages/account/signup.dart';
import 'package:vuondauapp/widgets/compoment/or_divider.dart';
import 'package:vuondauapp/widgets/compoment/social_icon.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../home.dart';

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
  //FirebaseAuth auth = FirebaseAuth.instance;
  //late UserCredential user;
  bool _isLoading = false;
  Future<void> _handleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount
      = await _googleSignIn.signIn();
      if (googleSignInAccount != null){
        final GoogleSignInAuthentication googleSignInAuthentication
        = await googleSignInAccount.authentication;
        // final credential = GoogleAuthProvider.credential(
        //   accessToken: googleSignInAuthentication.accessToken,
        //   idToken: googleSignInAuthentication.idToken,
        // );
        //user = await auth.signInWithCredential(credential);
        //print(user.toString());
        await _googleSignIn.signOut();
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
        width: double.infinity,
        height: size.height,
        child: _isLoading ? Center(child: CircularProgressIndicator()) : Stack(
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
                  textSection(),
                  buttonSection(),
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

  signIn(String email,String password) async {
    Map data = {
      'email': email,
      'password': password
    };
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post(Uri.parse("http://52.221.245.187:90/api/v1/farmers"), body: data);
    if(response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {
        _isLoading = false;
        sharedPreferences.setString("token", jsonData("token"));
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Home()), (Route<dynamic> route) => false);

      });
    }
    else {
      throw Exception('Failed to login');
    }
  }
  Container buttonSection(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: RaisedButton(
        onPressed: (){
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text,passwordController.text);
        },
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        child: Text("Sign In",
        style: TextStyle(color: Colors.black)
        )
      ),
    );
  }
  Container textSection(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          txtSection("Email", Icons.email),
          SizedBox(height: 30.0),
          txtSection("Password", Icons.lock),

        ]
      )
    );
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextFormField txtSection(String title, IconData icon){
    return TextFormField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.black),
        icon: Icon(icon,
        color: Colors.green),
        border: InputBorder.none,
      )
    );
  }
}
