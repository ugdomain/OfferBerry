
import 'dart:convert';

SubCategoryAttr subCategoryAttrFromJson(str) => SubCategoryAttr.fromJson(str);

String subCategoryAttrToJson(SubCategoryAttr data) => json.encode(data.toJson());

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

  factory SubCategoryAttr.fromJson(Map<String, dynamic> json) => SubCategoryAttr(
    id: json["id"],
    catId: json["cat_id"],
    parentId: json["parent_id"],
    attrs: List<Attr>.from(json["attrs"].map((x) => Attr.fromJson(x))),
  );

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
  });

  String control;
  String controlName;
  String controlValidation;
  List<String>? controlOptions;

  factory Attr.fromJson(Map<String, dynamic> json) => Attr(
    control: json["control"],
    controlName: json["control_name"],
    controlValidation: json["control_validation"],
    controlOptions: json["control_options"] == null ? null : List<String>.from(json["control_options"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "control": control,
    "control_name": controlName,
    "control_validation": controlValidation,
    "control_options": controlOptions == null ? null : List<dynamic>.from(controlOptions!.map((x) => x)),
  };
}
