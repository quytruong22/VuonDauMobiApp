import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestPicture.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest-detail.dart';

import '../navpage.dart';
import 'harvest_update.dart';

class DetailHarvest extends StatefulWidget {
  final String harvestID;

  DetailHarvest({required this.harvestID});

  @override
  _DetailHarvestState createState() => _DetailHarvestState();
}

class _DetailHarvestState extends State<DetailHarvest> {
  final HttpService httpService = HttpService();
  final LocalStorage storage = LocalStorage('farmer_info');

  @override
  Widget build(BuildContext context) {
    String farmerID = "";
    if (storage.getItem("Farmer_ID") != null) {
      farmerID = storage.getItem("Farmer_ID");
    }
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
              FutureBuilder(
                  future: httpService.getHarvest(widget.harvestID),
                  builder: (BuildContext context, AsyncSnapshot<HarvestDTO> snapshot){
                    if(snapshot.hasData){
                      HarvestDTO harvest = snapshot.requireData;
                      return  Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: CardHarvestDetail(
                            harvest: harvest,
                            tap: () async {
                              HarvestPicture img  = await httpService.getHarvestImage(harvest.ID);
                              List<ProductDTO> listProduct  = await httpService.getListProducts();
                              List<FarmDTO> listFarm  = await httpService.getListFarms(farmerID);
                              await Navigator.push(context,MaterialPageRoute(
                                  builder: (context) => UpdateHarvest(listproduct: listProduct,listfarm: listFarm,harvest:harvest,image:img))
                              );
                              Navigator.pushReplacement(context,MaterialPageRoute(
                                  builder: (context) => DetailHarvest(harvestID: harvest.ID)
                              ));
                            }
                        ),
                      );
                    }
                    if(snapshot.hasError){
                      return  const Center(child: Text('Lỗi load mùa vụ'));
                    }
                    return const Center(child: CircularProgressIndicator());
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
