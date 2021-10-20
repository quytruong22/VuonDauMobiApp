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
        title: Text('Mùa vụ'),
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
                  img: 'https://thamhiemmekong.com/wp-content/uploads/2020/12/nongtraiphannam01.jpg',
                  quantity: 'Số lượng còn lại: 50Kg',
                  price: 'Giá: 50.000VND/Kg',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
