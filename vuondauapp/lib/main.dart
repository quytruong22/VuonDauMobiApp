import 'package:flutter/material.dart';
import 'package:vuondauapp/pages/farm/farm_add.dart';
import 'package:vuondauapp/pages/home.dart';
import 'package:vuondauapp/pages/account/profile.dart';
import 'package:vuondauapp/pages/farm/farm.dart';
import 'package:vuondauapp/pages/account/profile_update.dart';
import 'package:vuondauapp/pages/account/change_password.dart';
import 'package:vuondauapp/pages/account/login.dart';
import 'package:vuondauapp/pages/account/signup.dart';
import 'package:vuondauapp/pages/dashboard.dart';
import 'package:vuondauapp/pages/harvest/harvest.dart';
import 'package:vuondauapp/pages/aboutus.dart';
import 'package:vuondauapp/pages/harvest/harvest_add.dart';
import 'package:vuondauapp/pages/harvest/harvest_detail.dart';
import 'package:vuondauapp/pages/farm/farm_detail.dart';
import 'package:vuondauapp/pages/product/product.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/home': (context) => Home(),
      '/profile': (context) => Profile(),
      '/profileupdate': (context) => UpdateProfile(),
      '/passwordupdate': (context) => UpdatePassword(),
      '/farm': (context) => Farm(),
      '/detailfarm': (context) => DetailFarm(),
      '/addfarm': (context) => AddFarm(),
   //  '/login': (context) => LoginScreen(),
      '/login': (context) => Home(),
      '/signup': (context) => SignUpScreen(),
      '/harvest': (context) => Harvest(),
      '/dashboard': (context) => Dashboard(),
      '/aboutus': (context) => AboutUs(),
      '/addharvest': (context) => AddHarvest(),
      '/detailharvest': (context) => DetailHarvest(),
      '/product': (context) => Product(),
    },

  ));
}

