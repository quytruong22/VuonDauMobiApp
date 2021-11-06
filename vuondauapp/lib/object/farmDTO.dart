import 'package:intl/intl.dart';
import 'package:vuondauapp/object/areaDTO.dart';
import 'package:vuondauapp/object/farmType.dart';
import 'package:vuondauapp/object/farmerDTO.dart';

class FarmDTO {
  final String ID;
  final FarmType farmType;
  final FarmerDTO farmer;
  final AreaDTO area;
  final String name;
  final String address;
  final String description;
  final DateTime dateOfCreate,dayOfUpdate;
  final int status;

  FarmDTO({
    required this.ID,
    required this.farmType,
    required this.farmer,
    required this.area,
    required this.name,
    required this.address,
    required this.description,
    required this.dateOfCreate,
    required this.dayOfUpdate,
    required this.status,
  });

  factory FarmDTO.fromJson(Map<String, dynamic> json){
    return FarmDTO(
        ID:           json['id'],
        farmType:     FarmType.fromJson(json['farm_type']),
        farmer:     FarmerDTO.fromJson(json['farmer']),
        area:       AreaDTO.fromJson(json['area']),
        name:         json['name'],
        address:      json['address'],
        description:  json['description'],
        dateOfCreate: DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['date_of_create']),
        dayOfUpdate:  DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['date_update']),
        status:     json['status']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.ID;
    if (this.farmType != null) {
      data['farm_type'] = this.farmType.toJson();
    }
    if (this.farmer != null) {
      data['farmer'] = this.farmer.toJson();
    }
    if (this.area != null) {
      data['area'] = this.area.toJson();
    }
    data['name'] = this.name;
    data['address'] = this.address;
    data['description'] = this.description;
    data['date_of_create'] = DateFormat('yyyy-MM-ddThh:mm:ss').format(this.dateOfCreate);
    data['date_update'] = DateFormat('yyyy-MM-ddThh:mm:ss').format(this.dayOfUpdate);
    data['status'] = this.status;
    return data;
  }
}

class ListFarms{
  final List<FarmDTO> farms;

  ListFarms({required this.farms});

  factory ListFarms.fromJson(List<dynamic> parsedJson) {

    List<FarmDTO> farms = parsedJson.map((i)=>FarmDTO.fromJson(i)).toList();
    return new ListFarms(
      farms: farms,
    );
  }
}