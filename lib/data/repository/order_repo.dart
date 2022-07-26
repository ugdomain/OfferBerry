import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hundredminute_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:hundredminute_seller/data/datasource/remote/exception/api_error_handler.dart';
import 'package:hundredminute_seller/data/model/response/base/api_response.dart';
import 'package:hundredminute_seller/utill/app_constants.dart';

class OrderListRepo {
  final DioClient dioClient;
  OrderListRepo({@required this.dioClient});

  Future<ApiResponse> getOrderList() async {
    try {
      final response = await dioClient.get(AppConstants.ORDER_LIST_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDetails(String orderID) async {
    try {
      final response =
          await dioClient.get(AppConstants.ORDER_DETAILS + orderID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> orderStatus(int orderID, String status) async {
    try {
      Response response = await dioClient.post(
        '${AppConstants.UPDATE_ORDER_STATUS}$orderID',
        data: {'_method': 'put', 'delivery_status': status},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderStatusList() async {
    try {
      List<String> addressTypeList = [
        'Select Order Status',
        'pending',
        'processing',
        'delivered',
        'return',
        'failed',
      ];
      Response response = Response(
          requestOptions: RequestOptions(path: ''),
          data: addressTypeList,
          statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
