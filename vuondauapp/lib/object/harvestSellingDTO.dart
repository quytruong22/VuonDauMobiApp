import 'package:intl/intl.dart';
import 'package:vuondauapp/object/campaign.dart';
import 'package:vuondauapp/object/harvestDTO.dart';

class HarvestSellingDTO {
  String id;
  HarvestDTO harvest;
  DateTime dateOfCreate;
  DateTime endDate;
  double minWeight;
  double totalWeight;
  int status;

  HarvestSellingDTO(
      {required this.id,
        required this.harvest,
        required this.dateOfCreate,
        required this.endDate,
        required this.minWeight,
        required this.totalWeight,
        required this.status});

  factory HarvestSellingDTO.fromJson(Map<String, dynamic> json) {
    return  HarvestSellingDTO(
        id : json['id'],
        harvest : HarvestDTO.fromJson(json['harvest']),
        dateOfCreate : DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['date_of_create']),
        endDate : DateFormat('yyyy-MM-ddThh:mm:ss').parse(json['end_date']),
        minWeight : json['min_weight'],
        totalWeight : json['total_weight'],
        status : json['status']
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.harvest != null) {
      data['harvest'] = this.harvest.toJson();
    }
    data['date_of_create'] = DateFormat('yyyy-MM-ddThh:mm:ss').format(this.dateOfCreate);
    data['end_date'] = DateFormat('yyyy-MM-ddThh:mm:ss').format(this.endDate);
    data['min_weight'] = this.minWeight;
    data['total_weight'] = this.totalWeight;
    data['status'] = this.status;
    return data;
  }
}

class ListHarvestSelling{
  final List<HarvestSellingDTO> harvestsellings;

  ListHarvestSelling({required this.harvestsellings});

  factory ListHarvestSelling.fromJson(List<dynamic> parsedJson) {

    List<HarvestSellingDTO> harvestsellings = parsedJson.map((i)=>HarvestSellingDTO.fromJson(i)).toList();
    return new ListHarvestSelling(
      harvestsellings: harvestsellings,
    );
  }
}