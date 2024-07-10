class RegisterModel{
  final String phoneNumber;
  final String fullName;
  final DateTime birthday;
  final String gender;
  final int provinceId;
  final int districtId;
  final int communeId;
  final int villageId;
  final String password;
  final String nidFile; 

  RegisterModel({
    required this.phoneNumber,
    required this.fullName,
    required this.birthday,
    required this.gender,
    required this.provinceId,
    required this.districtId,
    required this.communeId,
    required this.villageId,
    required this.password,
    required this.nidFile,
  });

  Map<String,dynamic>toJson(){
    return {
      'phone_number': phoneNumber,
      'full_name': fullName,
      'birthday': birthday.toIso8601String().split('T').first,
      'gender': gender,
      'province_id': provinceId,
      'district_id': districtId,
      'commune_id': communeId,
      'village_id': villageId,
      'password': password,
      'nid_file': nidFile,
    };
  } 
}