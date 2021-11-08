import 'package:flutter/material.dart';
import 'package:vuondauapp/object/order.dart';
import 'package:vuondauapp/object/orderDetail.dart';
import 'package:expansion_card/expansion_card.dart';


class CardOrder extends StatefulWidget {
  final Order order;
  final List<OrderDetail> orderdetails;

  CardOrder({required this.order, required this.orderdetails});

  @override
  _CardOrderState createState() => _CardOrderState();
}

class _CardOrderState extends State<CardOrder> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ExpansionCard(
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.order.message,
                ),
                Text(
                  "Sub",
                ),
              ],
            ),
          ),
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7),
              child: Column(
                children: [

                ],
              ),
            )
          ],
        )
    );
  }
}
