import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestSellingDTO.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
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
  late List<FarmDTO>  listFarms;
  late List<HarvestDTO> listHarvests;
  late List<HarvestSellingPriceDTO> listSellings;
  late FarmerDTO farmer;

  Future<void> _handleSignIn() async{
    try{
      user = await auth.signInWithEmailAndPassword(email: email, password: password);
      await SignIn();
    } catch(error){
      print(error);
    }
  }

  Future<void> _handleGoogleSignIn() async {
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
    print('hehe');
    print(response.statusCode);
    if (response.statusCode==200) {
      Map<String, dynamic> payload = Jwt.parseJwt(response.body);
      print(payload);

      final String getID = payload['ID'];
      final getFarmerResponse = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/farmers/$getID'));
      if(getFarmerResponse.statusCode==200){
        farmer = FarmerDTO.fromJson(jsonDecode(getFarmerResponse.body));
        await loadData();
        _googleSignIn.signOut();
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => NavigationPage(harvests: listHarvests,  sellings: listSellings,farmer: farmer,farms: listFarms)
        ));
      }
    }
  }

  Future<void> loadData() async{
    final responseFarm = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/farms/${farmer.id}'));
    if(responseFarm.statusCode==200){
      listFarms = ListFarms.fromJson(jsonDecode(responseFarm.body)).farms;
      listFarms.forEach((farm) async {
        final responseHarvest = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/harvests/${farm.ID}'));
        if(responseHarvest.statusCode==200){
          final listgetharvest  = ListHarvests.fromJson(jsonDecode(responseHarvest.body)).harvests;
          listHarvests.addAll(listgetharvest);
        }
      });
      listHarvests.forEach((harvest) async {
        final responseHarvestSelling = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/harvests/${harvest.ID}'));
        if(responseHarvestSelling.statusCode==200){
          final listgetHarvestSelling  = ListHarvestSelling.fromJson(jsonDecode(responseHarvestSelling.body)).harvestsellings;
          listgetHarvestSelling.forEach((harvestSelling) async {
            final responseHarvestSellingPrice = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/harvests/${harvestSelling.id}'));
            if(responseHarvestSellingPrice.statusCode==200){
              final harvestSellingPrice = HarvestSellingPriceDTO.fromJson(jsonDecode(responseHarvestSellingPrice.body));
              listSellings.add(harvestSellingPrice);
            }
          });
        }
      });
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
                    onChanged: (value) {
                      email=value;
                    },
                  ),
                  RoundedPasswordField(
                    hint: 'Password',
                    onChanged: (value) {
                      password=value;
                    },
                  ),
                  RoundedButton(
                    text: "LOGIN",
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