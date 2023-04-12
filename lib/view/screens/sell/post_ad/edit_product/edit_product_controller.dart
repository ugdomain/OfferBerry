import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundredminute_seller/controllers/category_controller.dart';
import 'package:hundredminute_seller/controllers/sub_category_controller.dart';

class EditProductController extends GetxController{

  var key = GlobalKey<FormState>();

  var validate = false.obs;

  Map<String, dynamic> radioMapInitialValue = {};

  CategoryController _categoryController = Get.find();

  SubCategoryController _subCategoryController = Get.find();

  void changeCategory(String value){
    _categoryController.categoryValue.value = value;
    print(_categoryController.categoryValue.value.toString());
  }

  void changesubCategory(String value){
    _subCategoryController.subCategoryValue.value = value;
  }

}