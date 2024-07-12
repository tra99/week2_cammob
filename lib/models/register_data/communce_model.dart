import 'village_model.dart';

class Commune {
  final int id;
  final int adrProvinceId;
  final int adrDistrictId;
  final String code;
  final String nameEn;
  final String nameKh;
  final String type;
  final List<Village> villages;

  Commune({
    required this.id,
    required this.adrProvinceId,
    required this.adrDistrictId,
    required this.code,
    required this.nameEn,
    required this.nameKh,
    required this.type,
    required this.villages,
  });

  factory Commune.fromJson(Map<String, dynamic> json) {
    return Commune(
      id: json['id'],
      adrProvinceId: json['adr_province_id'],
      adrDistrictId: json['adr_district_id'],
      code: json['code'],
      nameEn: json['name_en'],
      nameKh: json['name_kh'],
      type: json['type'],
      villages: (json['villages'] as List)
          .map((e) => Village.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adr_province_id': adrProvinceId,
      'adr_district_id': adrDistrictId,
      'code': code,
      'name_en': nameEn,
      'name_kh': nameKh,
      'type': type,
      'villages': villages.map((e) => e.toJson()).toList(),
    };
  }
}
