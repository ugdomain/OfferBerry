
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/model/body/seller_body.dart';
import '../data/model/response/base/api_response.dart';
import '../data/model/response/response_model.dart';
import '../data/model/response/seller_info.dart';
import '../data/repository/bank_info_repo.dart';
import '../helper/api_checker.dart';

class BankInfoProvider extends ChangeNotifier {
  final BankInfoRepo? bankInfoRepo;

  BankInfoProvider({@required this.bankInfoRepo});

  SellerModel? _bankInfo;
  List<double>? _userEarnings;
  SellerModel get bankInfo => _bankInfo!;
  List<double> get userEarnings => _userEarnings!;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getBankInfo(BuildContext context) async {
    ApiResponse apiResponse = await bankInfoRepo!.getBankList();
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _bankInfo = SellerModel.fromJson(apiResponse.response!.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }

  Future<void> getUserEarnings(BuildContext context) async {
    ApiResponse apiResponse = await bankInfoRepo!.getUserEarnings();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      List<String> _earnings = apiResponse.response!.data.split(',');
      _earnings.removeAt(_earnings.length-1);
      _userEarnings = [];
      for(String earn in _earnings) {
        _userEarnings!.add(double.parse(earn));
      }
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }


  Future<ResponseModel> updateUserInfo(SellerModel updateUserModel, SellerBody seller, String token) async {
    _isLoading = true;
    notifyListeners();

    ResponseModel responseModel;
    http.StreamedResponse response = await bankInfoRepo!.updateBank(updateUserModel, seller, token);
    _isLoading = false;
    if (response.statusCode == 200) {
      String message = 'Success';
      _bankInfo = updateUserModel;
      responseModel = ResponseModel(true, message);
      print(message);
    } else {
      print('${response.statusCode} ${response.reasonPhrase}');
      responseModel = ResponseModel(false, '${response.statusCode} ${response.reasonPhrase}');
    }
    notifyListeners();
    return responseModel;
  }

  String getBankToken() {
    return bankInfoRepo!.getBankToken();
  }

}
