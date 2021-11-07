import 'package:flutter/foundation.dart';

class OrderDetailDTO {
  final String id;
  final dynamic harvestselling;
  final dynamic order;
  final double weight;
  final double price;
  final int status;

  OrderDetailDTO({
    required this.id,
    required this.harvestselling,
    required this.order,
    required this.weight,
    required this.price,
    required this.status
  });

  factory OrderDetailDTO.fromJson(Map<String, dynamic> json) {
    return OrderDetailDTO(id: json['id'] as String,
        harvestselling: json['harvestselling'] as dynamic,
        order: json['order'] as dynamic,
        weight: json['weight'] as double,
        price: json['price'] as double,
        status: json['status'] as int);
  }
}
