import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utill/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';

class SplashRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  SplashRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getConfig() async {
    try {
      final response = await dioClient!.get(AppConstants.CONFIG_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  void initSharedData() async {
    if (!sharedPreferences!.containsKey(AppConstants.CART_LIST)) {
      sharedPreferences!.setStringList(AppConstants.CART_LIST, []);
    }
    if (!sharedPreferences!.containsKey(AppConstants.SEARCH_ADDRESS)) {
      sharedPreferences!.setStringList(AppConstants.SEARCH_ADDRESS, []);
    }
    if(!sharedPreferences!.containsKey(AppConstants.CURRENCY)) {
      sharedPreferences!.setString(AppConstants.CURRENCY, '');
    }
  }

  String getCurrency() {
    return sharedPreferences!.getString(AppConstants.CURRENCY) ?? '';
  }

  void setCurrency(String currencyCode) {
    sharedPreferences!.setString(AppConstants.CURRENCY, currencyCode);
  }

}
