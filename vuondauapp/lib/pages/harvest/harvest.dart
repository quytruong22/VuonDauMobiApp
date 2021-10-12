import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/drawer.dart';
import 'package:vuondauapp/widgets/compoment/rounded_icon_button.dart';

class Harvest extends StatefulWidget {
  const Harvest({Key? key}) : super(key: key);

  @override
  _HarvestState createState() => _HarvestState();
}

class _HarvestState extends State<Harvest> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Mùa vụ'),
        centerTitle: true,
      ),
      drawer: pageDrawer(currentPage: "Harvests"),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RoundedIconButton(
              text: "Tạo mùa vụ mới",
              press: () {
                Navigator.pushReplacementNamed(context, '/addharvest');
              },
            ),
          ],
        ),
      ),
    );
  }
}