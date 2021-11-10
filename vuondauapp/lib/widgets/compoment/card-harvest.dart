import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vuondauapp/object/harvestDTO.dart';
import 'package:vuondauapp/object/harvestPicture.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/status_harvests.dart';

class CardHarvest extends StatefulWidget {
  CardHarvest(
      {required this.harvest,
      required this.tap});

  final HarvestDTO harvest;
  final Function() tap;

  @override
  State<CardHarvest> createState() => _CardHarvestState();
}

class _CardHarvestState extends State<CardHarvest> {
  final HttpService httpService = HttpService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 130,
        width: size.width-20,
        child: GestureDetector(
          onTap: widget.tap,
          child: Card(
            elevation: 0.6,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: FutureBuilder(
                    future: httpService.getHarvestImage(widget.harvest.ID),
                    builder: (BuildContext context, AsyncSnapshot<HarvestPicture> snapshot) {
                      if(snapshot.hasData){
                        HarvestPicture img = snapshot.requireData;
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.0),
                                    bottomLeft: Radius.circular(6.0)),
                                image: DecorationImage(
                                  image: NetworkImage(img.src),
                                  fit: BoxFit.cover,
                                ))
                        );
                      }
                      if(snapshot.hasError){
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.0),
                                    bottomLeft: Radius.circular(6.0)),
                                image: DecorationImage(
                                  image: NetworkImage('https://cdn.discordapp.com/attachments/900392963639750657/905113971948941332/iconVuondau.png'),
                                  fit: BoxFit.cover,
                                ))
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    })
                ),
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.harvest.name,
                              style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
                          Text('Nông trại: '+widget.harvest.farm.name,
                              style: TextStyle(color: Colors.black, fontSize: 13)),
                          Text('Ngày thu hoạch dự kiến: '+DateFormat('dd/MM/yyyy').format(widget.harvest.start_date),
                              style: TextStyle(
                                  fontSize: 13)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Xem chi tiết',
                                style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.w600)
                              ),
                              StatusHarvest(status: widget.harvest.status)
                            ],
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
