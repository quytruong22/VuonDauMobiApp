import 'package:intl/intl.dart';
import 'package:vuondauapp/object/farmDTO.dart';
import 'package:vuondauapp/object/productDTO.dart';

class HarvestDTO {
  String ID;
  ProductDTO product;
  String name;
  String description;
  DateTime  start_date;
  DateTime  end_date;
  FarmDTO farm;
  bool  status;

  HarvestDTO({required this.ID, required this.product, required this.name, required this.description,
      required this.start_date, required this.end_date, required this.farm,required this.status});

  factory HarvestDTO.fromJson(Map<String, dynamic> json){
    return HarvestDTO(
        ID:           json['id'],
        product:     ProductDTO.fromJson(json['product']),
        farm:     FarmDTO.fromJson(json['farm']),
        name:         json['name'],
        description:  json['description'],
        start_date: DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['start_date']),
        end_date:  DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['end_date']),
        status:     json['status']== 0 ? false : true
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.ID;
    data['name'] = this.name;
    if (this.farm != null) {
      data['farm'] = this.farm.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['description'] = this.description;
    data['start_date'] = DateFormat('yyyy-MM-ddThh:mm:ss').format(this.start_date);
    data['end_date'] = DateFormat('yyyy-MM-ddThh:mm:ss').format(this.end_date);
    data['status'] = this.status;
    return data;
  }
}

class ListHarvests{
  final List<HarvestDTO> harvests;

  ListHarvests({required this.harvests});

  factory ListHarvests.fromJson(List<dynamic> parsedJson) {

    List<HarvestDTO> harvests = parsedJson.map((i)=>HarvestDTO.fromJson(i)).toList();
    return new ListHarvests(
      harvests: harvests,
    );
  }
}