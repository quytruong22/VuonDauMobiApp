import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/pages/harvest/harvest_add.dart';
import 'package:vuondauapp/pages/harvest/harvest_detail.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/compoment/search_widget.dart';
import 'package:http/http.dart' as http;

class Harvest extends StatefulWidget {
  final List<HarvestDTO> harvests;
  final List<FarmDTO> farms;

  Harvest({required  this.harvests,required this.farms});

  @override
  _HarvestState createState() => _HarvestState();
}

class _HarvestState extends State<Harvest> {
  late List<HarvestDTO> data;
  late List<HarvestDTO> list;
  String query = '';

  @override
  void initState() {
    super.initState();
    data = widget.harvests;
    list = data;
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Tên mùa vụ',
    onChanged: searchHarvest,
  );

  void searchHarvest(String query) {
    list = data.where((harvest) {
      final namelower = harvest.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return namelower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      this.list=list;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Mùa vụ'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () async {
          http.Response response = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/products'));
          List<ProductDTO> listProduct  = ListProducts.fromJson(jsonDecode(response.body)).products;
          Navigator.push(context,MaterialPageRoute(
              builder: (context) => AddHarvest(listproduct: listProduct,listfarm: widget.farms))
          );
        },
        icon: Icon(Icons.add),
        label: Text('Mùa vụ mới'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              buildSearch(),
              Column(
                children: list.map((harvest) => Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: CardHarvest(
                            harvest: harvest,
                            tap: () {
                              Navigator.push(context,MaterialPageRoute(
                                builder: (context) => DetailHarvest(harvest: harvest)
                              ));
                            }),
                      ),
                    ],
                  ),
                )).toList(),
              ),
              SizedBox(height: 45,)
            ],
          ),
        ),
      ),
    );
  }
}