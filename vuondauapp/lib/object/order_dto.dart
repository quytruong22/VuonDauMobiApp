import 'package:flutter/foundation.dart';

class OrderDTO {
  final String id;
  final dynamic customer;
  final String date_of_create;
  final String address;
  final double total_price;
  final int status;

  OrderDTO({
    required this.id,
    required this.customer,
    required this.date_of_create,
    required this.address,
    required this.total_price,
    required this.status
  });

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(id: json['id'] as String,
        customer: json['customer'] as dynamic,
        date_of_create: json['date_of_create'] as String,
        address: json['address'] as String,
        total_price: json['total_price'] as double,
        status: json['status'] as int);
  }
}
