class Village {
  final int id;
  final int adrProvinceId;
  final int adrDistrictId;
  final int adrCommuneId;
  final String code;
  final String nameEn;
  final String nameKh;
  final String? type;

  Village({
    required this.id,
    required this.adrProvinceId,
    required this.adrDistrictId,
    required this.adrCommuneId,
    required this.code,
    required this.nameEn,
    required this.nameKh,
    this.type,
  });

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      id: json['id'],
      adrProvinceId: json['adr_province_id'],
      adrDistrictId: json['adr_district_id'],
      adrCommuneId: json['adr_commune_id'],
      code: json['code'],
      nameEn: json['name_en'],
      nameKh: json['name_kh'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adr_province_id': adrProvinceId,
      'adr_district_id': adrDistrictId,
      'adr_commune_id': adrCommuneId,
      'code': code,
      'name_en': nameEn,
      'name_kh': nameKh,
      'type': type,
    };
  }
}
