import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controllers/category_controller.dart';
import '../../../controllers/static_fields_controller.dart';
import '../../../controllers/sub_category_attr_controller.dart';
import '../../../controllers/sub_category_controller.dart';
import '../../../excel_file/excel_page_controller.dart';
import '../../../utill/styles.dart';
import '../../get_image_widget/get_image_controller.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class CustomTextField extends StatelessWidget {

  final CategoryController _categoryController = Get.put(CategoryController());
  final SubCategoryController _subCategoryController = Get.find();
  final SubCategoryAttrController _attrController = Get.find();
  final ExcelController _excelController = Get.put(ExcelController());
  final StaticFieldsController _fieldsController = Get.put(StaticFieldsController());
  ChooseImageController imageCon = Get.put(ChooseImageController());


  final String? name;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool? isPhoneNumber;
  final bool? isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization? capitalization;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  CustomTextField({
    this.name,
    this.controller,
    this.hintText,
    this.textInputType,
    this.maxLine,
    this.focusNode,
    this.nextNode,
    this.textInputAction,
    this.isPhoneNumber = false,
    this.isValidator = false,
    this.validatorMessage,
    this.capitalization = TextCapitalization.none,
    this.fillColor,
    this.onChanged,
    this.validator,
    this.onSaved,
  });

  @override
  Widget build(context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: isPhoneNumber!
            ? BorderRadius.only(
                topRight: Radius.circular(6), bottomRight: Radius.circular(6))
            : BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1)) // changes position of shadow
        ],
      ),
      child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          maxLines: maxLine ?? 1,
          textCapitalization: capitalization!,
          maxLength: isPhoneNumber! ? 15 : null,
          focusNode: focusNode,
          keyboardType: textInputType ?? TextInputType.text,
          //keyboardType: TextInputType.number,
          initialValue: null,
          textInputAction: textInputAction ?? TextInputAction.next,
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(nextNode);
          },
          //autovalidate: true,
          inputFormatters: [
            isPhoneNumber!
                ? FilteringTextInputFormatter.digitsOnly
                : FilteringTextInputFormatter.singleLineFormatter
          ],
          decoration: InputDecoration(
            hintText: hintText ?? '',
            filled: fillColor != null,
            fillColor: fillColor,
            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
            isDense: true,
            counterText: '',
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            hintStyle:
                titilliumRegular.copyWith(color: Theme.of(context).hintColor),
            errorStyle: TextStyle(height: 1.5),
            border: InputBorder.none,
          ),
        ),
    );
  }
}
