class HarvestSellingPriceDTO {
  final String id;
  final double price;
  final String harvestSellingID;
  final int status;

  HarvestSellingPriceDTO({
    required this.id,
    required this.price,
    required this.harvestSellingID,
    required this.status,
  });

  factory HarvestSellingPriceDTO.fromJson(Map<String, dynamic> json){
    return HarvestSellingPriceDTO(
        id: json['id'],
        price: json['price'],
        harvestSellingID: json[''],
        status: json['status']
    );
  }
}