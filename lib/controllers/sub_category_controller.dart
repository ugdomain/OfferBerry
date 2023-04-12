import 'package:get/get.dart';
import 'package:hundredminute_seller/controllers/sub_category_attr_controller.dart';
import '../models/sub_category_model.dart';
import '../services/api_services.dart';

class SubCategoryController extends GetxController {
  final subCategoryList = <SubCategoryModel>[].obs;
  final subCategoryValue = "Select Sub Category".obs;
  var subCategoryId = "".obs;
  var isLoading = false.obs;
  var isParentIdMatch = false.obs;
  final SubCategoryAttrController _attrController =
      Get.put(SubCategoryAttrController());

  @override
  void onInit() {
    super.onInit();
    isParentIdMatch(false);
  }

  setSubCategoryId(String id, String catId) {
    subCategoryId(id);
    _attrController.fetchAttrData(catId, id);
  }

  void setSelectedValue(String? value) {
    subCategoryValue(value!);
  }

  Future<void> fetchSubCategory(String? id) async {
    print("fetching value");
    isLoading(true);
    try {
      var subCategory =
          await ProductServices().getRawSubCategoryList(id.toString());
      if (subCategory != null) {
        subCategoryList(subCategory);
        isLoading(true);
      }
    } finally {
      isLoading(false);
    }
  }
}
