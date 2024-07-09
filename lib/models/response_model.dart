import 'data_model.dart';

class ResponseModel {
  final int code;
  final String message;
  final DataModel dataModel;

  ResponseModel({
    required this.code,
    required this.message,
    required this.dataModel,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      code: json['code'],
      message: json['message'],
      dataModel: DataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': dataModel.toJson(),
    };
  }
}
