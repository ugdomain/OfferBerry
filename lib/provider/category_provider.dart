import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

class CategoryProvider extends ChangeNotifier {
  apirequest(String cat_id, String parent_id) async {
    var url = Uri.parse(
        'https://bionicspharma.com/offer-barry/api/v2/seller/products/get-category-attrs?cat_id=$cat_id&parent_id=$parent_id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final responsebody = json.decode(response.body);
      return responsebody;
    } else {
      print(response.reasonPhrase);
    }
    notifyListeners();
  }
}
