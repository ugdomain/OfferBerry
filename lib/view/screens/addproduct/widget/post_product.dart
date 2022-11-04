import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../controllers/static_fields_controller.dart';

class ApiServices {

  SharedPreferences? sharedPreferences;
  String? token;
  final StaticFieldsController _fieldsController = Get.find();

  Future<LoginApiResponse> apiCallAddProducts(List<Map<String, dynamic>> param) async{
      token = _fieldsController.token!.value;
      debugPrint("Token : $token");
      Get.snackbar("Information", "Uploading data...");
      var url = Uri.parse(
        'https://moneylink.network/offer-barry/api/v2/seller/products/add-new');
    var response = await http.post(url, body: {
      "products" : param.toString()
    },headers: {
      // 'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${token}'
    });
    if(response.statusCode == 200){Get.snackbar("Success", "Data uploaded successfully!");}else{Get.snackbar("Failed", "Data upload failed!");}
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = jsonDecode(response.body);
    return LoginApiResponse(token: data["token"], error: data["error"]);
  }
}

class LoginApiResponse {
  final String? token;
  final String? error;

  LoginApiResponse({this.token, this.error});
}
