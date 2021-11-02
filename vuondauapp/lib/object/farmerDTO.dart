class FarmerDTO{
  final String id;
  final String email;
  final String first_name;
  final String last_name;
  final String phone;
  final DateTime birth_day;
  final bool gender;
  final DateTime date_of_create;
  final int status;

  FarmerDTO({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.phone,
    required this.birth_day,
    required this.gender,
    required this.date_of_create,
    required this.status,
  });

  factory FarmerDTO.fromJson(Map<String, dynamic> json){
    return FarmerDTO(
        id: json['id'],
        first_name: json['first_name'],
        email: json['email'],
        last_name: json['last_name'],
        phone: json['phone'],
        birth_day: json['birth_day'],
        gender: json['gender'],
        date_of_create: json['date_of_create'],
        status:     json['status']
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.first_name;
    data['last_name'] = this.last_name;
    data['phone'] = this.phone;
    data['birth_day'] = this.birth_day;
    data['gender'] = this.gender;
    data['date_of_create'] = this.date_of_create;
    data['status'] = this.status;
    return data;
  }
}