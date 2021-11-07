import 'package:vuondauapp/object/harvestSellingDTO.dart';

class HarvestSellingPriceDTO {
  final String id;
  final double price;
  final HarvestSellingDTO harvestSelling;
  final int status;

  HarvestSellingPriceDTO({
    required this.id,
    required this.price,
    required this.harvestSelling,
    required this.status,
  });

  factory HarvestSellingPriceDTO.fromJson(Map<String, dynamic> json){
    return HarvestSellingPriceDTO(
        id: json['id'],
        price: json['price'],
        harvestSelling: HarvestSellingDTO.fromJson(json['harvest_selling']),
        status: json['status']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    if (this.harvestSelling != null) {
      data['harvest_selling'] = this.harvestSelling.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}
class ListHarvestSellingPrice{
  final List<HarvestSellingPriceDTO> harvestsellingprice;

  ListHarvestSellingPrice({required this.harvestsellingprice});

  factory ListHarvestSellingPrice.fromJson(List<dynamic> parsedJson) {

    List<HarvestSellingPriceDTO> harvestsellingprice = parsedJson.map((i)=>HarvestSellingPriceDTO.fromJson(i)).toList();
    return new ListHarvestSellingPrice(
      harvestsellingprice: harvestsellingprice,
    );
  }
}