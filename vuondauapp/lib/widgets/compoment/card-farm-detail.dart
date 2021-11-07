import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vuondauapp/object/areaDTO.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmType.dart';
import 'package:vuondauapp/pages/farm/farm_update.dart';
import 'package:http/http.dart' as http;

class CardFarmDetail extends StatelessWidget {
  CardFarmDetail(
      {required this.farm,
        required  this.tap
      });

  final FarmDTO farm;
  final Function()  tap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width-20,
        child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0.4,
              child: Column(
                children: [
                  Container(
                    height: size.height*0.3,
                    width: size.width-20,
                    child: Image(
                      image: NetworkImage('https://thamhiemmekong.com/wp-content/uploads/2020/12/nongtraiphannam01.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListTile(
                    title: Text(farm.name),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Miền:'),
                            Text(farm.area.name),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Địa chỉ:'),
                            Text(farm.address),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Mô tả:'),
                            Text(farm.description),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: tap,
                          child: Text(
                            'Cập nhật nông trại',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: (){

                          },
                          child: Text(
                            'Xóa nông trại',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
        )
    );
  }
}
