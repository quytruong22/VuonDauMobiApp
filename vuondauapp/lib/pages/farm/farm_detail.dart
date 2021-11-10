import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:vuondauapp/object/areaDTO.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmPicture.dart';
import 'package:vuondauapp/object/farmType.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/pages/harvest/harvest_detail.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/compoment/card-farm-detail.dart';
import 'farm_update.dart';

class DetailFarm extends StatefulWidget {

  @override
  _DetailFarmState createState() => _DetailFarmState();
}

class _DetailFarmState extends State<DetailFarm> {
  final HttpService httpService = HttpService();
  final LocalStorage storage = LocalStorage('farmer_info');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final String farmID=ModalRoute.of(context)!.settings.arguments as String;
    String farmerID = "";
    if (storage.getItem("Farmer_ID") != null) {
      farmerID = storage.getItem("Farmer_ID");
    }
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
                FutureBuilder(
                    future: httpService.getFarm(farmID),
                    builder: (BuildContext context,
                      AsyncSnapshot<FarmDTO> snapshot){
                      if(snapshot.hasData){
                        FarmDTO farm  = snapshot.requireData;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 32.0),
                          child: CardFarmDetail(
                            farm: farm,
                            tap: () async {
                              try{
                                FarmPicture img = await httpService.getFarmImage(farmID);
                                List<AreaDTO> listArea  = await httpService.getListAreas();
                                List<FarmType> listFarmType  = await  httpService.getListFarmTypes();
                                await Navigator.push(context,MaterialPageRoute(
                                  builder: (context) => UpdateFarm(listArea: listArea,listFarmType: listFarmType,farm:farm,image: img),
                                ));
                                Navigator.pushReplacement(context,MaterialPageRoute(
                                    builder: (context) => DetailFarm(),
                                    settings: RouteSettings(
                                      arguments: farm.ID,
                                    )
                                ));
                              }catch(e){

                              }
                            },
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }
                ),
                Text(
                  'Các mùa vụ của nông trại:',
                  style: TextStyle(

                  ),
                ),
                FutureBuilder(
                    future: httpService.getListHarvestsByFarmID(farmID),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<HarvestDTO>> snapshot){
                      if(snapshot.hasData){
                        List<HarvestDTO> listHarvest  = snapshot.requireData;
                        return Column(
                          children: listHarvest.map((harvest) => Container(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 8.0),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 32.0),
                                  child: CardHarvest(
                                      harvest: harvest,
                                      tap: () {
                                        Navigator.push(context,MaterialPageRoute(
                                            builder: (context) => DetailHarvest(harvestID: harvest.ID)
                                        ));
                                      }),
                                ),
                              ],
                            ),
                          )).toList(),
                        );
                      }
                      if(snapshot.hasError){
                        return  const Center(child: Text('Chưa có mùa vụ trong nông trại này'));
                      }
                      return const Center(child: CircularProgressIndicator());
                    }
                )
              ],
          ),
        ),
      ),
    );
  }
}
