import 'package:test_week2/models/register_data/province_model.dart';

class ConfigurationModel {

  final List<Province> provinceList;

  ConfigurationModel({
    required this.provinceList,
  });

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) {
    return ConfigurationModel(
      provinceList: (json['province']as List).map((e)=>Province.fromJson(e)).toList()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'province':provinceList.map((e)=>e.toJson()).toList()
    };
  }
}
