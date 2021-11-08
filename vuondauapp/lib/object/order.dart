import 'package:intl/intl.dart';
import 'package:vuondauapp/object/campaign.dart';
import 'package:vuondauapp/object/customer.dart';

class Order{
  String id;
  Customer  customer;
  Campaign  campaign;
  DateTime  date_of_create;
  String  full_name;
  String  message;
  String  phone;
  String  address;
  int total_price;
  int status;

  Order(
      {required this.id,
        required this.customer,
        required this.campaign,
        required this.date_of_create,
        required this.full_name,
        required this.message,
        required this.phone,
        required this.address,
        required this.total_price,
        required this.status});

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
        id:           json['id'],
        customer:     Customer.fromJson(json['customer']),
        campaign:     Campaign.fromJson(json['campaign']),
        full_name:    json['full_name'],
        message:         json['message'],
        address:      json['address'],
        phone:  json['phone'],
        date_of_create: DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['date_of_create']),
        total_price: json['total_price'],
        status:     json['status']
    );
  }
}

class ListOrders{
  final List<Order> orders;

  ListOrders({required this.orders});

  factory ListOrders.fromJson(List<dynamic> parsedJson) {

    List<Order> orders = parsedJson.map((i)=>Order.fromJson(i)).toList();
    return new ListOrders(
      orders: orders,
    );
  }
}