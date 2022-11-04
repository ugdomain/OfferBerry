import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/splash_provider.dart';

class PriceConverter {
  static String convertPrice(BuildContext context, double price, {double? discount, String? discountType}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount' || discountType == 'flat') {
        price = price - discount;
      }else if(discountType == 'percent' || discountType == 'percentage') {
        price = price - ((discount / 100) * price);
      }
    }
    return '${Provider.of<SplashProvider>(context).myCurrency.symbol}${(price
        * Provider.of<SplashProvider>(context, listen: false).myCurrency.exchangeRate
        * (1/Provider.of<SplashProvider>(context, listen: false).usdCurrency.exchangeRate)).toStringAsFixed(2)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  static double convertAmount(double amount, BuildContext context) {
    return double.parse('${(amount * Provider.of<SplashProvider>(context).myCurrency.exchangeRate *
        (1/Provider.of<SplashProvider>(context, listen: false).usdCurrency.exchangeRate)).toStringAsFixed(2)}');
  }
}