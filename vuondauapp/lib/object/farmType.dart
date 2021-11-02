import 'package:flutter/foundation.dart';

class FarmType {
  String id;
  String name;
  String description;

  FarmType({required this.id, required this.name, required this.description});

  factory FarmType.fromJson(Map<String, dynamic> json) {
    return FarmType(
        id: json['id'],
        name: json['name'],
        description: json['description']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}