import 'package:flutter/material.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
import 'package:vuondauapp/pages/selling/selling_update.dart';
import 'package:vuondauapp/widgets/compoment/card-selling-detail.dart';

import '../navpage.dart';

class DetailSelling extends StatefulWidget {
  final HarvestSellingPriceDTO  selling;
  final String  imgProduct;

  DetailSelling({required this.selling,required this.imgProduct});

  @override
  _DetailSellingState createState() => _DetailSellingState();
}

class _DetailSellingState extends State<DetailSelling> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Chi tiết đợt bán'),
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
                child: CardSellingDetail(
                  selling: widget.selling,
                  tap: () async {

                    await Navigator.push(context,MaterialPageRoute(
                        builder: (context) => UpdateSelling(selling: widget.selling))
                    );
                  },
                  imgProduct: widget.imgProduct,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
