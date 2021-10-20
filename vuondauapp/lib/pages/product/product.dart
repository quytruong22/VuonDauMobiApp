import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/drawer.dart';
class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Product'),
        centerTitle: true,
      ),
      drawer: pageDrawer(currentPage: "Products"),
    );
  }
}