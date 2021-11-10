import 'package:flutter/material.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/farmPicture.dart';
import 'package:vuondauapp/services/http_service.dart';

class CardFarm extends StatefulWidget {
  CardFarm(
      {required this.farm,
      required this.tap});

  final FarmDTO farm;
  final Function() tap;

  @override
  State<CardFarm> createState() => _CardFarmState();
}

class _CardFarmState extends State<CardFarm> {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 250,
        width: size.width-20,
        child: GestureDetector(
          onTap: widget.tap,
          child: Card(
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 3,
                      child: FutureBuilder(
                        future: httpService.getFarmImage(widget.farm.ID),
                        builder: (BuildContext context, AsyncSnapshot<FarmPicture> snapshot) {
                          if(snapshot.hasData){
                            String img = snapshot.requireData.src;
                            return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6.0),
                                        topRight: Radius.circular(6.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(img),
                                      fit: BoxFit.cover,
                                    )
                                )
                            );
                          }
                          if(snapshot.hasError){
                            return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6.0),
                                        topRight: Radius.circular(6.0)),
                                    image: DecorationImage(
                                      image: NetworkImage('https://cdn.discordapp.com/attachments/900392963639750657/905113971948941332/iconVuondau.png'),
                                      fit: BoxFit.cover,
                                    )
                                )
                            );
                          }
                          return const Center(child: CircularProgressIndicator());
                        },
                      )
                  ),
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.farm.name,
                                style: TextStyle( fontSize: 13)),
                            Text('Xem chi tiết',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ))
                ],
              )),
        ));
  }
}
