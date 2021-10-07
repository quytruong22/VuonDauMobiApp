import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/bar.dart';
import 'package:vuondauapp/widgets/drawer.dart';

class Farms extends StatefulWidget {
  const Farms({Key? key}) : super(key: key);

  @override
  _FarmsState createState() => _FarmsState();
}

class _FarmsState extends State<Farms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Farms'),
        centerTitle: true,
      ),
      drawer: pageDrawer(currentPage: "Farms"),
      bottomNavigationBar: BarBottom(),
      body: Text('Farms'),
    );
  }
}
