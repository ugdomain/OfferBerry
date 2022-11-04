class Subcatogarymodel {
  int? id;
  int? catId;
  int? parentId;
  List<Attrs>? attrs;

  Subcatogarymodel({this.id, this.catId, this.parentId, this.attrs});

  Subcatogarymodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    parentId = json['parent_id'];
    if (json['attrs'] != null) {
      attrs = <Attrs>[];
      json['attrs'].forEach((v) {
        attrs!.add(new Attrs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['parent_id'] = this.parentId;
    if (this.attrs != null) {
      data['attrs'] = this.attrs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attrs {
  String? control;
  String? controlName;
  String? controlValidation;
  List<String>? controlOptions;

  Attrs(
      {this.control,
      this.controlName,
      this.controlValidation,
      this.controlOptions});

  Attrs.fromJson(Map<String, dynamic> json) {
    control = json['control'];
    controlName = json['control_name'];
    controlValidation = json['control_validation'];
    controlOptions = json['control_options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['control'] = this.control;
    data['control_name'] = this.controlName;
    data['control_validation'] = this.controlValidation;
    data['control_options'] = this.controlOptions;
    return data;
  }
}
