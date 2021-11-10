import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/pages/harvest/harvest_add.dart';
import 'package:vuondauapp/pages/harvest/harvest_detail.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/compoment/search_widget.dart';
import '../navpage.dart';

class Harvest extends StatefulWidget {

  @override
  _HarvestState createState() => _HarvestState();
}

class _HarvestState extends State<Harvest> {
  final HttpService httpService = HttpService();
  final LocalStorage storage = LocalStorage('farmer_info');
  late  List<HarvestDTO> data;
  List<HarvestDTO> list=[];
  String query = '';

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Tên mùa vụ',
    onChanged: searchHarvest,
  );

  void searchHarvest(String query) {
    List<HarvestDTO> listSearch = data.where((harvest) {
      final namelower = harvest.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return namelower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      list = listSearch;
    });
  }
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
        title: Text('Mùa vụ'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () async {
          List<FarmDTO> listFarm = await httpService.getListFarms(farmerID);
          List<ProductDTO> listProduct  =await httpService.getListProducts();
          await Navigator.push(context,MaterialPageRoute(
              builder: (context) => AddHarvest(listproduct: listProduct,listfarm: listFarm))
          );
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => NavigationPage()
          ));
        },
        icon: Icon(Icons.add),
        label: Text('Mùa vụ mới'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        width: size.width,
        height: size.height,
        child: FutureBuilder(
          future: httpService.getListAllHarvests(farmerID),
          builder: (BuildContext context, AsyncSnapshot<List<HarvestDTO>> snapshot){
            if(snapshot.hasData){
              data = snapshot.requireData;
              list=data;
              return SingleChildScrollView(
                  child: Column(
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
                                            builder: (context) => DetailHarvest(harvestID: harvest.ID)
                                        ));
                                      }),
                                ),
                              ],
                            ),
                          )).toList(),
                        ),
                        SizedBox(height: 45,)
                      ]
                  )
              );
            }
            if(snapshot.hasError){
              return  const Center(child: Text('Chưa có mùa vụ nào'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      )
    );
  }
}