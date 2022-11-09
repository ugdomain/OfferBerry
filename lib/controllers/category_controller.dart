import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hundredminute_seller/controllers/sub_category_controller.dart';

import '../models/category_model.dart';
import '../services/api_services.dart';


class CategoryController extends GetxController{
   final categoryList = <getRawCatgory>[].obs;
   final categoryValue = "Select Category".obs;
   final isLoading = true.obs;
   final categoryId = "".obs;
   final SubCategoryController _subCategoryController = Get.put(SubCategoryController());
   final submit = {}.obs;
   var isValidated = false.obs;
   final list = <Map<dynamic,dynamic>>[].obs;
   final uiList = [].obs;

   @override
  void onInit() {
    super.onInit();
    fetchCategory();
  }

   void saveData(Map<String, dynamic> value) {
     submit(value);
   }

   saveDataToUiList(RxMap<dynamic, dynamic> value){
     uiList.addAll({Map.from(value)});
     submit.clear();
     debugPrint(uiList.toString());
   }

   editDataInUiList(int index,RxMap<dynamic, dynamic> value){
     uiList[index] = Map.from(value);
     submit.clear();
     print("uiList after submit clear $uiList");
   }

   bool validate(value){
     return isValidated.value = value;
   }

  setSelectedCategory(String? id){
     categoryId(id!);
     _subCategoryController.fetchSubCategory(id);
  }
  void setSelected(String? value){
     categoryValue(value!);
  }

  void fetchCategory()async{
     isLoading(true);
     try{
    var category = await ProductServices().getRawCategory();
    if(category != null){
      categoryList(category);
    }}finally{
       isLoading(false);
     }
  }

   List KeysOfMap(){
     List Keys = [];
     var description;
     uiList.forEach((element) {
       element.forEach((k,v){
           if(k == "Description"){
             description = k;
             Keys.remove(k);
           }else if(k == 'Images'){
             Keys.remove(k);
           }else if(Keys.contains(k)){

           }else{
             Keys.add(k);
           }
       });
     });
     Keys.add(description);
     debugPrint(Keys.toString());
     return Keys;
   }
}

