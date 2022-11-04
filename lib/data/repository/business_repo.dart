import 'package:dio/dio.dart';

import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';
import '../model/response/business_model.dart';

class BusinessRepo {
  Future<ApiResponse> getBusinessList() async {
    try {
      List<BusinessModel> businessList = [
        BusinessModel(id: 0, title: 'Superb Discount', duration: '2-5', cost: 200),
        BusinessModel(id: 1, title: 'New Discount', duration: '5-10', cost: 500),
      ];

      final response=Response(data: businessList,statusCode: 200, requestOptions: RequestOptions(path: ""));
      return ApiResponse.withSuccess(response);
    } catch (e){
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
