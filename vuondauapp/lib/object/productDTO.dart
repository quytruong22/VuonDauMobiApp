import 'package:intl/intl.dart';
import 'package:vuondauapp/object/productType.dart';

class ProductDTO{
  final String id;
  final ProductType product_type;
  final String name;
  final String description;
  final bool  status;

  ProductDTO({required this.id, required this.name, required this.description, required this.product_type,required  this.status});

  factory ProductDTO.fromJson(Map<String, dynamic> json){

    return ProductDTO(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        status:     json['status']== 0 ? false : true,
        product_type: ProductType.fromJson(json['product_type'])
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product_type != null) {
      data['product_type'] = this.product_type.toJson();
    }
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    return data;
  }
}

class ListProducts{
  final List<ProductDTO> products;

  ListProducts({required this.products});

  factory ListProducts.fromJson(List<dynamic> parsedJson) {

    List<ProductDTO> products = parsedJson.map((i)=>ProductDTO.fromJson(i)).toList();
    return new ListProducts(
      products: products,
    );
  }
}