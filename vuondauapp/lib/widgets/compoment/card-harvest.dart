import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardHarvest extends StatelessWidget {
  CardHarvest(
      {this.title = "Placeholder Title",
      this.cta = "",
      required this.sold,
        this.nameFarm = "",
      required this.img,
      required this.tap});

  final String cta;
  final String img;
  final Function() tap;
  final String title;
  final DateTime sold;
  final String nameFarm;

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
                          Text('Nông trại: '+nameFarm,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13)),
                          Text('Ngày thu hoạch dự kiến: '+DateFormat('dd/MM/yyyy').format(sold),
                              style: TextStyle(
                                  fontSize: 13)),
                          Text(cta,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600)
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        ));
  }
}
