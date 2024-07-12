import 'package:test_week2/models/register_data/communce_model.dart';

class District {
  final int id;
  final int adrProvinceId;
  final String code;
  final String nameEn;
  final String nameKh;
  final String type;
  final List<Commune> commune;

  District({
    required this.id,
    required this.adrProvinceId,
    required this.code,
    required this.nameEn,
    required this.nameKh,
    required this.type,
    required this.commune,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'],
      adrProvinceId: json['adr_province_id'],
      code: json['code'],
      nameEn: json['name_en'],
      nameKh: json['name_kh'],
      type: json['type'],
      commune: (json['commune'] as List)
          .map((e) => Commune.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adr_province_id': adrProvinceId,
      'code': code,
      'name_en': nameEn,
      'name_kh': nameKh,
      'type': type,
      'commune': commune.map((e) => e.toJson()).toList(),
    };
  }
}
