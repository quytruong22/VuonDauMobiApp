import 'package:flutter/material.dart';
import 'package:vuondauapp/pages/farm/farm_detail.dart';
import 'package:vuondauapp/widgets/compoment/card-farm.dart';
import 'package:vuondauapp/object/farmDTO.dart';

class Farm extends StatefulWidget {
  const Farm({Key? key}) : super(key: key);

  @override
  _FarmState createState() => _FarmState();
}

class _FarmState extends State<Farm> {
  // List<FarmDTO> list = [
  //   FarmDTO(ID: 0,name: 'Nông trại Phan Nam',address: '',description: '', img: 'https://thamhiemmekong.com/wp-content/uploads/2020/12/nongtraiphannam01.jpg'),
  //   FarmDTO(ID: 0, name: 'Nông trại Whiteface', address: '', description: '', img: 'https://kenh14cdn.com/M2JlccccccccccccEmJzVu2ZOVx8FL/Image/2015a/trangtrai/6-b1900.jpg'),
  //   FarmDTO(ID: 0, name: 'Trường Thành Farm', address: '', description: '', img: 'https://tamnhin.trithuccuocsong.vn/stores/news_dataimages/phonghv/072019/18/07/5336_20190715_145456.jpg')
  // ];

  @override
  Widget build(BuildContext context) {
    final List<FarmDTO> list=ModalRoute.of(context)!.settings.arguments as List<FarmDTO>;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Nông trại'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, '/addfarm');
        },
        icon: Icon(Icons.add),
        label: Text('Nông trại mới'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        width: size.width-20,
        height: size.height,
        child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Column(
                    children: list.map((farm) => Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: CardFarm(
                                farm: farm,
                                tap: () {
                                  Navigator.push(context,MaterialPageRoute(
                                      builder: (context) => const DetailFarm(),
                                      settings: RouteSettings(
                                      arguments: farm,
                                      ),
                                  ));
                                }),
                          ),
                        ],
                      ),
                    )).toList(),
                  ),
                ),
                SizedBox(height: 45),
              ]
            )
        ),
      ),
    );
  }
}
