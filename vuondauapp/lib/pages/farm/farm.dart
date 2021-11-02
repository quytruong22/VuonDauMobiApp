import 'package:flutter/material.dart';
import 'package:vuondauapp/object/listFarms.dart';
import 'package:vuondauapp/widgets/compoment/card-farm.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

  Future<List<FarmDTO>> fetchFarmDTO() async {
  final response = await http.get(Uri.parse('http://52.221.245.187:90/api/v1/farms'));

  if (response.statusCode == 200) {
    return ListFarms.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Farm');
  }
}

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
  late List<FarmDTO> list;

  Future<void> initState() async {
    super.initState();
    list = await fetchFarmDTO();
  }

  @override
  Widget build(BuildContext context) {
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
        width: size.width,
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
                                  Navigator.pushNamed(context, '/detailfarm');
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
