class Url {
  final String getRawCategoryurl =
      'https://offerbaries.com/api/v2/seller/products/get-raw-categories';
  String getRawSubCategoryUrl(String id) {
    return 'https://offerbaries.com/api/v2/seller/products/get-raw-sub-categories?id=$id';
  }

  String getRawSubCategoryAttrUrl(String catId, parentId) {
    print(
        "url is https://offerbaries.com/api/v2/seller/products/get-category-attrs?cat_id=$catId&parent_id=$parentId");
    return 'https://offerbaries.com/api/v2/seller/products/get-category-attrs?cat_id=$catId&parent_id=$parentId';
  }
}

class Variables {
  static const categoryId = "category_id";

  static const subCategoryId = "sub_category_id";

  static const attr = "attrs";

  static const images = ["Images", "images"];

  static const categoryName = ["Category", "category_id"];

  static const subCategoryName = ["Sub Category", "sub_category_id"];

  static const name = ["Product Name", "name"];

  static const unitPrice = ["Unit Price", "unit_price"];

  static const description = ["Description", "editor"];

  static const quantity = ["quantity", "quantity"];

  static const batchId = ["batch_id", "batch_id"];

  static const defect = ["defect", "defect"];

  static const palateId = ["palate_id", "palate_id"];
}
