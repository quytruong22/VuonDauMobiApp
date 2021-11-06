import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Campaign {
  String id;
  DateTime startTime;
  DateTime endTime;
  int minOrderAmount;
  int status;

  Campaign(
      {required this.id,
        required this.startTime,
        required this.endTime,
        required this.minOrderAmount,
        required this.status});

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id : json['id'],
      startTime : DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['start_time']),
      endTime : DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['end_time']),
      minOrderAmount :json['min_order_amount'],
      status : json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_time'] = DateFormat('yyyy-MM-ddThh:mm:ss').format(this.startTime);
    data['end_time'] = DateFormat('yyyy-MM-ddThh:mm:ss').format(this.endTime);
    data['min_order_amount'] = this.minOrderAmount;
    data['status'] = this.status;
    return data;
  }
}