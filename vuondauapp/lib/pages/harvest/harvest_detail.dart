import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest-detail.dart';

import '../navpage.dart';
import 'harvest_update.dart';

class DetailHarvest extends StatefulWidget {
  final HarvestDTO  harvest;


  DetailHarvest({required this.harvest});

  @override
  _DetailHarvestState createState() => _DetailHarvestState();
}

class _DetailHarvestState extends State<DetailHarvest> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Chi tiết mùa vụ'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: CardHarvestDetail(
                  harvest: widget.harvest,
                  tap: () async {
                    http.Response response = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/products'));
                    List<ProductDTO> listProduct  = ListProducts.fromJson(jsonDecode(response.body)).products;
                    response = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/farms'));
                    List<FarmDTO> listFarm  = ListFarms.fromJson(jsonDecode(response.body)).farms;
                    await Navigator.push(context,MaterialPageRoute(
                        builder: (context) => UpdateHarvest(listproduct: listProduct,listfarm: listFarm,harvest:widget.harvest))
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => NavigationPage(farmer: widget.harvest.farm.farmer)
                    ));
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
