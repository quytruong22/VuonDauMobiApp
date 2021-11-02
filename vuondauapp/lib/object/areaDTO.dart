class AreaDTO {
  final String ID;
  final String name;
  final String description;

  AreaDTO({required this.ID, required this.name, required this.description});

  factory AreaDTO.fromJson(Map<String, dynamic> json){
    return AreaDTO(
        ID:           json['id'],
        name:         json['name'],
        description:  json['description']
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.ID;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}