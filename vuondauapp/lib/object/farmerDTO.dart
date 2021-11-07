import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class FarmerDTO{
  String id;
  String email;
  String full_name;
  String phone;
  DateTime birth_day;
  bool gender;
  DateTime date_of_create;
  bool status;

  FarmerDTO({
    required this.id,
    required this.email,
    required this.full_name,
    required this.phone,
    required this.birth_day,
    required this.gender,
    required this.date_of_create,
    required this.status,
  });

  factory FarmerDTO.fromJson(Map<String, dynamic> json){

    return FarmerDTO(
        id: json['id'],
        full_name: json['full_name'],
        email: json['email'],
        phone: json['phone'],
        birth_day: DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['birth_day']),
        gender: json['gender']== 0 ? false : true,
        date_of_create: DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['date_of_create']),
        status:     json['status']== 0 ? false : true
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['full_name'] = this.full_name;
    data['phone'] = this.phone;
    data['birth_day'] = DateFormat('yyyy-MM-ddThh:mm:ss').format(this.birth_day);
    data['gender'] = this.gender;
    data['date_of_create'] = DateFormat('yyyy-MM-ddThh:mm:ss').format(this.date_of_create);
    data['status'] = this.status;
    return data;
  }
}