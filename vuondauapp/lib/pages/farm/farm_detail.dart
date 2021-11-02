import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest.dart';
import 'package:vuondauapp/widgets/compoment/card-farm-detail.dart';

class DetailFarm extends StatefulWidget {
  const DetailFarm({Key? key}) : super(key: key);

  @override
  _DetailFarmState createState() => _DetailFarmState();
}

class _DetailFarmState extends State<DetailFarm> {
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
    final FarmDTO farm = ModalRoute.of(context)!.settings.arguments as FarmDTO;
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
                      farm: farm,
                      ),
                ),
                RoundedButton(
                  text: "Tạo mùa vụ mới",
                  press: () {
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
                )
              ],
          ),
        ),
      ),
    );
  }
}
