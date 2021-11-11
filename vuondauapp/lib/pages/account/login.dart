import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'package:vuondauapp/pages/navpage.dart';
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
import 'package:jwt_decode/jwt_decode.dart';

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
  FirebaseAuth auth = FirebaseAuth.instance;
  late UserCredential user;
  String email='';
  String password='';
  late FarmerDTO farmer;
  final LocalStorage storage = new LocalStorage('farmer_info');

  Future<void> _handleSignIn() async{
    auth.signOut();
    try{
      user = await auth.signInWithEmailAndPassword(email: email, password: password);
      await SignIn();
    } catch(error){
      print(error);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    auth.signOut();
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
        user = await auth.signInWithCredential(credential);
        await SignIn();
      }
    } catch (error) {
      print(error);
    }
  }
  Future<void> SignIn() async{
    final idToken = await user.user?.getIdToken();
    Map data = {
      'access_token': '$idToken'
    };
    var body = json.encode(data);
    final http.Response response = await http.post(
        Uri.parse('http://52.221.245.187:90/api/v1/login'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if (response.statusCode==200) {
      Map<String, dynamic> payload = Jwt.parseJwt(response.body);
      final String getID = payload['ID'];
      storage.setItem("Farmer_ID", getID);
      _googleSignIn.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => NavigationPage()
      ));
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
                    text: "ĐĂNG NHẬP",
                    press: () {
                      _handleSignIn();
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.pushReplacement(
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
                          _handleGoogleSignIn();
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