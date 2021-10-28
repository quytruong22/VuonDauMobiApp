import 'package:flutter/material.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/drawer.dart';
import 'package:vuondauapp/widgets/compoment/rounded_icon_button.dart';

class Harvest extends StatefulWidget {
  const Harvest({Key? key}) : super(key: key);

  @override
  _HarvestState createState() => _HarvestState();
}

class _HarvestState extends State<Harvest> {
  List<HarvestDTO> list = [
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Dâu', description: '', img: 'https://cdn1.tuoitre.vn/zoom/600_315/2020/9/22/dau-tay-1600743428804672157496-crop-16007435512231711659798.jpg',
        date: DateTime.now()), name: 'Dâu', description: '', price: 50000, quantity: 50),
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Dâu', description: '', img: 'https://cdn1.tuoitre.vn/zoom/600_315/2020/9/22/dau-tay-1600743428804672157496-crop-16007435512231711659798.jpg',
        date: DateTime.now()), name: 'Dâu', description: '', price: 50000, quantity: 50),
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Dâu', description: '', img: 'https://cdn1.tuoitre.vn/zoom/600_315/2020/9/22/dau-tay-1600743428804672157496-crop-16007435512231711659798.jpg',
        date: DateTime.now()), name: 'Dâu', description: '', price: 50000, quantity: 50),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Đợt bán'),
        centerTitle: true,
      ),
      drawer: pageDrawer(currentPage: "Harvests"),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RoundedIconButton(
                text: "Tạo đợt bán mới",
                press: () {
                  Navigator.pushNamed(context, '/addharvest');
                },
              ),
              Column(
                children: list.map((harvest) => Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: CardHarvest(
                            cta: "Xem chi tiết",
                            title: harvest.name,
                            img: harvest.product.img,
                            quantity: 'Số lượng còn lại: ${harvest.quantity} Kg',
                            price: 'Giá: ${harvest.price}VND/Kg',
                            tap: () {
                              Navigator.pushNamed(context, '/detailharvest');
                            }),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}