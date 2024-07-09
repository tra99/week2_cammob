import 'package:test_week2/models/configuration_response_model.dart';

class DataModel {
  final ConfigurationModel configurationModel;

  DataModel({required this.configurationModel});

  factory DataModel.fromJson(Map<String,dynamic>json){
    return DataModel(
      configurationModel: ConfigurationModel.fromJson(json['configuration']));
  }
}
