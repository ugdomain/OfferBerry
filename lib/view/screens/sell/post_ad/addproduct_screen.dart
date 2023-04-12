import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:hundredminute_seller/services/configuration.dart';
import 'package:hundredminute_seller/view/screens/sell/post_ad/edit_product/edit_product_controller.dart';
import 'package:hundredminute_seller/view/screens/sell/post_ad/widget/add_image_to_listview.dart';
import 'package:hundredminute_seller/view/screens/sell/post_ad/widget/custom_radio_button.dart';
import 'package:hundredminute_seller/view/screens/sell/post_ad/widget/post_product.dart';
import 'package:hundredminute_seller/view/screens/sell/post_ad/widget/widgets.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/category_controller.dart';
import '../../../../controllers/static_fields_controller.dart';
import '../../../../controllers/sub_category_attr_controller.dart';
import '../../../../controllers/sub_category_controller.dart';
import '../../../../excel_file/excel_page_controller.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/styles.dart';
import '../../../get_image_widget/get_image_controller.dart';
import '../../../get_image_widget/get_images.dart';
import '../../../get_image_widget/listview_selection_drawer.dart';
import '../../../get_image_widget/show_list_of_images.dart';
import 'edit_product/edit_product_view.dart';

class AddProduct extends StatelessWidget {
  AddProduct({Key? key, required this.isWholeSale}) : super(key: key);

  final bool isWholeSale;

  final CategoryController _categoryController = Get.find();

  final SubCategoryController _subCategoryController = Get.find();

  final SubCategoryAttrController _attrController = Get.find();

  final ExcelController _excelController = Get.find();

  final StaticFieldsController _fieldsController = Get.find();

  ChooseImageController imageCon = Get.find();

  EditProductController _editProduct = Get.put(EditProductController());

  AddImageToListViewController _updateListViewImageController =
      Get.put(AddImageToListViewController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(isWholeSale);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Form(
                  key: _attrController.key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "General info",
                            style: robotoRegularMainHeadingAddProduct,
                          ),
                          Divider(
                            thickness: 1,
                          ),
//=========================================== Category ==============================================>
                          Text(
                            Variables.categoryName[0],
                            style: titilliumRegular,
                          ),
                          Obx(
                            () => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.PADDING_SIZE_SMALL),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[200] as Color,
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 5))
                                ],
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                  hint: Text(_categoryController.categoryValue
                                      .toString()),
                                  items: _categoryController.categoryList
                                      .map((element) => DropdownMenuItem(
                                            value: element.name,
                                            child:
                                                Text(element.name.toString()),
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
                                    _subCategoryController.subCategoryList
                                        .clear();
                                    _attrController.attrList.clear();
                                    _categoryController
                                        .setSelected(value!.toString());
                                    _subCategoryController
                                        .subCategoryValue("null");
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
//=========================================== Sub Category ==============================================>
                          Text(
                            Variables.subCategoryName[0],
                            style: titilliumRegular,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.PADDING_SIZE_SMALL),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200] as Color,
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 5))
                              ],
                            ),
                            child: DropdownButtonHideUnderline(
                                child: Obx(() => _subCategoryController
                                            .isLoading.value ==
                                        false
                                    ? _subCategoryController
                                            .subCategoryList.isNotEmpty
                                        ? DropdownButtonFormField(
                                            key: ValueKey("subCategoryKey"),
                                            value: _subCategoryController
                                                .subCategoryValue.value,
                                            hint: Text(_subCategoryController
                                                .subCategoryValue.value),
                                            items: [
                                              DropdownMenuItem(
                                                value: "null",
                                                child: Text("Select Item"),
                                                enabled: false,
                                              ),
                                              ..._subCategoryController
                                                  .subCategoryList
                                                  .map((element) =>
                                                      DropdownMenuItem(
                                                        value: element.name
                                                            .toString(),
                                                        child: Text(element.name
                                                            .toString()),
                                                        onTap: () {
                                                          _attrController
                                                              .attrList
                                                              .clear();
                                                          _subCategoryController
                                                              .setSubCategoryId(
                                                                  element.id
                                                                      .toString(),
                                                                  _categoryController
                                                                      .categoryId
                                                                      .toString());
                                                          _subCategoryController
                                                              .setSelectedValue(
                                                                  element.name
                                                                      .toString());
                                                        },
                                                      ))
                                                  .toList()
                                            ],
                                            onChanged: (Object? value) {
                                              _subCategoryController
                                                  .setSelectedValue(
                                                      value!.toString());
                                            },
                                          )
                                        : DropdownButtonFormField(
                                            key: ValueKey("subCategoryKey"),
                                            value: Variables.subCategoryName[0],
                                            hint: Text(
                                                Variables.subCategoryName[0]),
                                            items: [
                                              DropdownMenuItem(
                                                value: Variables
                                                    .subCategoryName[0],
                                                child: Text("Select Item"),
                                                enabled: false,
                                              ),
                                            ],
                                            onChanged: (Object? value) {},
                                          )
                                    : Center(
                                        child: CircularProgressIndicator()))),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // isWholeSale
                      //     ?
                      // Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         "Wholesale details",
                      //         style: robotoRegularMainHeadingAddProduct,
                      //       ),
                      //       Divider(
                      //         thickness: 1,
                      //       ),
                      //       SizedBox(
                      //         height: 5,
                      //       ),
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   "Wholesale Quantity",
                      //                   style: titilliumRegular,
                      //                 ),
                      //                 HomePageFields()
                      //                     .buildStaticInputFields(
                      //                         Theme.of(context)
                      //                             .colorScheme
                      //                             .secondary,
                      //                         "${Variables.quantity[0]}",
                      //                         "${Variables.quantity[1]}",
                      //                         TextInputType.text,
                      //                         1,
                      //                         ValueKey("ProductQuantity"),
                      //                         ''),
                      //               ],
                      //             ),
                      //           ),
                      //           const SizedBox(width: 10),
                      //           Expanded(
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   "Batch ID",
                      //                   style: titilliumRegular,
                      //                 ),
                      //                 HomePageFields()
                      //                     .buildStaticInputFields(
                      //                         Theme.of(context)
                      //                             .colorScheme
                      //                             .secondary,
                      //                         "${Variables.batchId[0]}",
                      //                         "${Variables.batchId[1]}",
                      //                         TextInputType.text,
                      //                         1,
                      //                         ValueKey("ProductBatchId"),
                      //                         ''),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       const SizedBox(
                      //         height: 15,
                      //       ),
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   "Defect",
                      //                   style: titilliumRegular,
                      //                 ),
                      //                 HomePageFields()
                      //                     .buildStaticInputFields(
                      //                         Theme.of(context)
                      //                             .colorScheme
                      //                             .secondary,
                      //                         "${Variables.defect[0]}",
                      //                         "${Variables.defect[1]}",
                      //                         TextInputType.text,
                      //                         1,
                      //                         ValueKey("ProductDefect"),
                      //                         ''),
                      //               ],
                      //             ),
                      //           ),
                      //           const SizedBox(width: 10),
                      //           Expanded(
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   "Palate ID",
                      //                   style: titilliumRegular,
                      //                 ),
                      //                 HomePageFields()
                      //                     .buildStaticInputFields(
                      //                         Theme.of(context)
                      //                             .colorScheme
                      //                             .secondary,
                      //                         "${Variables.palateId[0]}",
                      //                         "${Variables.palateId[1]}",
                      //                         TextInputType.text,
                      //                         1,
                      //                         ValueKey("ProductPalateId"),
                      //                         ''),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   )

                      // : SizedBox(),

                      Text(
                        "Product Name",
                        style: titilliumRegular,
                      ),
                      HomePageFields().buildStaticInputFields(
                          Theme.of(context).colorScheme.secondary,
                          "${Variables.name[0]}",
                          "${Variables.name[1]}",
                          TextInputType.text,
                          1,
                          ValueKey("ProductName"),
                          ''),
                      Text(
                        "${Variables.unitPrice[0]}",
                        style: titilliumRegular,
                      ),
                      HomePageFields().buildStaticInputFields(
                          Theme.of(context).colorScheme.secondary,
                          "${Variables.unitPrice[0]}",
                          "${Variables.unitPrice[1]}",
                          TextInputType.number,
                          1,
                          ValueKey("unitPrice"),
                          ""),
                      SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () {
                          return _attrController.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _attrController.itemCount,
                                  itemBuilder: (context, index) {
                                    _attrController.setControllNameValue(
                                        _attrController.attrList.first
                                            .attrs![index].controlName);
                                    return _attrController.attrList[0]
                                                .attrs![index].control ==
                                            "select"
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _attrController.attrList[0]
                                                    .attrs![index].controlName,
                                                style: titilliumRegular,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: Dimensions
                                                          .PADDING_SIZE_SMALL),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .cardColor,
                                                    borderRadius: BorderRadius
                                                        .circular(Dimensions
                                                            .PADDING_SIZE_SMALL),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              Colors.grey[200]
                                                                  as Color,
                                                          spreadRadius: 2,
                                                          blurRadius: 5,
                                                          offset: Offset(0, 5))
                                                    ],
                                                  ),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12.0),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child:
                                                            DropdownButtonFormField(
                                                          key: ValueKey(
                                                              "${_attrController.controllName.value}"),
                                                          isExpanded: true,
                                                          hint: Text(
                                                              _attrController
                                                                  .controllName
                                                                  .value),
                                                          items: [
                                                            DropdownMenuItem(
                                                              value: "",
                                                              enabled: false,
                                                              child: Row(
                                                                children: [
                                                                  Text(_attrController
                                                                      .attrList[
                                                                          0]
                                                                      .attrs![
                                                                          index]
                                                                      .controlName),
                                                                  SizedBox(
                                                                    width: 3,
                                                                  ),
                                                                  Text(
                                                                    _attrController.attrList[0].attrs![index].controlValidation.toUpperCase() ==
                                                                            "REQUIRED"
                                                                        ? "*"
                                                                        : "",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            ..._attrController
                                                                .attrList
                                                                .first
                                                                .attrs![index]
                                                                .controlOptions!
                                                                .map(
                                                                  (element) =>
                                                                      DropdownMenuItem(
                                                                    value:
                                                                        element,
                                                                    child: Text(
                                                                      element,
                                                                    ),
                                                                    onTap: () {
                                                                      _attrController
                                                                          .setSelectValue({
                                                                        _attrController.ToString(_attrController
                                                                            .attrList
                                                                            .first
                                                                            .attrs![index]
                                                                            .controlName): _attrController.ToString(element)
                                                                      });

                                                                      _excelController
                                                                          .mapOfItems
                                                                          .addAll({
                                                                        _attrController.ToString(
                                                                            _attrController
                                                                                .attrList.first.attrs![index].controlName): _attrController
                                                                            .attrList
                                                                            .first
                                                                            .attrs!
                                                                            .toList()
                                                                      });
                                                                    },
                                                                  ),
                                                                )
                                                                .toList()
                                                          ],
                                                          validator: (value) {
                                                            if (value == null ||
                                                                value
                                                                    .toString()
                                                                    .isEmpty ||
                                                                value == "" ||
                                                                value ==
                                                                    _attrController
                                                                        .attrList
                                                                        .first
                                                                        .attrs![
                                                                            index]
                                                                        .controlName) {
                                                              _attrController
                                                                  .validate(
                                                                      false);
                                                              return "Please select item!";
                                                            } else {
                                                              _attrController
                                                                  .validate(
                                                                      true);
                                                              return null;
                                                            }
                                                          },
                                                          value: _attrController
                                                                      .controllValues[
                                                                  _attrController
                                                                      .attrList
                                                                      .first
                                                                      .attrs![
                                                                          index]
                                                                      .controlName] ??
                                                              "",
                                                          onChanged:
                                                              (Object? value) {
                                                            _attrController
                                                                .setControllNameValue(
                                                                    value!
                                                                        .toString());
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        : _attrController.attrList[0]
                                                    .attrs![index].control ==
                                                "input"
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _attrController
                                                        .attrList[0]
                                                        .attrs![index]
                                                        .controlName,
                                                    style: titilliumRegular,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      bottom: 8.0,
                                                    ),
                                                    child: BuildInputFields(
                                                      index,
                                                      key: ValueKey(
                                                        "${_attrController.attrList[0].attrs![index].controlName}",
                                                      ),
                                                      value: '',
                                                    ),
                                                  )
                                                ],
                                              )
                                            : _attrController
                                                        .attrList[0]
                                                        .attrs![index]
                                                        .control ==
                                                    "radio"
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(_attrController
                                                          .attrList[0]
                                                          .attrs![index]
                                                          .controlName
                                                          .capitalize!),
                                                      // SizedBox(height: 3,),
                                                      CustomRadioButton(
                                                        index: index,
                                                        radiokey: ValueKey(
                                                            "${_attrController.attrList[0].attrs![index].controlName}"),
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      )
                                                    ],
                                                  )
                                                : Container();
                                  },
                                );
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${Variables.description[0]}",
                        style: robotoRegularMainHeadingAddProduct,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      HomePageFields().buildDescriptionField(
                          Theme.of(context).colorScheme.secondary,
                          "${Variables.description[0]}",
                          "${Variables.description[1]}",
                          TextInputType.text,
                          5,
                          ValueKey("${Variables.description[1]}"),
                          ""),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Upload Product Images",
                        style: robotoRegularMainHeadingAddProduct,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ChooseImage(),
                      Divider(),

//================================ Buttons =====================================>
                      Column(
                        children: [
                          HomePageFields().buildButton(
                            context,
                            "Add",
                            () {
                              print("Add Button Pressed");
                              _attrController.key.currentState!.validate();
                              _attrController.key.currentState!.save();
                              _attrController.key.currentState!.reset();
                              if (_categoryController.isValidated.value) {
                                print("object");
                                imageCon.addImagesToListOfImages();
                                _fieldsController
                                    .addDataToList(_fieldsController.jsonMap);
                                _categoryController.saveDataToUiList(
                                    _categoryController.submit);
                                Get.snackbar(
                                    "Success", "Data Saved Successfully!");
                              }
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Obx(() => _fieldsController.list.isNotEmpty
                              ? HomePageFields().buildButton(context, "Upload",
                                  () {
                                  try {
                                    ApiServices().apiCallAddProducts(
                                        _fieldsController.uploadJsonFinalList);
                                  } catch (e) {
                                    debugPrint("Error $e");
                                  }
                                })
                              : Container()),
                        ],
                      ),
                      Divider(),

//================================ Items ListView ==============================>
                      Obx(() => _categoryController.uiList.isNotEmpty
                          ? Container(
                              color: Theme.of(context).colorScheme.secondary,
                              height: 450,
                              width: MediaQuery.of(context).size.width * .9,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: _categoryController.uiList.length,
                                separatorBuilder: (context, index) => Divider(
                                  thickness: 1,
                                ),
                                itemBuilder: (c, i) {
// TODO: make List View items editable
                                  return GestureDetector(
                                    onTap: () {
                                      Get.bottomSheet(ListViewSelectionDrawer(
                                        size: MediaQuery.of(context).size,
                                        index: i,
                                      ));
                                      debugPrint(
                                          imageCon.listOfImages.toString());
                                      debugPrint(
                                          imageCon.listOfJsonImages.toString());
                                    },
                                    child: Container(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                          elevation: 8,
                                          color: Colors.grey.shade50,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 3,
                                                    offset: Offset(0,
                                                        1)) // changes position of shadow
                                              ],
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .9,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          var attrs = {};
                                                          _categoryController
                                                              .uiList[i]
                                                              .forEach(
                                                                  (key, value) {
                                                            if (key != Variables.categoryName[0] &&
                                                                key !=
                                                                    Variables
                                                                            .subCategoryName[
                                                                        0] &&
                                                                key !=
                                                                    Variables
                                                                            .images[
                                                                        0] &&
                                                                key !=
                                                                    Variables
                                                                            .name[
                                                                        0] &&
                                                                key !=
                                                                    Variables
                                                                            .unitPrice[
                                                                        0] &&
                                                                key !=
                                                                    Variables
                                                                            .description[
                                                                        0]) {
                                                              attrs.addAll(
                                                                  {key: value});
                                                            }
                                                          });
                                                          _editProduct.changeCategory(
                                                              _categoryController
                                                                  .uiList[i][
                                                                      Variables
                                                                          .categoryName[0]]
                                                                  .toString());
                                                          _editProduct.changesubCategory(
                                                              _categoryController
                                                                  .uiList[i][
                                                                      Variables
                                                                          .subCategoryName[0]]
                                                                  .toString());
                                                          imageCon.images
                                                              .clear();
                                                          imageCon.images.addAll(
                                                              _categoryController
                                                                      .uiList[
                                                                  i][Variables
                                                                      .images[
                                                                  0]][i]);
                                                          Get.to(() =>
                                                              EditProductPage(
                                                                index: i,
                                                                category: _categoryController
                                                                    .uiList[i][
                                                                        Variables
                                                                            .categoryName]
                                                                    .toString(),
                                                                subCategory: _categoryController
                                                                    .uiList[i][
                                                                        Variables
                                                                            .subCategoryName]
                                                                    .toString(),
                                                                productName: _categoryController
                                                                    .uiList[i][
                                                                        Variables
                                                                            .name[0]]
                                                                    .toString(),
                                                                unitPrice: _categoryController
                                                                    .uiList[i][
                                                                        Variables
                                                                            .unitPrice[0]]
                                                                    .toString(),
                                                                description: _categoryController
                                                                    .uiList[i][
                                                                        Variables
                                                                            .description[0]]
                                                                    .toString(),
                                                                attr: attrs,
                                                                images: _categoryController
                                                                        .uiList[i]
                                                                    [Variables
                                                                        .images[0]],
                                                              ));
                                                        },
                                                        icon: Icon(
                                                          Icons.edit,
                                                          color: Colors.grey,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          _categoryController
                                                              .uiList
                                                              .removeAt(i);
                                                          _fieldsController.list
                                                              .removeAt(i);
                                                          imageCon.listOfImages
                                                              .removeAt(i);
                                                          imageCon
                                                              .listOfJsonImages
                                                              .removeAt(i);
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        )),
                                                  ],
                                                ),
                                                ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      minHeight: 40),
                                                  child: MasonryGridView.count(
                                                      itemCount:
                                                          _categoryController
                                                                  .uiList[i]
                                                                  .length -
                                                              1,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      crossAxisCount: 2,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        var Keys =
                                                            _categoryController
                                                                .KeysOfMap();
                                                        return Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                  Keys[index]
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(_categoryController
                                                                    .uiList[i][
                                                                        Keys[
                                                                            index]]
                                                                    .toString()),
                                                                SizedBox(
                                                                  height: 5,
                                                                )
                                                              ],
                                                            ));
                                                      }),
                                                ),
                                                ..._categoryController
                                                    .uiList[i].entries
                                                    .map((e) {
// TODO: Work on changes in ListView
                                                  if (e.key == "Images") {
                                                    return Obx(() =>
                                                        _updateListViewImageController
                                                                .isImageListUpdated
                                                                .value
                                                            ? ShowListOfImages(
                                                                listOfImages:
                                                                    e.value,
                                                                index: i,
                                                              )
                                                            : ShowListOfImages(
                                                                listOfImages:
                                                                    e.value,
                                                                index: i,
                                                              ));
                                                  } else if (e.value is! List &&
                                                          e.value is int ||
                                                      e.value is double) {
                                                    return Container();
                                                  } else {
                                                    return Container();
                                                  }
                                                }).toList(),
                                              ],
                                            ),
                                          )),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => SpeedDial(
          onOpen: () {
            if (_attrController.attrList.isNotEmpty) {
              HomePageFields().saveDataToExcel();
            } else {
              Get.snackbar("Error", "Please select sub category!");
            }
          },
          spaceBetweenChildren: 5,
          spacing: 6,
          children: [
            _attrController.attrList.isNotEmpty
                ? SpeedDialChild(
                    child: const Icon(Icons.download),
                    label: "Download",
                    onTap: () {
                      _excelController.createExcel();
                    })
                : SpeedDialChild(),
            _attrController.attrList.isNotEmpty
                ? SpeedDialChild(
                    child: const Icon(Icons.upload),
                    label: "Upload",
                    onTap: () => _excelController.uploadExcel())
                : SpeedDialChild(),
          ],
          child: const Text("Excel"),
        ),
      ),
    );
  }
}
