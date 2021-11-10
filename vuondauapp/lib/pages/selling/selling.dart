import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/object/productPicture.dart';
import 'package:vuondauapp/pages/selling/selling_add.dart';
import 'package:vuondauapp/pages/selling/selling_detail.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/card-selling.dart';
import 'package:vuondauapp/widgets/compoment/search_widget.dart';
import 'package:http/http.dart' as http;

import '../navpage.dart';

class Selling extends StatefulWidget {

  @override
  _SellingState createState() => _SellingState();
}

class _SellingState extends State<Selling> {
  final HttpService httpService = HttpService();
  final LocalStorage storage = LocalStorage('farmer_info');
  late List<HarvestSellingPriceDTO> data;
  List<HarvestSellingPriceDTO> list=[];
  String query = '';

  @override
  void initState() {
    super.initState();
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Tên đợt bán',
    onChanged: searchSelling,
  );

  void searchSelling(String query) {
    list = data.where((selling) {
      final namelower = selling.harvestSelling.harvest.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return namelower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
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
        title: Text('Đợt bán'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () async {
          List<HarvestDTO> harvests = await httpService.getListAllHarvests(farmerID);
          await Navigator.push(context,MaterialPageRoute(
              builder: (context) => AddSelling(harvests: harvests))
          );
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => NavigationPage()
          ));
        },
        icon: Icon(Icons.add),
        label: Text('Đợt bán mới'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: size.width,
        height: size.height,
        child: FutureBuilder(
          future: httpService.getAllSellings(farmerID),
          builder: (BuildContext context, AsyncSnapshot<List<HarvestSellingPriceDTO>> snapshot){
            if(snapshot.hasData){
              data = snapshot.requireData;
              list=data;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    buildSearch(),
                    Column(
                      children: list.map((selling) => Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: CardSelling(
                                  selling: selling,
                                  tap: () async {
                                    final response = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/product-pictures/${selling.harvestSelling.harvest.product.id}'));
                                    List<ProductPicture> pictures = ListProductPictures.fromJson(jsonDecode(response.body)).products;
                                    final String  imgProduct  = pictures.first.src;
                                    Navigator.push(context,MaterialPageRoute(
                                        builder: (context) => DetailSelling(selling: selling,imgProduct:imgProduct)
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
              );
            }
            if(snapshot.hasError){
              return  const Center(child: Text('Chưa có đợt bán nào'));
            }
            return const Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }
}