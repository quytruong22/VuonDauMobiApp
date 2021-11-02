import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vuondauapp/widgets/compoment/status_harvest.dart';

class CardSelling extends StatelessWidget {
  CardSelling(
      {this.title = "Placeholder Title",
        this.cta = "",
        this.price = "",
        this.quantity = "",
        this.sold = "",
        this.nameProduct = "",
        required this.img,
        required this.tap});

  final String cta;
  final String img;
  final String quantity;
  final String price;
  final Function() tap;
  final String title;
  final String sold;
  final String nameProduct;

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
                          Text(title,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
                          Text(nameProduct,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13)),
                          Text(quantity,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13)),
                          Text(price,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13)),
                          Text(sold,
                              style: TextStyle(
                                  color: Colors.red, fontSize: 13)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(cta,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600)
                              ),
                              StatusHarvest(datestart: DateTime(2021), dateend: DateTime(2023))
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