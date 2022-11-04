import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import '../controllers/category_controller.dart';
import '../controllers/static_fields_controller.dart';
import '../controllers/sub_category_controller.dart';
import '../services/configuration.dart';
import '../view/get_image_widget/get_image_controller.dart';

class ExcelDynamicItems{
  String? name;
  String? jsonName;
  List<String>? list;
  ExcelDynamicItems({this.name,this.jsonName,this.list});

}

CategoryController _categoryController = Get.find();

SubCategoryController _subCategoryController = Get.find();

StaticFieldsController _fieldsController = Get.find();

ChooseImageController _imageCon = Get.find();

class ExcelController extends GetxController{

  final Map<String, dynamic> map = {};

  final mapOfItems = {}.obs;

  final jsonList = [];

  addDataToJsonList(Map<String, dynamic> map){
      jsonList.addAll({map});
  }

  addItemsTomapOfItems(Map<String,dynamic> map){
    if(mapOfItems.containsKey(map.keys)) {
      mapOfItems[map.keys] = map.values;
    }else{
      mapOfItems.addAll(map);
    }
  }

  Future<void> createExcel()async{
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    int col = 1;
    map.forEach((k, v) {
      sheet.getRangeByIndex(1, col).setText(k.replaceAll("\"", ""));
      sheet.getRangeByIndex(1, col).columnWidth = 20;
      sheet.getRangeByIndex(1, col).rowHeight = 25;
      sheet.getRangeByIndex(1, col).cellStyle.fontSize = 15;
      sheet.getRangeByIndex(1, col).cellStyle.bold = true;
      if(mapOfItems.containsKey(k) || mapOfItems.containsKey(k.replaceAll("\"", ""))){
        DataValidation cell = sheet.getRangeByIndex(2, col,1000,col).dataValidation;
        cell.allowType = ExcelDataValidationType.user;
        v is List<String>?cell.listOfValues = v:
        cell.listOfValues = ['${v.replaceAll("\"","")}'];
      }

      col++;
    });


    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationDocumentsDirectory()).path;
    final String fileName = "$path/Products.xlsx";
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }



  Future<List<Map<String, dynamic>>> loadExcelData()async {
    List<Map<String, dynamic>> excelData = [];
    List<Map<String, dynamic>> excelJsonData = [];
    List<String> jsonKeys = [];
    List<String> keys = [];
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['xlsx']
    );
    Uint8List? bytes = File(result!.paths.first!).readAsBytesSync();
    Excel? excel = Excel.decodeBytes(bytes);
    try {
      for (var table in excel.tables.keys) {
        print(table); //sheet Name
        print(excel.tables[table]!.maxCols);
        print(excel.tables[table]!.maxRows);
        for (var row in excel.tables[table]!.rows) {
          List list = [];
          for (var items in row){
            list.add(items!.value);
          }
          var k = 0;
          var catAndSub = {Variables.categoryName[0]:_categoryController.categoryValue.value,Variables.subCategoryName[0]:_subCategoryController.subCategoryValue.value};
          var catIdAndSubId = {Variables.categoryName[1]:_categoryController.categoryId.value,Variables.subCategoryName[1]:_subCategoryController.subCategoryId.value};
          Map<String,dynamic> m = {...catAndSub};
          Map<String,dynamic> jm = {...catIdAndSubId};
          for(var i in list){
            if(list.contains(Variables.name[0])){
              keys.add(i);
              if(i == Variables.name[0]) {
                jsonKeys.add(Variables.name[1]);
              }else
              if(i == Variables.unitPrice[0]) {
                jsonKeys.add(Variables.unitPrice[1]);
              }else
              if(i == Variables.description[0]) {
                jsonKeys.add(Variables.description[1]);
              }else{jsonKeys.add(i);}
            }else{
              if(keys[k] == Variables.images[0]){
                _imageCon.addImagesToListOfImages();
                _imageCon.addImagesToListOfJsonImages();
                i = _imageCon.listOfImages;
                jm.addAll({Variables.images[1]:[]});
              }
              jm.addAll({jsonKeys[k]:i});
              m.addAll({keys[k]:i});
              k++;
            }
          }
          if(m.isNotEmpty && m.length > 2) {
            _imageCon.addImagesToListOfImages();
            _imageCon.addImagesToListOfJsonImages();
            m.addAll({"Images":_imageCon.listOfImages});
            jm.addAll({Variables.images[1]:[]});
            excelJsonData.add(jm);
            excelData.add(m);
          }
        }
      }
      Directory(result!.paths!.first.toString()).delete(recursive: true);
    } on Exception catch (e) {
      print("Error = ${e.toString()}");
    }
    excelJsonData.forEach((element) { addDataToJsonList(element);});
    return excelData;
  }



  Future<void> uploadExcel()async{
    var mapOfExcelData = loadExcelData();
    var newMap = {Variables.categoryName[0]:_categoryController.categoryValue.value,Variables.subCategoryName[0]:_subCategoryController.subCategoryValue.value,...map,"Images":[]};
    bool isListValid = true;
    mapOfExcelData.then((value) {
      var count = 1;
      for(var item in value){
        item.forEach((k, v) {
          if(newMap.containsKey(k.trim()) && item.length == newMap.length){
            print("$count = $k : $v");
            count++;
          }else{
            isListValid = false;
          }
        });
        if(isListValid) {
          _categoryController.uiList.add(Map.from(item));
        }
      }
      if(isListValid) {
        _fieldsController.jsonList.add(jsonList);
        Get.snackbar("Success", "Data Uploaded Successfully!",snackPosition: SnackPosition.BOTTOM);
      }else{
        Get.snackbar("Success","Data Upload Failed!",snackPosition: SnackPosition.BOTTOM);
      }
    });
  }
}