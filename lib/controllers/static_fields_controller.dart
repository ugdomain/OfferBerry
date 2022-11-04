
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundredminute_seller/services/configuration.dart';

class StaticFieldsController extends GetxController{

  Map<String, dynamic> staticFieldMap = {};

  final jsonMap = {}.obs;

  final jsonList = [].obs;

  var isDataLoaded = false.obs;

  List<Map<String, dynamic>> uploadJsonFinalList = <Map<String, dynamic>>[];

  final list = [].obs;

  RxString? token = "".obs;

  addDataToJsonMap(Map value){
    jsonMap.addAll(value);
  }

  addDataToJsonList(Map value){
    jsonList.add(Map.from(value));
    debugPrint(jsonList.toString());
  }

  addDataToList(Map value){
    list.add(Map.from(value));
    jsonMap.clear();
    setDataToJsonFormat();
  }

  setDataToMap(Map<String, dynamic> map){
    if(staticFieldMap.containsKey(map.keys)){
    staticFieldMap["map.keys"] = map.keys;
    }else{
      staticFieldMap.addAll(Map.from(map));
    }
  }

  ToString(dynamic value){
    if(value is int || value is List){
      if(value is int)debugPrint("$value");
      return value;
    }else{
    return "\"$value\"";}
  }

  setDataToJsonFormat(){
    // TODO: correct the post data
    List<Map<String,dynamic>> list1 = [];
    Map<String, dynamic> map = {};
    var attr = {};
    var l = [Variables.name[1],Variables.unitPrice[1],Variables.description[1],Variables.categoryId,Variables.subCategoryId,
      Variables.images[1]
    ];
    var index = 0;
    for (Map value in list) {
      map.addAll({ToString("shop"):1});
      for(var v in value.keys){
        if(l.contains(v)){
          if(v == "images"){
            map.addAll({ToString(v):ToString(value[v][index])});
          }else{
          map.addAll({ToString(v):ToString(value[v])});}
          if(map.containsKey(ToString("attrs"))){
            map[ToString("attrs")] = attr;
          }else{
            map.addAll({ToString("attrs"):attr});
          }
        }else{
          attr.addAll({ToString(v):ToString(value[v])});}
      }
      index++;
      list1.add(Map.from(map));
    }
    for(var item in list1) {
      debugPrint("list1 =>>>" + item.toString());
    }
    uploadJsonFinalList = list1;
  }
}