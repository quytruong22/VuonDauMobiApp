import 'package:vuondauapp/object/harvestSellingDTO.dart';
import 'package:vuondauapp/object/order.dart';

class OrderDetail{
  String  id;
  HarvestSellingDTO harvestselling;
  Order order;
  double  weight;
  int price;
  int status;

  OrderDetail(
      {required this.id,
        required this.harvestselling,
        required this.order,
        required this.weight,
        required this.price,
        required this.status});

  factory OrderDetail.fromJson(Map<String, dynamic> json){
    return OrderDetail(
        id:           json['id'],
        harvestselling:     HarvestSellingDTO.fromJson(json['harvestselling']),
        order:     Order.fromJson(json['order']),
        weight: json['weight'],
        price: json['price'],
        status:     json['status']
    );
  }
}

class ListOrderDetails{
  final List<OrderDetail> orderdetails;

  ListOrderDetails({required this.orderdetails});

  factory ListOrderDetails.fromJson(List<dynamic> parsedJson) {

    List<OrderDetail> orderdetails = parsedJson.map((i)=>OrderDetail.fromJson(i)).toList();
    return new ListOrderDetails(
      orderdetails: orderdetails,
    );
  }
}