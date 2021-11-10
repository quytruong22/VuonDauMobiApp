import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:vuondauapp/object/areaDTO.dart';
import 'package:vuondauapp/object/farmType.dart';
import 'package:vuondauapp/pages/farm/farm_add.dart';
import 'package:vuondauapp/pages/farm/farm_detail.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/card-farm.dart';
import 'package:vuondauapp/object/farmDTO.dart';

class Farm extends StatefulWidget {

  @override
  _FarmState createState() => _FarmState();
}

class _FarmState extends State<Farm> {
  final HttpService httpService = HttpService();
  final LocalStorage storage = LocalStorage('farmer_info');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String farmerID = "";
    if (storage.getItem("Farmer_ID") != null) {
      farmerID = storage.getItem("Farmer_ID");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Nông trại'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () async {
          List<AreaDTO> listArea  = await httpService.getListAreas();
          List<FarmType> listFarmType  = await  httpService.getListFarmTypes();
          await Navigator.push(context,MaterialPageRoute(
            builder: (context) => AddFarm(listArea: listArea,listFarmType: listFarmType,farmerID: farmerID,)
          ));
          Navigator.pushReplacement(context,MaterialPageRoute(
              builder: (context) => Farm()
          ));
        },
        icon: Icon(Icons.add),
        label: Text('Nông trại mới'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        width: size.width,
        height: size.height,
        child: FutureBuilder(
          future: httpService.getListFarms(farmerID),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.hasData){
              List<FarmDTO> listfarm  = snapshot.requireData;
              print(1);
              return SingleChildScrollView(
                  child: Column(
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: listfarm.map((farm) => Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: CardFarm(
                                        farm: farm,
                                        tap: () async {
                                          await Navigator.push(context,MaterialPageRoute(
                                              builder: (context) => DetailFarm(),
                                              settings: RouteSettings(
                                                arguments: farm.ID,
                                              )
                                          ));
                                          Navigator.pushReplacement(context,MaterialPageRoute(
                                              builder: (context) => Farm()
                                          ));
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
              );
            }
            if(snapshot.hasError){
              return  const Center(child: Text('Chưa có nông trại nào'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
