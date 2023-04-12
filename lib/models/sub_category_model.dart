class SubCategoryModel {
  int? id;
  String? name;
  String? slug;
  String? icon;
  int? parentId;
  int? category;
  int? position;
  int? commission;
  String? createdAt;
  String? updatedAt;

  SubCategoryModel(
      {this.id,
      this.name,
      this.slug,
      this.icon,
      this.parentId,
      this.category,
      this.position,
      this.commission,
      this.createdAt,
      this.updatedAt});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon = json['icon'];
    parentId = json['parent_id'];
    category = json['category'];
    position = json['position'];
    commission = int.tryParse(json['commission']);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['icon'] = icon;
    data['parent_id'] = parentId;
    data['category'] = category;
    data['position'] = position;
    data['commission'] = commission;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
