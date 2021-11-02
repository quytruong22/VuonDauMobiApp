class HarvestSellingDTO {
  final String id ;
  final String harvestID;
  final DateTime dateOfCreate, endDate;
  final double minWeight, totalWeight;
  final int status;

  HarvestSellingDTO({
    required this.id,
    required this.harvestID,
    required this.dateOfCreate,
    required this.endDate,
    required this.minWeight,
    required this.totalWeight,
    required this.status});

  factory HarvestSellingDTO.fromJson(Map<String, dynamic> json){
    return HarvestSellingDTO(
        id: json['id'],
        harvestID: json[''],
        dateOfCreate: json['date_of_create'],
        endDate: json['end_date'],
        minWeight: json['min_weight'],
        totalWeight: json['total_weight'],
        status:     json['status']
    );
  }
}