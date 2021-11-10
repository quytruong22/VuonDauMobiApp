import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmPicture.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/status_farm.dart';

class CardFarmDetail extends StatefulWidget {
  CardFarmDetail(
      {required this.farm,
        required  this.tap
      });

  final FarmDTO farm;
  final Function()  tap;

  @override
  State<CardFarmDetail> createState() => _CardFarmDetailState();
}

class _CardFarmDetailState extends State<CardFarmDetail> {
  final HttpService httpService = HttpService();
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
                  ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.farm.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 8.0,),
                        StatusFarm(status: widget.farm.status),
                        SizedBox(height: 8.0,),
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: httpService.getFarmImage(widget.farm.ID),
                      builder: (BuildContext context, AsyncSnapshot<FarmPicture> snapshot) {
                        if(snapshot.hasData){
                          final String img = snapshot.requireData.src;
                          return Container(
                            height: size.height*0.3,
                            width: size.width-20,
                            child: Image(
                              image: NetworkImage(img),
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        if(snapshot.hasError){
                          return Container(
                            height: size.height*0.3,
                            width: size.width-20,
                            child: Image(
                              image: NetworkImage('https://cdn.discordapp.com/attachments/900392963639750657/905113971948941332/iconVuondau.png'),
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Thông tin chi tiết:',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                            ),
                            SizedBox(height: 15.0,),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Miền: '+widget.farm.area.name,
                              style: TextStyle(fontSize: 16)
                            ),
                            SizedBox(height: 4.0,),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Loại nông trại: '+widget.farm.farmType.name,
                                style: TextStyle(fontSize: 16)
                            ),
                            SizedBox(height: 4.0,),
                          ]
                        ),
                        Row(
                          children: [
                            Text('Địa chỉ: '+widget.farm.address,
                                style: TextStyle(fontSize: 16)
                            ),
                            SizedBox(height: 4.0,),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Ngày tạo: '+DateFormat('dd/MM/yyyy').format(widget.farm.dateOfCreate),
                                style: TextStyle(fontSize: 16)
                            ),
                            SizedBox(height: 4.0,),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Mô tả: '+widget.farm.description,
                                style: TextStyle(fontSize: 16)
                            ),
                            SizedBox(height: 8.0,),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: widget.tap,
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
