import 'package:flutter/material.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest-detail.dart';

class DetailHarvest extends StatefulWidget {
  final HarvestDTO  harvest;


  DetailHarvest({required this.harvest});

  @override
  _DetailHarvestState createState() => _DetailHarvestState();
}

class _DetailHarvestState extends State<DetailHarvest> {

  @override
  Widget build(BuildContext context) {
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
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: CardHarvestDetail(
                  harvest: widget.harvest,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
