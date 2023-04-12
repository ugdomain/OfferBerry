import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';
import '../controllers/sub_category_attr_controller.dart';
import '../controllers/sub_category_controller.dart';
import 'excel_page_controller.dart';

class CreateExcelPage extends StatelessWidget {
  CreateExcelPage({super.key});

  final CategoryController _categoryController = Get.put(CategoryController());
  final SubCategoryController _subCategoryController =
      Get.put(SubCategoryController());
  final SubCategoryAttrController _attrController =
      Get.put(SubCategoryAttrController());
  final ExcelController _excelController = Get.put(ExcelController());
  String? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Excel Page"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return _categoryController.isLoading.value
                      ? const CircularProgressIndicator()
                      : Container(
                          width: MediaQuery.of(context).size.width.toDouble(),
                          // height: 100,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              hint: Text(
                                  _categoryController.categoryValue.toString()),
                              items: _categoryController.categoryList
                                  .map((element) => DropdownMenuItem(
                                        value: element.name,
                                        child: Text(element.name.toString()),
                                        onTap: () {
                                          _categoryController
                                              .setSelected(element.name);
                                          _categoryController
                                              .setSelectedCategory(
                                                  element.id.toString());
                                        },
                                      ))
                                  .toList(),
                              onChanged: (Object? value) {
                                _categoryController
                                    .setSelected(value!.toString());
                              },
                            ),
                          ));
                }),
                SizedBox(
                  height: 20,
                ),

                Obx(() {
                  if (_categoryController.isLoading.value &&
                      !_subCategoryController.isLoading.value) {
                    return Container();
                  } else if (_subCategoryController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            hint: Text(
                                _subCategoryController.subCategoryValue.value),
                            items: _subCategoryController.subCategoryList
                                .map((element) => DropdownMenuItem(
                                      value: element.name.toString(),
                                      child: Text(element.name.toString()),
                                      onTap: () {
                                        _subCategoryController.setSubCategoryId(
                                            element.id.toString(),
                                            _categoryController.categoryId
                                                .toString());
                                        _subCategoryController.setSelectedValue(
                                            element.name.toString());
                                      },
                                    ))
                                .toList(),
                            onChanged: (Object? value) {
                              _subCategoryController
                                  .setSelectedValue(value!.toString());
                              _categoryController.submit.clear();
                              _attrController.controllValues.clear();
                            },
                          ),
                        ));
                  }
                }),
                SizedBox(
                  height: 25,
                ),
// ==== Attribute Data
//                 Obx((){
//                   return _attrController.isLoading.value?
//                   Center(child: CircularProgressIndicator()):
//                   Form(
//                     key: _attrController.key,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: _attrController.itemCount != null?_attrController.itemCount:0,
//                       itemBuilder: (_,index){
//                         _attrController.setControllNameValue(
//                             _attrController.attrList.first.attrs![index].controlName
//                         );
//                         return
//                           _attrController.attrList[0].attrs![index].control == "select"?
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
//                             child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   validator: (value){
//                                     if(value == null || value.isEmpty || value == "" || value == "select item") {
//                                       _attrController.validate(false);
//                                       return "Please select item!";
//                                     }else{
//                                       _attrController.validate(true);
//                                       return null;}
//                                   },
//                                   value: _attrController.controllValues[_attrController.attrList.first.attrs![index].controlName] ?? "",
//                                   isExpanded: true,
//                                   borderRadius: BorderRadius.circular(30),
//                                   hint: Text(_attrController.controllName.value),
//                                   items:[
//                                     DropdownMenuItem(
//                                       value:"",
//                                       enabled: false,
//                                       child: Text(
//                                           _attrController.attrList[0].attrs![index].controlValidation.toUpperCase() == "REQUIRED"?
//                                           "select item *":"select item"),),
//                                     ..._attrController.attrList.first.attrs![index].controlOptions!.map((element) =>
//                                         DropdownMenuItem(
//                                           value: element,
//                                           child: Text(element,
//                                           ),onTap: (){
//                                           _attrController.setSelectValue(
//                                               {_attrController.ToString(_attrController.attrList.first.attrs![index].controlName):
//                                               _attrController.ToString(element)});
//                                         },),
//                                     ).toList()
//                                   ],
//                                   onChanged: (String? value) {
//                                     _attrController.setControllNameValue(value!.toString());
//                                   },)),
//                           ):
//                           _attrController.attrList[0].attrs![index].control == "input"?
//                           Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 45.0,),
//                                     child: Text(_attrController.attrList[0].attrs![index].controlName),
//                                   ),
//                                   _attrController.attrList[0].attrs![index].controlValidation.toUpperCase() == "REQUIRED"?
//                                   Text(" *"):Container(),
//                                 ],
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                                 margin: const EdgeInsets.only(bottom: 20,left: 10,right: 10,top: 5),
//                                 child: TextFormField(
//                                   decoration: InputDecoration(
//                                       hintText: "Please enter ${_attrController.attrList[0].attrs![index].controlName}",
//                                       hintStyle: const TextStyle(color: Colors.black26)),
//                                   validator : (value){
//                                     if(_attrController.attrList[0].attrs![index].controlValidation.toUpperCase() == "REQUIRED"){
//                                       if(value == null || value.isEmpty || value == "") {
//                                         _attrController.validate(false);
//                                         return "Please fill the required field!";
//                                       }else{
//                                         _attrController.validate(true);
//                                         return null;}
//                                     }},
//                                   onSaved: (value){
//                                     saveData(index, value);
//                                     bool isValidated = _attrController.key.currentState!.validate();
//                                     _categoryController.isValidated(isValidated);
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ):const CircularProgressIndicator();
//                       },
//                     ),
//                   );}
//                 ),
//                 _attrController.isLoading.value?
//                 Container():
//==== Button
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextButton(
                    onPressed: () {
                      _excelController.createExcel();
                    },
                    child: const Text(
                      'Create Excel Sheet',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Save Excel Sheet',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveData(int index, String? value) {
    _attrController.setInputValue(
        _attrController.attrList.first.attrs![index].controlName, value);
    bool isValid = _attrController.key.currentState!.validate();
    if (isValid && _attrController.validate.value) {
      _categoryController.submit({
        _attrController.ToString("Category"):
            _attrController.ToString(_categoryController.categoryValue.value),
        _attrController.ToString("SubCategory"): _attrController.ToString(
            _subCategoryController.subCategoryValue.value),
        _attrController.ToString("attrs"): [
          _attrController.editTextCon.toString(),
          _attrController.controllValues.toString()
        ]
      });
      // print(submit.toString());
    }
  }
}
