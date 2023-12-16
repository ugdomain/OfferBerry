import 'package:get/get.dart';

class SellingMethodController extends GetxController {
  RxBool _isWholeSale = false.obs;
  RxBool _isNewProduct = false.obs;

  bool get isWholeSale => _isWholeSale.value;
  bool get isNewProduct => _isNewProduct.value;

  void isProductNew(bool value) {
    _isNewProduct.value = value;
  }

  void setWholeSale(bool value) {
    _isWholeSale(value);
  }
}
