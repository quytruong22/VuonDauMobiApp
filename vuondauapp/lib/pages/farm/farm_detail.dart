import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vuondauapp/object/areaDTO.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmType.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/compoment/card-farm-detail.dart';
import 'package:http/http.dart' as http;
import '../navpage.dart';
import 'farm_update.dart';

class DetailFarm extends StatefulWidget {
  final FarmDTO farm;
  final List<HarvestDTO>  listharvest;

  DetailFarm({required this.farm,required this.listharvest});

  @override
  _DetailFarmState createState() => _DetailFarmState();
}

class _DetailFarmState extends State<DetailFarm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Chi tiết nông trại'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: size.width-20,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: CardFarmDetail(
                      farm: widget.farm,
                      tap: () async {
                        try{
                          http.Response response = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/areas'));
                          List<AreaDTO> listArea  = ListAreas.fromJson(jsonDecode(response.body)).areas;
                          response = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/farm-types'));
                          List<FarmType> listFarmType  = ListFarmTypes.fromJson(jsonDecode(response.body)).farmTypes;
                          final FarmDTO farmUpdated = await Navigator.push(context,MaterialPageRoute(
                            builder: (context) => UpdateFarm(listArea: listArea,listFarmType: listFarmType,farm:widget.farm),
                          )) as FarmDTO;
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => NavigationPage(farmer: widget.farm.farmer)
                          ));
                        }catch(e){

                        }
                      },
                  ),
                ),
                Text(
                  'Các mùa vụ của nông trại',
                  style: TextStyle(

                  ),
                ),
                Column(
                  children: widget.listharvest.map((harvest) => Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 8.0),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: CardHarvest(
                              harvest: harvest,
                              tap: () {
                                Navigator.pushNamed(context, '/detailharvest',arguments: harvest);
                              }),
                        ),
                      ],
                    ),
                  )).toList(),
                )
              ],
          ),
        ),
      ),
    );
  }
}
