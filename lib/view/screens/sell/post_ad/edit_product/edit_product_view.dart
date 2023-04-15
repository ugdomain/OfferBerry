import 'package:get/get.dart';
import 'package:hundredminute_seller/services/configuration.dart';
import 'package:hundredminute_seller/view/screens/sell/post_ad/widget/custom_radio_button.dart';
import 'package:flutter/material.dart';
import '../../../../../controllers/category_controller.dart';
import '../../../../../controllers/static_fields_controller.dart';
import '../../../../../controllers/sub_category_attr_controller.dart';
import '../../../../../controllers/sub_category_controller.dart';
import '../../../../../excel_file/excel_page_controller.dart';
import '../../../../../utill/dimensions.dart';
import '../../../../../utill/styles.dart';
import '../../../../get_image_widget/get_image_controller.dart';
import '../../../../get_image_widget/get_images.dart';
import 'Widgets.dart';
import 'edit_product_controller.dart';

class EditProductPage extends StatelessWidget {
  EditProductPage(
      {Key? key,
      required this.category,
      required this.subCategory,
      required this.productName,
      required this.unitPrice,
      required this.description,
      required this.attr,
      required this.images,
      required this.index})
      : super(
          key: key,
        );

  final int index;

  final String category;

  final String subCategory;

  final String productName;

  final String unitPrice;

  final String description;

  final Map attr;

  final List images;

  final CategoryController _categoryController = Get.find();

  final SubCategoryController _subCategoryController = Get.find();

  final SubCategoryAttrController _attrController = Get.find();

  final ExcelController _excelController = Get.find();

  final StaticFieldsController _fieldsController = Get.find();

  ChooseImageController imageCon = Get.find();

  EditProductController _controller = Get.put(EditProductController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        imageCon.images.clear();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Form(
                    key: _controller.key,
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
                                                          child: Text(element
                                                              .name
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
                                              value:
                                                  Variables.subCategoryName[0],
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
                        Text(
                          "Product Details",
                          style: robotoRegularMainHeadingAddProduct,
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Product Name",
                          style: titilliumRegular,
                        ),
                        EditPageFields().buildStaticInputFields(
                            Theme.of(context).colorScheme.secondary,
                            "${Variables.name[0]}",
                            "${Variables.name[1]}",
                            TextInputType.text,
                            1,
                            ValueKey("ProductName"),
                            productName),
                        Text(
                          "${Variables.unitPrice[0]}",
                          style: titilliumRegular,
                        ),
                        EditPageFields().buildStaticInputFields(
                            Theme.of(context).colorScheme.secondary,
                            "${Variables.unitPrice[0]}",
                            "${Variables.unitPrice[1]}",
                            TextInputType.number,
                            1,
                            ValueKey("unitPrice"),
                            unitPrice),
                        SizedBox(
                          height: 5,
                        ),

                        Obx(
                          () {
                            return _attrController.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator())
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
                                                  _attrController
                                                      .attrList[0]
                                                      .attrs![index]
                                                      .controlName,
                                                  style: titilliumRegular,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8),
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
                                                            offset:
                                                                Offset(0, 5))
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
                                                              _controller
                                                                  .validate(
                                                                      false);
                                                              return "Please select item!";
                                                            } else {
                                                              _controller
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
                                                    )),
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
                                                      child:
                                                          buildEditInputFields(
                                                        index,
                                                        key: ValueKey(
                                                            "${_attrController.attrList[0].attrs![index].controlName}"),
                                                        value: attr[
                                                            _attrController
                                                                .attrList[0]
                                                                .attrs![index]
                                                                .controlName],
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
                                                        Obx(
                                                          () =>
                                                              CustomRadioButton(
                                                                  index: index,
                                                                  radiokey:
                                                                      ValueKey(
                                                                    "${_attrController.attrList[0].attrs![index].controlName}",
                                                                  )),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        )
                                                      ],
                                                    )
                                                  : Container();
                                    });
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
                        EditPageFields().buildDescriptionField(
                            Theme.of(context).colorScheme.secondary,
                            "${Variables.description[0]}",
                            "${Variables.description[1]}",
                            TextInputType.text,
                            5,
                            ValueKey("${Variables.description[1]}"),
                            description),

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
                        EditPageFields().buildButton(context, "Edit", () {
                          _controller.key.currentState!.save();
                          if (_categoryController.isValidated.value) {
                            imageCon.editImagesInListOfImages(index);
                            _fieldsController.editDataInList(
                                _fieldsController.jsonMap, index);
                            _categoryController.editDataInUiList(
                                index, _categoryController.submit);
                            Get.back();
                            Get.snackbar(
                                "Success", "Data Edited Successfully!");
                          }
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
