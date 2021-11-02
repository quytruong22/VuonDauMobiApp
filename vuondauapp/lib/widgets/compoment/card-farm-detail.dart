import 'package:flutter/material.dart';

class CardFarmDetail extends StatelessWidget {
  CardFarmDetail(
      {this.name = "Placeholder Title",
      this.description = "",
      this.img = "https://via.placeholder.com/200",
      this.address = "",
      });

  final String description;
  final String img;
  final String name;
  final String address;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 325,
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
                            image: NetworkImage('https://thamhiemmekong.com/wp-content/uploads/2020/12/nongtraiphannam01.jpg'),
                            fit: BoxFit.cover,
                          ))),
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
                            SizedBox(height: 4.0,),
                            Row(
                              children: [
                                Text('Địa chỉ:'),
                                Text(address,
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600)),

                              ],
                            ),
                            SizedBox(height: 4.0,),
                            Text(description,
                                style: TextStyle(
                                    color: Colors.black38,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 4.0,),
                            TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: (){
                                  Navigator.pushNamed(context, '/updatefarm');
                                  },
                                child: Text(
                                    'Cập nhật nông trại',
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
