import 'package:flutter/material.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/compoment/search_widget.dart';

class Harvest extends StatefulWidget {
  final List<HarvestDTO> harvests;

  Harvest({required  this.harvests});

  @override
  _HarvestState createState() => _HarvestState();
}

class _HarvestState extends State<Harvest> {
  late List<HarvestDTO> data;
  late List<HarvestDTO> list;
  String query = '';

  @override
  void initState() {
    super.initState();
    data = widget.harvests;
    list = data;
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Tên mùa vụ',
    onChanged: searchHarvest,
  );

  void searchHarvest(String query) {
    list = data.where((harvest) {
      final namelower = harvest.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return namelower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      this.list=list;
    });
  }
  @override
  Widget build(BuildContext context) {
    data = widget.harvests;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Mùa vụ'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, '/addharvest');
        },
        icon: Icon(Icons.add),
        label: Text('Mùa vụ mới'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                              Navigator.pushNamed(context, '/detailharvest');
                            }),
                      ),
                    ],
                  ),
                )).toList(),
              ),
              SizedBox(height: 45,)
            ],
          ),
        ),
      ),
    );
  }
}