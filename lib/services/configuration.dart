
class Url{
  final String getRawCategoryurl = 'https://moneylink.network/offer-barry/api/v2/seller/products/get-raw-categories';
  String getRawSubCategoryUrl(String id){
    return 'https://moneylink.network/offer-barry/api/v2/seller/products/get-raw-sub-categories?id=$id';
  }
  String getRawSubCategoryAttrUrl(String cat_id,parent_id){
    return 'https://moneylink.network/offer-barry/api/v2/seller/products/get-category-attrs?cat_id=$cat_id&parent_id=$parent_id';
  }

}

class Variables{

  static const categoryId = "category_id";

  static const subCategoryId = "sub_category_id";

  static const attr = "attrs";

  static const images = ["Images","images"];

  static const categoryName = ["Category","category_id"];

  static const subCategoryName = ["Sub Category","sub_category_id"];

  static const name = ["Product Name","name"];

  static const unitPrice = ["Unit Price","unit_price"];

  static const description = ["Description","editor"];

}