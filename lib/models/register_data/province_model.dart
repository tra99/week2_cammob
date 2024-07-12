import 'district_model.dart';

class Province {
  final int id;
  final String code;
  final String nameEn;
  final String nameKh;
  final String type;
  final List<District> district;

  Province({
    required this.id,
    required this.code,
    required this.nameEn,
    required this.nameKh,
    required this.type,
    required this.district,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      code: json['code'],
      nameEn: json['name_en'],
      nameKh: json['name_kh'],
      type: json['type'],
      district: (json['district'] as List)
          .map((e) => District.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name_en': nameEn,
      'name_kh': nameKh,
      'type': type,
      'district': district.map((e) => e.toJson()).toList(),
    };
  }
}
