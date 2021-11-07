class CustomerType{
  String id;
  String name;
  String description;

  CustomerType({required this.id, required this.name, required this.description});

  factory CustomerType.fromJson(Map<String, dynamic> json) {
    return CustomerType(
        id: json['id'],
        name: json['name'],
        description: json['description']
    );
  }
}