import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vuondauapp/object/harvestSellingPriceDTO.dart';
import 'package:vuondauapp/object/productPicture.dart';
import 'package:vuondauapp/services/http_service.dart';
import 'package:vuondauapp/widgets/compoment/status_selling.dart';

class CardSelling extends StatefulWidget {
  CardSelling(
      {required this.selling,
        required this.tap});

  final HarvestSellingPriceDTO selling;
  final Function() tap;

  @override
  State<CardSelling> createState() => _CardSellingState();
}

class _CardSellingState extends State<CardSelling> {
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
                  flex: 3,
                  child: FutureBuilder(
                    future: httpService.getProductImage(widget.selling.harvestSelling.harvest.product.id),
                    builder: (BuildContext context, AsyncSnapshot<ProductPicture> snapshot) {
                      if(snapshot.hasData){
                        final String img = snapshot.requireData.src;
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.0),
                                    bottomLeft: Radius.circular(6.0)),
                                image: DecorationImage(
                                  image: NetworkImage(img),
                                  fit: BoxFit.cover,
                                )));
                      }
                      if(snapshot.hasError){
                        return  Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.0),
                                    bottomLeft: Radius.circular(6.0)),
                                image: DecorationImage(
                                  image: NetworkImage('https://cdn.discordapp.com/attachments/900392963639750657/905113971948941332/iconVuondau.png'),
                                  fit: BoxFit.cover,
                                )));
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  )
                ),
                Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.selling.harvestSelling.harvest.name,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
                          Text('Sản phẩm: '+widget.selling.harvestSelling.harvest.product.name,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13)),
                          Text('Tổng sản lượng: ${widget.selling.harvestSelling.totalWeight} Kg',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 13)),
                          Text('Giá: ${widget.selling.price}VND/Kg',
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
                              StatusSelling(datestart: widget.selling.harvestSelling.dateOfCreate, dateend: widget.selling.harvestSelling.endDate)
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