import 'package:test_week2/models/home_data/total_service_model.dart';

class ReponseHomeData{
  final TotalServices totalServices;

  ReponseHomeData({
    required this.totalServices
  });

  factory ReponseHomeData.fromJson(Map<String,dynamic> json){
    return ReponseHomeData(totalServices: TotalServices.fromJson(json['total_services']));
  }

  Map<String,dynamic> toJson(){
    return {
      'total_service':totalServices.toJson()
    };
  }
}