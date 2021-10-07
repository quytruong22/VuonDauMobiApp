import 'package:flutter/material.dart';
import 'package:vuondauapp/pages/home.dart';
import 'package:vuondauapp/pages/account/profile.dart';
import 'package:vuondauapp/pages/farm/farm_list.dart';
import 'package:vuondauapp/pages/account/profile_update.dart';
import 'package:vuondauapp/pages/account/login.dart';
import 'package:vuondauapp/pages/account/signup.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/home': (context) => Home(),
      '/profile': (context) => Profile(),
      '/profileupdate': (context) => UpdateProfile(),
      '/farmlist': (context) => Farms(),
      '/login': (context) => LoginScreen(),
      '/signup': (context) => SignUpScreen(),
    },

  ));
}

