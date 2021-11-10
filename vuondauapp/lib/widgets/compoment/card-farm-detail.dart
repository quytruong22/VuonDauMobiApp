import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmPicture.dart';
import 'package:vuondauapp/services/http_service.dart';

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
                  ListTile(
                    title: Text(widget.farm.name),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Miền:'),
                            Text(widget.farm.area.name),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Địa chỉ:'),
                            Text(widget.farm.address),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Mô tả:'),
                            Text(widget.farm.description),
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
