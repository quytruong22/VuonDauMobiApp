import 'package:flutter/material.dart';

class CardHarvestDetail extends StatelessWidget {
  CardHarvestDetail({this.name = "Placeholder Title",this.description = "",this.img = "https://via.placeholder.com/200",this. quantity = "",this.price = "",this.farmname = ""});

  final String description;
  final String img;
  final String name;
  final String quantity;
  final String price;
  final String farmname;
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
                            Text(farmname,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13)),
                            SizedBox(height: 8.0,),
                            Text(name,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 13)),
                            SizedBox(height: 8.0,),
                            Text(description,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
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
                            Text('Ngày bắt đầu: 06/06/2021',
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
