import 'package:vuondauapp/object/productDTO.dart';

class HarvestDTO {
  final int ID;
  final ProductDTO product;
  final String name;
  final String description;
  final double price;
  final double quantity;

  HarvestDTO({required this.ID, required this.product, required this.name, required this.description, required this.price,
      required this.quantity});
}