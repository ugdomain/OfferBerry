import 'package:flutter/material.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/utill/dimensions.dart';
import 'package:hundredminute_seller/utill/images.dart';
import 'package:hundredminute_seller/utill/styles.dart';

class NoDataScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [

          Image.asset(
            Images.no_data,
            width: MediaQuery.of(context).size.height*0.22, height: MediaQuery.of(context).size.height*0.22,
            color: Theme.of(context).primaryColor,
          ),

          Text(
            getTranslated('nothing_found', context),
            style: titilliumBold.copyWith(color: Theme.of(context).primaryColor, fontSize: MediaQuery.of(context).size.height*0.023),
            textAlign: TextAlign.center,
          ),

        ]),
      ),
    );
  }
}
