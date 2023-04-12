class getRawCatgory {
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

  getRawCatgory(
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

  getRawCatgory.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['icon'] = this.icon;
    data['parent_id'] = this.parentId;
    data['category'] = this.category;
    data['position'] = this.position;
    data['commission'] = this.commission;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
