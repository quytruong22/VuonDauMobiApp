import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestPicture.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/status_harvests.dart';

class CardHarvestDetail extends StatefulWidget {
  CardHarvestDetail({required this.harvest,required this.tap});

  final HarvestDTO harvest;
  final Function()  tap;

  @override
  State<CardHarvestDetail> createState() => _CardHarvestDetailState();
}

class _CardHarvestDetailState extends State<CardHarvestDetail> {
  final HttpService httpService = HttpService();
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
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.harvest.name,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                                SizedBox(height: 8.0,),
                                Text('(Nông trại: '+widget.harvest.farm.name+')'),
                                SizedBox(height: 8.0,),
                                StatusHarvest(status: widget.harvest.status)
                              ],
                            ),
                            SizedBox(height: 8.0,),
                            Text('Ngày bắt đầu: '+DateFormat('dd/MM/yyyy').format(widget.harvest.start_date)),
                            SizedBox(height: 8.0,),
                            Text('Ngày kết thúc: '+DateFormat('dd/MM/yyyy').format(widget.harvest.end_date)),
                            SizedBox(height: 8.0,),
                            Text('Mô tả: '+widget.harvest.description,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 8.0,),
                            Row(
                              children: [
                                FutureBuilder(
                                    future: httpService.getHarvestImage(widget.harvest.ID),
                                    builder: (BuildContext context, AsyncSnapshot<HarvestPicture> snapshot) {
                                      if(snapshot.hasData){
                                        HarvestPicture img = snapshot.requireData;
                                        return Container(
                                            height: size.width*0.4,
                                            width: size.width*0.45,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(img.src),
                                                  fit: BoxFit.cover,
                                                )
                                            )
                                        );
                                      }
                                      if(snapshot.hasError){
                                        return Container(
                                            height: size.width*0.4,
                                            width: size.width*0.45,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage('https://cdn.discordapp.com/attachments/900392963639750657/905113971948941332/iconVuondau.png'),
                                                  fit: BoxFit.cover,
                                                )
                                            )
                                        );
                                      }
                                      return const Center(child: CircularProgressIndicator());
                                    }
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                                  //height: size.height*0.25,
                                  width: size.width*0.4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Tên sản phẩm: '+widget.harvest.product.name,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold
                                          )
                                      ),
                                      SizedBox(height: 4.0,),
                                      Text('Mô tả: '+widget.harvest.product.description,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 4.0,),
                                      Text('Loại sản phẩm: '+widget.harvest.product.product_type.name,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 4.0,),
                                      Text('Ngày thu hoạch: '+DateFormat('dd/MM/yyyy').format(widget.harvest.start_date),
                                          style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600)
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
                                onPressed: widget.tap,
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
