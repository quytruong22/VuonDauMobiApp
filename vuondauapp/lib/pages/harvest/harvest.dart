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
        date: DateTime.now()), name: 'Vụ Dâu Đà Lạt Mùa Đông', description: '', price: 100000, quantity: 50),
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Cà Chua', description: '', img: 'https://hoayeuthuong.com/hinh-hoa-tuoi/moingay/11894_ca-chua-kg.jpg',
        date: DateTime.now()), name: 'Vụ Cà chua Đà Lạt Mùa Đông', description: '', price: 50000, quantity: 100),
    HarvestDTO(ID: 0, product: ProductDTO(ID: 0, name: 'Cải thảo', description: '', img: 'https://images.unsplash.com/photo-1614540527480-1a0818eafcbb?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=435&q=80',
        date: DateTime.now()), name: 'Vụ rau Cải Thảo Đà Lạt Mùa Đông', description: '', price: 20000, quantity: 70),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Mùa vụ'),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              RoundedIconButton(
                text: "Tạo mùa vụ mới",
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
                            nameFarm: "Nông trại Phan Nam",
                            sold: DateTime.now(),
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