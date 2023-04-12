import 'package:get/get.dart';

class SellingMethodController extends GetxController {
  RxBool _isWholeSale = false.obs;

  bool get isWholeSale => _isWholeSale.value;

  void setWholeSale(bool value) {
    _isWholeSale(value);
  }
}
