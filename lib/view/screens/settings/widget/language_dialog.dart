import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../provider/localization_provider.dart';
import '../../../../provider/splash_provider.dart';
import '../../../../utill/app_constants.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/styles.dart';

class LanguageDialog extends StatelessWidget {
  final bool isCurrency;
  LanguageDialog({this.isCurrency = true});

  @override
  Widget build(BuildContext context) {
    int index;
    if(isCurrency) {
      index = Provider.of<SplashProvider>(context, listen: false).currencyIndex;
    }else {
      index = Provider.of<LocalizationProvider>(context, listen: false).languageIndex;
    }

    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [

        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(isCurrency ? getTranslated('currency', context) : getTranslated('language', context), style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
        ),

        SizedBox(height: 150, child: Consumer<SplashProvider>(
          builder: (context, splash, child) {
            List<String> _valueList = [];
            if(isCurrency) {
              splash.configModel.currencyList.forEach((currency) => _valueList.add(currency.name));
            }else {
              AppConstants.languages.forEach((language) => _valueList.add(language.languageName!));
            }
            return CupertinoPicker(
              itemExtent: 40,
              useMagnifier: true,
              magnification: 1.2,
              scrollController: FixedExtentScrollController(initialItem: index),
              onSelectedItemChanged: (int i) {
                index = i;
              },
              children: _valueList.map((value) {
                return Center(child: Text(value, style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color)));
              }).toList(),
            );
          },
        )),

        Divider(height: Dimensions.PADDING_SIZE_EXTRA_SMALL, color: ColorResources.HINT_TEXT_COLOR),
        Row(children: [
          Expanded(child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(getTranslated('cancel', context), style: robotoRegular.copyWith(color: ColorResources.getYellow(context))),
          )),
          Container(
            height: 50,
            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: VerticalDivider(width: Dimensions.PADDING_SIZE_EXTRA_SMALL, color: Theme.of(context).hintColor),
          ),
          Expanded(child: TextButton(
            onPressed: () {
              if(isCurrency) {
                Provider.of<SplashProvider>(context, listen: false).setCurrency(index);
              }else {
                Provider.of<LocalizationProvider>(context, listen: false).setLanguage(Locale(
                  AppConstants.languages[index].languageCode!,
                  AppConstants.languages[index].countryCode,
                ), index);
              }
              Navigator.pop(context);
            },
            child: Text(getTranslated('ok', context), style: robotoRegular.copyWith(color: ColorResources.getGreen(context))),
          )),
        ]),

      ]),
    );
  }
}