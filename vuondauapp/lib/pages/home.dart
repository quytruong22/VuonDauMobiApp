import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:vuondauapp/object/areaDTO.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmType.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/object/productPicture.dart';
import 'package:vuondauapp/pages/dashboard.dart';
import 'package:vuondauapp/pages/selling/selling_add.dart';
import 'package:vuondauapp/pages/selling/selling_detail.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/compoment/card-selling.dart';
import 'package:vuondauapp/widgets/icon/icon.dart';
import 'package:vuondauapp/widgets/compoment/square_button.dart';
import 'package:http/http.dart' as http;
import 'farm/farm_add.dart';
import 'harvest/harvest_add.dart';
import 'harvest/harvest_detail.dart';
import 'navpage.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        title: Text('Trang chủ'),
        centerTitle: true
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10,10,10,0),
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: [
                    SquareButton(
                      text: 'Thêm nông trại',
                      icon: MyCustomIcons.farm,
                      color: Colors.lightGreen,
                      press: ()async {
                        List<AreaDTO> listArea  = await httpService.getListAreas();
                        List<FarmType> listFarmType  = await  httpService.getListFarmTypes();
                        await Navigator.push(context,MaterialPageRoute(
                            builder: (context) => AddFarm(listArea: listArea,listFarmType: listFarmType,farmerID: farmerID,)
                        ));
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => NavigationPage()
                        ));
                        },
                    ),
                    SquareButton(
                      text: 'Tạo đợt bán',
                      icon: Icons.agriculture_outlined,
                      color: Colors.lightGreen,
                      press: () async {
                        List<HarvestDTO> listharvest = await httpService.getListAllHarvests(farmerID);
                        await Navigator.push(context,MaterialPageRoute(
                            builder: (context) => AddSelling(harvests: listharvest))
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => NavigationPage()
                        ));
                        },
                    ),
                    SquareButton(
                      text: 'Tạo mùa vụ',
                      icon: Icons.add_to_queue_outlined,
                      color: Colors.lightGreen,
                      press: () async {
                        List<ProductDTO> listProduct  = await httpService.getListProducts();
                        List<FarmDTO> listFarm = await httpService.getListFarms(farmerID);
                        await Navigator.push(context,MaterialPageRoute(
                            builder: (context) => AddHarvest(listproduct: listProduct,listfarm: listFarm))
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => NavigationPage()
                        ));
                      },
                    ),
                    SquareButton(
                      text: 'Xem hóa đơn',
                      icon: Icons.description_outlined,
                      color: Colors.lightGreen,
                      press: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Dashboard()
                        ));
                      },
                    )
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                width: size.width-20,
                child: Text(
                  'Các đợt bán hiện tại',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              FutureBuilder(
                  future: httpService.getAllSellings(farmerID),
                  builder: (BuildContext context, AsyncSnapshot<List<HarvestSellingPriceDTO>> snapshot){
                    if(snapshot.hasData){
                      List<HarvestSellingPriceDTO> listselling = snapshot.requireData;
                      return Container(
                          width: size.width-20,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: listselling.map((selling) => Container(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 32.0),
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
                          )
                      );
                    }
                    if(snapshot.hasError){
                      return  const Center(child: Text('Chưa có đợt bán nào'));
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
              Container(
                padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                width: size.width,
                child: Text(
                  'Các mùa vụ của bạn',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              FutureBuilder(
                future: httpService.getListAllHarvests(farmerID),
                builder: (BuildContext context, AsyncSnapshot<List<HarvestDTO>> snapshot){
                  if(snapshot.hasData){
                    List<HarvestDTO> listharvest = snapshot.requireData;
                    return Container(
                        width: size.width-20,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: listharvest.map((harvest) => Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
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
                        )
                    );
                  }
                  if(snapshot.hasError){
                    return  const Center(child: Text('Chưa có mùa vụ nào'));
                  }
                  return const Center(child: CircularProgressIndicator());
                })
            ],
          ),
        ),
      ),
    );
  }
}
