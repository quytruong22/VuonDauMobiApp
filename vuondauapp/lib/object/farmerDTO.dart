class FarmerDTO{
  final String id;
  final String email;
  final String first_name;
  final String last_name;
  final String phone;
  final DateTime birth_day;
  final bool gender;
  final DateTime date_of_create;

  FarmerDTO({required this.id, required this.email, required this.first_name, required this.last_name, required this.phone,
      required this.birth_day, required this.gender, required this.date_of_create});
}