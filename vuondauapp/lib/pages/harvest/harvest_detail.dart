import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/card-harvest-detail.dart';

class DetailHarvest extends StatefulWidget {
  const DetailHarvest({Key? key}) : super(key: key);

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
                child: CardHarvestDetail(
                  description: "Mô tả: Dâu của nông trại Phan Nam thơm ngon, chín tươi.",
                  name: 'Tên sản phẩm: Dâu',
                  farmname: 'Nông trại: Nông trại Phan Nam',
                  imgharvest: 'https://cdn1.tuoitre.vn/zoom/600_315/2020/9/22/dau-tay-1600743428804672157496-crop-16007435512231711659798.jpg',
                  imgproduct: 'https://cdn.tgdd.vn/Products/Images/8788/223378/bhx/dau-tay-hop-500g-202103180809491848.jpg',
                  quantity: 'Số lượng còn lại: 50Kg',
                  price: 'Giá: 50.000VND/Kg',
                  datestart: DateTime(2021,11,30),
                  dateend: DateTime(2021,12,30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
