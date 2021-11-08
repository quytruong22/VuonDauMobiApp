import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vuondauapp/object/harvestDTO.dart';

class CardHarvestDetail extends StatelessWidget {
  CardHarvestDetail({required this.harvest});

  final HarvestDTO harvest;
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
                            image: NetworkImage('https://cdn.discordapp.com/attachments/900392963639750657/905113971948941332/iconVuondau.png'),
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
                            Text('Mùa vụ: '+harvest.name,
                                style: TextStyle(
                                    color: Colors.green, fontSize: 13, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8.0,),
                            Text('Mô tả: '+harvest.description,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 8.0,),
                            Row(
                              children: [
                                Container(
                                    height: size.height*0.25,
                                    width: size.width*0.5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage('https://cdn.discordapp.com/attachments/900392963639750657/905113971948941332/iconVuondau.png'),
                                          fit: BoxFit.cover,
                                        )
                                    )
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  height: size.height*0.25,
                                  width: size.width*0.4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Tên sản phẩm: '+harvest.product.name,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 13
                                          )
                                      ),
                                      Text('Ngày thu hoạch: '+DateFormat('dd/MM/yyyy').format(harvest.start_date),
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 10
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8.0,),
                              ],
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: (){
                                  Navigator.pushNamed(context, '/updateharvest');
                                },
                                child: Text(
                                  'Cập nhật mùa vụ',
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
