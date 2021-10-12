import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/drawer.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Home'),
        centerTitle: true
      ),
      drawer: pageDrawer(currentPage: "Home"),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: size.height*0.3,
                width: size.width,
                child: Row(
                  children: <Widget>[

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
