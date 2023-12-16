import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundredminute_seller/view/screens/home/home_screen.dart';

SubCategoryAttr subCategoryAttrFromJson(str) => SubCategoryAttr.fromJson(str);

String subCategoryAttrToJson(SubCategoryAttr data) =>
    json.encode(data.toJson());

class SubCategoryAttr {
  SubCategoryAttr({
    required this.id,
    required this.catId,
    required this.parentId,
    this.attrs,
  });

  int? id;
  String? catId;
  String? parentId;
  List<Attr>? attrs;

  factory SubCategoryAttr.fromJson(Map<String, dynamic> json) {
    final subCategoryAttr = SubCategoryAttr(
      id: json["id"],
      catId: json["cat_id"],
      parentId: json["parent_id"],
      attrs: HomeScreen.sellingMethodController.isWholeSale
          ? List<Attr>.from(
              json["attrs"].map((x) => Attr.fromJson(x)).toList() +
                  [
                    Attr(
                      control: "input",
                      controlName: "Batch Id",
                      jsonName: "batch_id",
                      controlValidation: "REQUIRED",
                      type: TextInputType.number,
                    ),
                    Attr(
                      control: "input",
                      controlName: "Quantity",
                      jsonName: "quantity",
                      controlValidation: "REQUIRED",
                      type: TextInputType.number,
                    ),
                    Attr(
                      control: "input",
                      controlName: "Palate Id",
                      jsonName: "palate_id",
                      controlValidation: "REQUIRED",
                      type: TextInputType.number,
                    ),
                    // if (!HomeScreen.sellingMethodController.isNewProduct)
                    //   {
                    //     Attr(
                    //       control: "input",
                    //       controlName: "Defects",
                    //       jsonName: "defects",
                    //       controlValidation: "REQUIRED",
                    //       type: TextInputType.text,
                    //     ),
                    //   },
                    // if (HomeScreen.sellingMethodController.isNewProduct)
                    //   {
                    //     Attr(
                    //       control: "input",
                    //       controlName: "Minimum Quantity",
                    //       jsonName: "min_qty",
                    //       controlValidation: "REQUIRED",
                    //       type: TextInputType.number,
                    //     )
                    //   },
                  ],
            )
          : List<Attr>.from(
              json["attrs"] != null
                  ? json["attrs"].map((x) => Attr.fromJson(x)).toList()
                  : [],
            ),
    );
    if (HomeScreen.sellingMethodController.isNewProduct) {
      subCategoryAttr.attrs!.add(
        Attr(
          control: "input",
          controlName: "Minimum Quantity",
          jsonName: "min_qty",
          controlValidation: "REQUIRED",
          type: TextInputType.number,
        ),
      );
    } else {
      subCategoryAttr.attrs!.add(
        Attr(
          control: "input",
          controlName: "Defects",
          jsonName: "defects",
          controlValidation: "REQUIRED",
          type: TextInputType.text,
        ),
      );
    }
    return subCategoryAttr;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "cat_id": catId,
        "parent_id": parentId,
        "attrs": List<dynamic>.from(attrs!.map((x) => x.toJson())),
      };
}

class Attr {
  Attr({
    required this.control,
    required this.controlName,
    required this.controlValidation,
    this.controlOptions,
    this.type,
    this.jsonName,
  });

  String control;
  String controlName;
  String controlValidation;
  List<String>? controlOptions;
  String? jsonName;

  TextInputType? type;

  factory Attr.fromJson(Map<String, dynamic> json) => Attr(
        control: json["control"],
        controlName: json["control_name"],
        controlValidation: json["control_validation"],
        controlOptions: json["control_options"] == null
            ? null
            : List<String>.from(json["control_options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "control": control,
        "control_name": controlName,
        "control_validation": controlValidation,
        "control_options": controlOptions == null
            ? null
            : List<dynamic>.from(controlOptions!.map((x) => x)),
      };
}
