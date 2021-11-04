import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'components/body.dart';
class Profile extends StatefulWidget {
  final FarmerDTO farmer;

  Profile({required this.farmer});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Profile'),
          centerTitle: true,
      ),
      body: Body(farmer: widget.farmer),
    );
  }
}
