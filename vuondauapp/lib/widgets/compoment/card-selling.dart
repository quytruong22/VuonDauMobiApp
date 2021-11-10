import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
import 'package:vuondauapp/widgets/compoment/status_selling.dart';

class CardSelling extends StatelessWidget {
  CardSelling(
      {required this.selling,
        this.img='https://cdn.discordapp.com/attachments/900392963639750657/905113971948941332/iconVuondau.png',
        required this.tap});

  final HarvestSellingPriceDTO selling;
  final String  img;
  final Function() tap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 130,
        width: size.width-20,
        child: GestureDetector(
          onTap: tap,
          child: Card(
            elevation: 0.6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.0),
                              bottomLeft: Radius.circular(6.0)),
                          image: DecorationImage(
                            image: NetworkImage(img),
                            fit: BoxFit.cover,
                          ))),
                ),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(selling.harvestSelling.harvest.name,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
                          Text('Sản phẩm: '+selling.harvestSelling.harvest.product.name,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13)),
                          Text('Tổng sản lượng: ${selling.harvestSelling.totalWeight} Kg',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13)),
                          Text('Giá: ${selling.price}VND/Kg',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Xem chi tiết",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600)
                              ),
                              StatusSelling(datestart: selling.harvestSelling.dateOfCreate, dateend: selling.harvestSelling.endDate)
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}