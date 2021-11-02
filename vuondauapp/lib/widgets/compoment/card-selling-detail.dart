import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vuondauapp/widgets/compoment/status_harvest.dart';

class CardSellingDetail extends StatelessWidget {
  CardSellingDetail({this.name = "Placeholder Title",this.description = "",required this.imgharvest,this. quantity = "",this.price = "",this.farmname = "",required this.imgproduct,required this.datestart,required this.dateend});

  final String description;
  final String imgharvest;
  final String imgproduct;
  final String name;
  final String quantity;
  final String price;
  final String farmname;
  final DateTime datestart;
  final DateTime dateend;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: null,
        child: GestureDetector(
          child: Card(
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height*0.25,
                      width: size.width-20,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imgharvest),
                            fit: BoxFit.cover,
                          )
                      )
                  ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(farmname,
                                style: TextStyle(
                                    color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8.0,),
                            Text(description,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 8.0,),
                            Container(
                                height: size.height*0.25,
                                width: size.width*0.5,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(imgproduct),
                                      fit: BoxFit.cover,
                                    )
                                )
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(name,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13)),
                                StatusHarvest(datestart: datestart, dateend: dateend)
                              ],
                            ),
                            SizedBox(height: 8.0,),
                            Text(quantity,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 8.0,),
                            Text(price,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 8.0,),
                            Text('Ngày mở bán: '+DateFormat('dd/MM/yyyy').format(datestart),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 8.0,),
                            Text('Ngày kết thúc: '+DateFormat('dd/MM/yyyy').format(dateend),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 8.0,),
                            TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: (){
                                  Navigator.pushNamed(context, '/updateselling');
                                },
                                child: Text(
                                  'Cập nhật đợt bán',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                            )
                          ],
                        ),
                      )
                ],
              )),
        ));
  }
}
