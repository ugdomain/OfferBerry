import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/sub_category_attr_model.dart';
import '../services/api_services.dart';

class SubCategoryAttrController extends GetxController{
  var attrList = <SubCategoryAttr>[].obs;
  int get itemCount => attrList.isNotEmpty ? attrList.first.attrs!.length:0;
  var controllName = "".obs;
  var editTextCon = <String, dynamic>{}.obs;
  var controllValues = <String, dynamic>{}.obs;
  var isLoading = true.obs;
  var validate = false.obs;
  var key = GlobalKey<FormState>();

  // radioButtons properties
  var radioButtonMap = {};

  @override
  void onInit() {
    super.onInit();
    isLoading(false);
    validate(false);
  }

  setControllNameValue(String newValue){
    controllName.value = newValue;
  }

  setRadioButtonValues(Map value){
    radioButtonMap.addAll(value);
  }

  setInputValue(String? value,controller){
    if(editTextCon.keys.contains(controller)){
      editTextCon[controller] = value!;
    }else{
    editTextCon.addAll({value!:controller});
    }
  }

  Map expandAttrList(){
    Map<String,dynamic> map = {};
    Set<Map<String,dynamic>> set = {
      ...attrList[0].attrs!.map((e){
        if(e.control == "select" || e.control == "radio"){
        return {e.controlName : e.controlOptions};
        }else{
          return {e.controlName : ""};
        }
      }
      ).toList()};
    for(var i in set){
      i.forEach((key, value) {
        map.addAll({key: value});
      });
    }
    return map;
  }

  // setting map for mapping excel data

  Map getControlValues(){
    Map map = {};
    Set<Map<String,dynamic>> set = {
      ...attrList[0].attrs!.map((e){
        if(e.control == "select" || e.control == "radio"){
          return {e.controlName : e.controlOptions};
        }else{
          return {e.controlName : ""};
        }
      }
      ).toList()};
    for(var i in set){
      i.forEach((key, value) {
        if(value is List) {
          if(map.containsKey(key)) {
            map[key] = value;
          }else{
            map.addAll({key: value});
          }
        }
      });
    }
    return map;
  }

  // setting json values map for mapping excel data
  Map getJsonControlValues(){
    Map map = {};
    Set<Map<String,dynamic>> set = {
      ...attrList[0].attrs!.map((e){
          return {e.controlName : ""};
      }).toList()};
    for(var i in set){
      i.forEach((key, value) {
        if(value is List) {
          if(map.containsKey(key)) {
            map[key] = value;
          }else{
            map.addAll({key: value});
          }
        }
      });
    }
    return map;
  }


  String ToString(String value){
    return '"$value"';
  }
  setSelectValue(Map<String, dynamic> value){
    controllValues.addAll(value);
  }

  fetchAttrData(String? catId,String? parentId)async{
    isLoading(true);
    try {
      var attr = await ProductServices().subCategoryAttr(catId!, parentId!);

      if (attr != null) {
        attrList.value = attr;
        isLoading(false);
      }
    }finally{
      isLoading(false);
    }
  }
}
