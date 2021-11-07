import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:vuondauapp/object/customer_type.dart';

class Customer {
  String id;
  CustomerType  customer_type;
  String email;
  String full_name;
  String phone;
  DateTime birth_day;
  bool gender;
  DateTime date_of_create;
  bool status;

  Customer({
    required this.id,
    required this.customer_type,
    required this.email,
    required this.full_name,
    required this.phone,
    required this.birth_day,
    required this.gender,
    required this.date_of_create,
    required this.status,
  });

  factory Customer.fromJson(Map<String, dynamic> json){

    return Customer(
        id: json['id'],
        customer_type: CustomerType.fromJson(json['customer_type_navigation']),
        full_name: json['full_name'],
        email: json['email'],
        phone: json['phone'],
        birth_day: DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['birth_day']),
        gender: json['gender']== 0 ? false : true,
        date_of_create: DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['date_of_create']),
        status:     json['status']== 0 ? false : true
    );
  }
}