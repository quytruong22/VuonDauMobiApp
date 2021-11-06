import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/compoment/card-farm-detail.dart';

class DetailFarm extends StatefulWidget {
  final FarmDTO farm;

  DetailFarm({required this.farm});

  @override
  _DetailFarmState createState() => _DetailFarmState();
}

class _DetailFarmState extends State<DetailFarm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<HarvestDTO> list = ModalRoute.of(context)!.settings.arguments as List<HarvestDTO>;
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
                      ),
                ),
                RoundedButton(
                  text: "Tạo mùa vụ mới",
                  press: () async {
                    try{

                    }catch(E){

                    }
                    Navigator.pushNamed(context, '/addharvest');
                  },
                ),
                Text(
                  'Các mùa vụ của nông trại',
                  style: TextStyle(

                  ),
                ),
                Column(
                  children: list.map((harvest) => Container(
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
