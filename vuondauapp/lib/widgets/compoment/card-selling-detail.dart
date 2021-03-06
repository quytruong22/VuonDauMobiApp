import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
import 'package:vuondauapp/widgets/compoment/status_selling.dart';

class CardSellingDetail extends StatelessWidget {
  CardSellingDetail({required this.selling,required this.tap,
    this.imgHarvest='https://cdn1.tuoitre.vn/zoom/600_315/2020/9/22/dau-tay-1600743428804672157496-crop-16007435512231711659798.jpg',
    required this.imgProduct
  });

  final HarvestSellingPriceDTO selling;
  final Function()  tap;
  final String  imgProduct;
  final String  imgHarvest;
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Container(
                  //  height: size.height*0.5,
                  //    width: size.width-20,
                  //    decoration: BoxDecoration(
                  //        image: DecorationImage(
                  //         image: NetworkImage(imgHarvest),
                  //          fit: BoxFit.cover,
                  //        )
                  //    )
                  //),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 8.0,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('T??n s???n ph???m: '+selling.harvestSelling.harvest.product.name,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                                SizedBox(height: 8.0,),
                                Text('N??ng tr???i: ' +selling.harvestSelling.harvest.farm.name),
                                SizedBox(height: 8.0,),
                                Text('M??a v???: ' +selling.harvestSelling.harvest.name+''),
                                SizedBox(height: 8.0,),
                                StatusSelling(datestart: selling.harvestSelling.dateOfCreate, dateend: selling.harvestSelling.endDate),
                                SizedBox(height: 8.0,),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    height: size.height*0.25,
                                    width: size.width*0.5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(imgProduct),
                                          fit: BoxFit.cover,
                                        )
                                    )
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('  T???ng s???n l?????ng: ${selling.harvestSelling.totalWeight}Kg',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 8.0,),
                                      Text('  Gi??: ${selling.price}VND/Kg',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 8.0,),
                                      Text('  Ng??y m??? b??n: '+DateFormat('dd/MM/yyyy').format(selling.harvestSelling.dateOfCreate),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 8.0,),
                                      Text('  Ng??y k???t th??c: '+DateFormat('dd/MM/yyyy').format(selling.harvestSelling.endDate),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 8.0,),
                                    ]
                                  )
                                )
                              ],

                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: tap,
                                child: Text(
                                  'C???p nh???t ?????t b??n',
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