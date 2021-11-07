import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vuondauapp/object/areaDTO.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmType.dart';
import 'package:vuondauapp/object/farmerDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
import 'package:vuondauapp/pages/selling/selling_add.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/compoment/card-selling.dart';
import 'package:vuondauapp/widgets/icon/icon.dart';
import 'package:vuondauapp/widgets/compoment/square_button.dart';
import 'package:http/http.dart' as http;
import 'farm/farm_add.dart';

class Home extends StatefulWidget {
  final List<HarvestDTO> listharvest;
  final List<HarvestSellingPriceDTO>  listselling;
  final FarmerDTO farmer;

  Home({required this.listharvest, required this.listselling,required this.farmer});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    List<HarvestDTO> listharvest=widget.listharvest;
    List<HarvestSellingPriceDTO>  listselling=widget.listselling;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Trang chủ'),
        centerTitle: true
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
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
                        http.Response response = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/areas'));
                        List<AreaDTO> listArea  = ListAreas.fromJson(jsonDecode(response.body)).areas;
                        response = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/farm-types'));
                        List<FarmType> listFarmType  = ListFarmTypes.fromJson(jsonDecode(response.body)).farmTypes;
                        Navigator.push(context,MaterialPageRoute(
                          builder: (context) => AddFarm(listArea: listArea,listFarmType: listFarmType),
                          settings: RouteSettings(
                            arguments: widget.farmer,
                          ),
                        ));
                        },
                    ),
                    SquareButton(
                      text: 'Tạo đợt bán',
                      icon: Icons.agriculture,
                      color: Colors.lightGreen,
                      press: (){
                        Navigator.push(context,MaterialPageRoute(
                            builder: (context) => AddSelling(harvests: widget.listharvest))
                        );
                        },
                    ),
                    SquareButton(
                      text: 'Xác nhận đơn hàng',
                      icon: Icons.shopping_cart,
                      color: Colors.lightGreen,
                      press: (){},
                    ),
                    SquareButton(
                      text: 'Thống kê',
                      icon: Icons.dashboard,
                      color: Colors.lightGreen,
                      press: (){Navigator.pushNamed(context, '/dashboard');},
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
              Container(
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
                                  tap: () {
                                    Navigator.pushNamed(context, '/detailselling');
                                  }),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  )
              ),
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
              Container(
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
                                    Navigator.pushNamed(context, '/detailharvest');
                                  }),
                            ),
                          ],
                        ),
                      )).toList(),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
