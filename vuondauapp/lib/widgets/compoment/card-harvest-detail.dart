import 'package:flutter/material.dart';

class CardHarvestDetail extends StatelessWidget {
  CardHarvestDetail(
      {this.name = "Placeholder Title",
      this.description = "",
      this.img = "https://via.placeholder.com/200",
        this. quantity = "",
        this.price = "",
      });

  final String description;
  final String img;
  final String name;
  final String quantity;
  final String price;

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
                    width: size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('https://cdn.tgdd.vn/Products/Images/8788/223378/bhx/dau-tay-hop-500g-202103180809491848.jpg'),
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
                            Text(name,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13)),
                            Text(description,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                            Text(quantity,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                            Text(price,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      )
                ],
              )),
        ));
  }
}
