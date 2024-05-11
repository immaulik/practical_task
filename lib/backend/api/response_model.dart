

import 'package:practical_task/backend/api/enums.dart';

class ResponseModel<T> {
  ApiStatus apiStatus;
  dynamic data;

  ResponseModel({this.data, this.apiStatus = ApiStatus.none});

  factory ResponseModel.empty() => ResponseModel(
        apiStatus: ApiStatus.empty,
      );

  factory ResponseModel.loading() => ResponseModel(
        apiStatus: ApiStatus.loading,
      );

  factory ResponseModel.error({String message = "", String data = ""}) =>
      ResponseModel(data: data, apiStatus: ApiStatus.error);

  factory ResponseModel.fromJson(dynamic data) {
    return ResponseModel<T>(data: data, apiStatus: ApiStatus.success);
  }

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
