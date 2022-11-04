import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../utill/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/seller_body.dart';
import '../model/response/base/api_response.dart';
import '../model/response/seller_info.dart';

class BankInfoRepo {

  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  BankInfoRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getBankList() async {
    try {
      final response = await dioClient!.get(AppConstants.SELLER_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getUserEarnings() async {
    try {
      final response = await dioClient!.get(AppConstants.USER_EARNINGS_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> updateBank(SellerModel userInfoModel, SellerBody seller, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.SELLER_AND_BANK_UPDATE}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});

    Map<String, String> _fields = Map();
    _fields.addAll(<String, String>{
      '_method': 'put', 'bank_name': userInfoModel.bankName!, 'branch': userInfoModel.branch!,
      'holder_name': userInfoModel.holderName!, 'account_no': userInfoModel.accountNo!,
      'f_name': seller.fName!, 'l_name': seller.lName!, 'phone': userInfoModel.phone!
    });
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }


  String getBankToken() {
    return sharedPreferences!.getString(AppConstants.TOKEN) ?? "";
  }
}
