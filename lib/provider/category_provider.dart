import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

class CategoryProvider extends ChangeNotifier {
  String name1;
  apirequest() async {
    var url = Uri.parse(
        'https://bionicspharma.com/offer-barry/api/v2/seller/products/get-category-attrs?cat_id=12&parent_id=13');
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
