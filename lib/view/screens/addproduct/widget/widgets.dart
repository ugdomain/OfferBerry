import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../controllers/category_controller.dart';
import '../../../../controllers/static_fields_controller.dart';
import '../../../../controllers/sub_category_attr_controller.dart';
import '../../../../controllers/sub_category_controller.dart';
import '../../../../excel_file/excel_page_controller.dart';
import '../../../../services/configuration.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/styles.dart';
import '../../../base/custom_button.dart';
import '../../../get_image_widget/get_image_controller.dart';



class HomePageFields{

  final CategoryController _categoryController = Get.find();
  final SubCategoryController _subCategoryController = Get.find();
  final SubCategoryAttrController _attrController = Get.find();
  final ExcelController _excelController = Get.find();
  final StaticFieldsController _fieldsController = Get.find();
  ChooseImageController imageCon = Get.find();

  void saveDataToExcel() {
    _excelController.map.clear();
    _excelController.mapOfItems.clear();
    _excelController.map.addAll({Variables.name[0]:"",Variables.unitPrice[0]:"",Variables.description[0]:"",
      ..._attrController.expandAttrList()});
    _excelController.addDataToJsonList({
      ..._attrController.getJsonControlValues()
    });
    _excelController.addItemsTomapOfItems({
      ..._attrController.getControlValues()
    });
  }


  void saveData() {
    bool isValid = _attrController.key.currentState!.validate();
    if (isValid && _attrController.validate.value) {
      _categoryController.saveData({
        Variables.categoryName[0] : _categoryController.categoryValue.value,
        Variables.subCategoryName[0] : _subCategoryController.subCategoryValue.value,
        ..._fieldsController.staticFieldMap,
        ..._attrController.radioButtonMap,
        ..._attrController.editTextCon,
        ..._attrController.controllValues,
        Variables.images[0] : imageCon.listOfImages,
      });
      _fieldsController.addDataToJsonMap({
        Variables.categoryId: _categoryController
            .categoryId.value,
        Variables.subCategoryId: _subCategoryController.subCategoryId
            .value,
        ..._attrController.radioButtonMap,
        ..._attrController.editTextCon,
        ..._attrController.controllValues,
        Variables.images[1]: imageCon.listOfJsonImages
      });
    }
  }

  Widget buildStaticInputFields(Color? color,String name, String jsonName, TextInputType type,int maxLine,ValueKey key) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1)) // changes position of shadow
        ],
      ),
      child: Obx(
    ()=> _categoryController.categoryList.isNotEmpty? TextFormField(
      key: key,
          maxLines: maxLine,
          keyboardType: type,
          decoration: InputDecoration(
              hintText: "Please enter $name",
              hintStyle: const TextStyle(color: Colors.black26)),
          validator: (value) {
            if (value == null || value.isEmpty || value == "") {
              _attrController.validate(false);
              return "Please fill the required field!";
            } else {
              _attrController.validate(true);
              return null;
            }
          },
     onSaved: (value) {
            bool isValidated = _attrController.key.currentState!.validate();
            _categoryController.isValidated(isValidated);
            if (isValidated) {
              _fieldsController.setDataToMap({"$name": "$value"});
              _fieldsController.addDataToJsonMap({jsonName:value});
            }
          },
        ):Container(),
      ),
    );
  }


  Widget buildDescriptionField(Color? color,String name, String jsonName, TextInputType type,int maxLine, ValueKey key) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1)) // changes position of shadow
        ],
      ),
      child: Obx(
    ()=> _categoryController.categoryList.isNotEmpty? TextFormField(
      key: key,
          maxLines: maxLine,
          keyboardType: type,
          decoration: InputDecoration(
              hintText: "Please enter $name",
              hintStyle: const TextStyle(color: Colors.black26)),
          validator: (value) {
            if (value == null || value.isEmpty || value == "") {
              _attrController.validate(false);
              return "Please fill the required field!";
            } else {
              _attrController.validate(true);
              return null;
            }
          },
     onSaved: (value) {
            bool isValidated = _attrController.key.currentState!.validate();
            _categoryController.isValidated(isValidated);
            if (isValidated) {
              _fieldsController.setDataToMap({"$name": "$value"});
              _fieldsController.addDataToJsonMap({jsonName:value});
              saveData();
            }
          },
        ):Container(),
      ),
    );
  }

  CustomButton buildButton(BuildContext context, String name,
      Function()? onPressed) {
    return CustomButton(
      backgroundColor: ColorResources.WHITE,
      onTap: onPressed,
      btnTxt: '$name',
    );}

}

class buildInputFields extends StatelessWidget{
  buildInputFields(this.index,{required this.key});

  final ValueKey key;
  final CategoryController _categoryController = Get.find();
  final SubCategoryAttrController _attrController = Get.find();
  final StaticFieldsController _fieldsController = Get.find();
  ChooseImageController imageCon = Get.find();

  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 1)) // changes position of shadow
          ],
        ),
        child: Obx(
              () => _attrController.attrList.isNotEmpty ?
          TextFormField(
            key: key,
            decoration: InputDecoration(
                hintText: "Please enter ${_attrController.attrList[0]
                    .attrs![index].controlName}",
                hintStyle: const TextStyle(color: Colors.black26)),
            validator: (value) {
              if (_attrController.attrList[0].attrs![index].controlValidation
                  .toUpperCase() == "REQUIRED") {
                if (value == null || value.isEmpty || value == "") {
                  _attrController.validate(false);
                  return "Please fill the required field!";
                } else {
                  _attrController.validate(true);
                  return null;
                }
              }
            },
            onSaved: (value) {
              bool isValidated = _attrController.key.currentState!.validate();
              _categoryController.isValidated(isValidated);
              if(isValidated){
                _attrController.setInputValue(_attrController.attrList.first.attrs![index].controlName,value);
                _fieldsController.addDataToJsonMap({_attrController.attrList.first.attrs![index].controlName:value});
              }
            },
            onChanged: (value){
              var controlName = _attrController.attrList.first.attrs![index].controlName;
              if(_attrController.editTextCon.containsKey(controlName)){
                _attrController.editTextCon[controlName] = value;
              }else{
                _attrController.setInputValue(controlName, value);
              }
            },
          ):Container(),
        ),
      );
  }
}