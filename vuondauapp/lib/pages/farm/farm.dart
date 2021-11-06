import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/pages/farm/farm_detail.dart';
import 'package:vuondauapp/widgets/compoment/card-farm.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:http/http.dart' as http;

class Farm extends StatefulWidget {
  final FarmerDTO farmer;

  Farm({required this.farmer});

  @override
  _FarmState createState() => _FarmState();
}

class _FarmState extends State<Farm> {
  @override
  Widget build(BuildContext context) {
    final List<FarmDTO> list=ModalRoute.of(context)!.settings.arguments as List<FarmDTO>;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Nông trại'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, '/addfarm',arguments: widget.farmer);
        },
        icon: Icon(Icons.add),
        label: Text('Nông trại mới'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        width: size.width-20,
        height: size.height,
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: list.map((farm) => Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: CardFarm(
                                farm: farm,
                                tap: () async {
                                  try {
                                    final response = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/harvests/${farm.ID}'));
                                    List<HarvestDTO> list = await ListHarvests.fromJson(jsonDecode(response.body)).harvests;
                                    Navigator.push(context,MaterialPageRoute(
                                        builder: (context) => DetailFarm(farm:farm),
                                        settings: RouteSettings(
                                        arguments: {list}
                                        ),
                                    ));
                                  } on Exception catch (e) {
                                    // TODO
                                  }
                                }),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ),
                SizedBox(height: 45),
              ]
            )
        ),
      ),
    );
  }
}
