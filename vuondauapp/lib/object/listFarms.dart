import 'package:vuondauapp/object/farmDTO.dart';

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