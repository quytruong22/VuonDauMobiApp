import 'package:vuondauapp/object/farmDTO.dart';

class FarmPicture {
  String id;
  FarmDTO farm;
  String src;
  String alt;

  FarmPicture({required this.id, required this.farm, required this.src, required this.alt});

  factory FarmPicture.fromJson(Map<String, dynamic> json) {
    return FarmPicture(
        id: json['id'],
        farm: FarmDTO.fromJson(json['farm']),
        src: json['src'],
        alt: json['alt']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.farm != null) {
      data['farm'] = this.farm.toJson();
    }
    data['src'] = this.src;
    data['alt'] = this.alt;
    return data;
  }
}

class ListFarmPicture{
  final List<FarmPicture> farms;

  ListFarmPicture({required this.farms});

  factory ListFarmPicture.fromJson(List<dynamic> parsedJson) {

    List<FarmPicture> farms = parsedJson.map((i)=>FarmPicture.fromJson(i)).toList();
    return new ListFarmPicture(
      farms: farms,
    );
  }
}