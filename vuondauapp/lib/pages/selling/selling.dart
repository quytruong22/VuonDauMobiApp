import 'package:flutter/material.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/widgets/compoment/card-selling.dart';
import 'package:vuondauapp/widgets/compoment/search_widget.dart';

class Selling extends StatefulWidget {
  final List<HarvestSellingPriceDTO>  sellings;


  Selling({required this.sellings});

  @override
  _SellingState createState() => _SellingState();
}

class _SellingState extends State<Selling> {
  late List<HarvestSellingPriceDTO> data;
  late List<HarvestSellingPriceDTO> list;
  String query = '';

  @override
  void initState() {
    super.initState();
    data = widget.sellings;
    list = data;
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
      this.list=list;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Đợt bán'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, '/addselling');
        },
        icon: Icon(Icons.add),
        label: Text('Đợt bán mới'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
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
                            tap: () {
                              Navigator.pushNamed(context, '/detailselling');
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