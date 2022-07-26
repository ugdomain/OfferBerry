class ShopModel {
  int id;
  int sellerId;
  String name;
  String address;
  String contact;
  String image;
  String createdAt;
  String updatedAt;

  ShopModel(
      {this.id,
        this.sellerId,
        this.name,
        this.address,
        this.contact,
        this.image,
        this.createdAt,
        this.updatedAt});

  ShopModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
