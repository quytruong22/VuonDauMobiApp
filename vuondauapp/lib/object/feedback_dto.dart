import 'package:flutter/foundation.dart';

class FeedbackDTO {
  final String id;
  final dynamic harvest;
  final dynamic order;
  final String date_of_create;
  final String description;
  final dynamic farmer;
  final int status;

  FeedbackDTO({
    required this.id,
    required this.harvest,
    required this.order,
    required this.date_of_create,
    required this.description,
    required this.farmer,
    required this.status
  });

  factory FeedbackDTO.fromJson(Map<String, dynamic> json) {
    return FeedbackDTO(id: json['id'] as String,
        harvest: json['harvest'] as dynamic,
        order: json['order'] as dynamic,
        date_of_create: json['date_of_create'] as String,
        description: json['description'] as String,
        farmer: json['farmer'] as dynamic,
        status: json['status'] as int);
  }
}
