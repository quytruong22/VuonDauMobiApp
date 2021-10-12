import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/drawer.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text('About Us'),
            centerTitle: true
        ),
        drawer: pageDrawer(currentPage: "AboutUs"),
        body: Text('App Vườn Dâu mobile là một app cung cấp các dịch vụ dành cho farmer')
    );
  }
}
