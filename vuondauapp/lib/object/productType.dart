class ProductType{
  final String id;
  final String name;
  final String description;

  ProductType({required this.id, required this.name, required this.description});

  factory ProductType.fromJson(Map<String, dynamic> json){
    return ProductType(
        id:           json['id'],
        name:         json['name'],
        description:  json['description']
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}