import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/drawer.dart';

class UpdatePassword extends StatefulWidget {

  @override
  _UpdatePassword createState() => _UpdatePassword();
}

class _UpdatePassword extends State<UpdatePassword> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Update Password'),
          centerTitle: true
      ),
      drawer: pageDrawer(currentPage: "Update Password"),
    );
  }
}
