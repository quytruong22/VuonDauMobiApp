import 'package:flutter/material.dart';
import 'package:vuondauapp/pages/account/change_password.dart';
import 'package:vuondauapp/pages/navpage.dart';
import 'package:vuondauapp/pages/farm/farm_add.dart';
import 'package:vuondauapp/pages/farm/farm_update.dart';
import 'package:vuondauapp/pages/harvest/harvest_update.dart';
import 'package:vuondauapp/pages/home.dart';
import 'package:vuondauapp/pages/account/profile.dart';
import 'package:vuondauapp/pages/farm/farm.dart';
import 'package:vuondauapp/pages/account/profile_update.dart';
import 'package:vuondauapp/pages/account/login.dart';
import 'package:vuondauapp/pages/account/signup.dart';
import 'package:vuondauapp/pages/dashboard.dart';
import 'package:vuondauapp/pages/harvest/harvest.dart';
import 'package:vuondauapp/pages/aboutus.dart';
import 'package:vuondauapp/pages/harvest/harvest_add.dart';
import 'package:vuondauapp/pages/harvest/harvest_detail.dart';
import 'package:vuondauapp/pages/farm/farm_detail.dart';
import 'package:vuondauapp/pages/selling/selling.dart';
import 'package:vuondauapp/pages/selling/selling_add.dart';
import 'package:vuondauapp/pages/selling/selling_detail.dart';
import 'package:vuondauapp/pages/selling/selling_update.dart';
import 'package:firebase_core/firebase_core.dart';

void main(){
  runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/navpage': (context) => NavigationPage(),
      '/home': (context) => Home(),
      '/profile': (context) => Profile(),
      '/profileupdate': (context) => UpdateProfile(),
      '/changepassword': (context) => ChangePassword(),
      '/farm': (context) => Farm(),
      '/detailfarm': (context) => DetailFarm(),
      '/addfarm': (context) => AddFarm(),
      '/updatefarm': (context) => UpdateFarm(),
      '/login': (context) => LoginScreen(),
      '/signup': (context) => SignUpScreen(),
      '/harvest': (context) => Harvest(),
      '/dashboard': (context) => Dashboard(),
      '/aboutus': (context) => AboutUs(),
      '/addharvest': (context) => AddHarvest(),
      '/detailharvest': (context) => DetailHarvest(),
      '/updateharvest': (context) => UpdateHarvest(),
      '/selling': (context) => Selling(),
      '/updateselling': (context) => UpdateSelling(),
      '/addselling': (context) => AddSelling(),
      '/detailselling': (context) => DetailSelling(),
    },
  ));
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(App());
// }
//
// class App extends StatefulWidget {
//   _AppState createState() => _AppState();
// }
//
// class _AppState extends State<App> {
//   // Set default `_initialized` and `_error` state to false
//   bool _initialized = false;
//   bool _error = false;
//
//   // Define an async function to initialize FlutterFire
//   void initializeFlutterFire() async {
//     try {
//       // Wait for Firebase to initialize and set `_initialized` state to true
//       await Firebase.initializeApp();
//       setState(() {
//         _initialized = true;
//       });
//     } catch(e) {
//       print(e.toString());
//       // Set `_error` state to true if Firebase initialization fails
//       setState(() {
//         _error = true;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     initializeFlutterFire();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Show error message if initialization failed
//     if(_error) {
//       return MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(
//               backgroundColor: Colors.green,
//               title: Text('Error'),
//               centerTitle: true
//           ),
//         ),
//       );
//     }
//
//     // Show a loader until FlutterFire is initialized
//     if (!_initialized) {
//       return MaterialApp(
//         home: Scaffold(
//           appBar: AppBar(
//               backgroundColor: Colors.green,
//               title: Text('Loadig'),
//               centerTitle: true
//           ),
//         ),
//       );
//     }
//
//     return MaterialApp(
//       initialRoute: '/login',
//       routes: {
//         '/navpage': (context) => NavigationPage(),
//         '/home': (context) => Home(),
//         '/profile': (context) => Profile(),
//         '/profileupdate': (context) => UpdateProfile(),
//         '/changepassword': (context) => ChangePassword(),
//         '/farm': (context) => Farm(),
//         '/detailfarm': (context) => DetailFarm(),
//         '/addfarm': (context) => AddFarm(),
//         '/updatefarm': (context) => UpdateFarm(),
//         '/login': (context) => LoginScreen(),
//         '/signup': (context) => SignUpScreen(),
//         '/harvest': (context) => Harvest(),
//         '/dashboard': (context) => Dashboard(),
//         '/aboutus': (context) => AboutUs(),
//         '/addharvest': (context) => AddHarvest(),
//         '/detailharvest': (context) => DetailHarvest(),
//         '/updateharvest': (context) => UpdateHarvest(),
//         '/selling': (context) => Selling(),
//         '/updateselling': (context) => UpdateSelling(),
//         '/addselling': (context) => AddSelling(),
//         '/detailselling': (context) => DetailSelling(),
//       },
//     );
//   }
// }