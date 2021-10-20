import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/rounded_button.dart';
import 'package:vuondauapp/widgets/drawer.dart';
import 'package:vuondauapp/widgets/compoment/card-farm.dart';
import 'package:vuondauapp/object/farmDTO.dart';

class Farm extends StatefulWidget {
  const Farm({Key? key}) : super(key: key);

  @override
  _FarmState createState() => _FarmState();
}

class _FarmState extends State<Farm> {
  List<FarmDTO> list = [
    FarmDTO(ID: 0,name: 'Nông trại Phan Nam',address: '',description: '', img: 'https://thamhiemmekong.com/wp-content/uploads/2020/12/nongtraiphannam01.jpg'),
    FarmDTO(ID: 0, name: 'Nông trại Whiteface', address: '', description: '', img: 'https://kenh14cdn.com/M2JlccccccccccccEmJzVu2ZOVx8FL/Image/2015a/trangtrai/6-b1900.jpg'),
    FarmDTO(ID: 0, name: 'Trường Thành Farm', address: '', description: '', img: 'https://tamnhin.trithuccuocsong.vn/stores/news_dataimages/phonghv/072019/18/07/5336_20190715_145456.jpg')
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Nông trại'),
        centerTitle: true,
      ),
      drawer: pageDrawer(currentPage: "Farms"),
      floatingActionButton: RoundedButton(
        text: "Thêm nông trại mới",
        press: () {
          Navigator.pushNamed(context, '/addfarm');
        },
      ),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: list.map((farm) => Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            child: CardFarm(
                                cta: "Xem chi tiết",
                                title: farm.name,
                                img: farm.img,
                                tap: () {
                                  Navigator.pushNamed(context, '/detailfarm');
                                }),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ),
                SizedBox(height: 50),
              ]
            )
        ),
      ),
    );
  }
}
