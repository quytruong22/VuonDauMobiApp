import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'components/body.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Hồ sơ'),
          centerTitle: true,
      ),
      body: Body()
    );
  }
}
