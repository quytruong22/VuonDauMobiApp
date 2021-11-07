import 'package:flutter/material.dart';
import 'package:vuondauapp/pages/account/change_password.dart';
import 'package:vuondauapp/pages/feedback.dart';
import 'package:vuondauapp/pages/account/profile_update.dart';
import 'package:vuondauapp/pages/account/login.dart';
import 'package:vuondauapp/pages/account/signup.dart';
import 'package:vuondauapp/pages/dashboard.dart';
import 'package:vuondauapp/pages/aboutus.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    // // Show error message if initialization failed
    // if(_error) {
    //   return MaterialApp(
    //     home: Scaffold(
    //       appBar: AppBar(
    //           backgroundColor: Colors.green,
    //           title: Text('Error'),
    //           centerTitle: true
    //       ),
    //     ),
    //   );
    // }
    //
    // // Show a loader until FlutterFire is initialized
    // if (!_initialized) {
    //   return MaterialApp(
    //     home: Scaffold(
    //       appBar: AppBar(
    //           backgroundColor: Colors.green,
    //           title: Text('Loadig'),
    //           centerTitle: true
    //       ),
    //     ),
    //   );
    // }

    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/changepassword': (context) => ChangePassword(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/dashboard': (context) => Dashboard(),
        '/aboutus': (context) => AboutUs(),
        '/feedback': (context) => FeedbackPage(),
      },
    );
  }
}