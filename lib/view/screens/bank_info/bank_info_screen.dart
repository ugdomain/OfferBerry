import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/bank_info_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/styles.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/no_data_screen.dart';
import 'bank_editing_screen.dart';

class BankInfoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Provider.of<BankInfoProvider>(context, listen: false).getBankInfo(context);

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('bank_info', context)),
      body: SafeArea(
        child: Container(
          child: Consumer<BankInfoProvider>(
            builder: (context, bankProvider, child) => bankProvider.bankInfo != null ? Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!, spreadRadius: 0.5, blurRadius: 0.3)],
              ),
              child: Column( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(children: [
                    Text(
                      '${getTranslated('bank_name', context)} : \t',
                      style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                    ),
                    Text(
                      '${bankProvider.bankInfo.bankName ?? getTranslated('no_data_found', context)}',
                      style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ]),
                  Row(children: [
                    Text(
                      '${getTranslated('branch_name', context)} : \t',
                      style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                    ),
                    Text(
                      '${bankProvider.bankInfo.branch ?? getTranslated('no_data_found', context)}',
                      style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                      textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ]),
                  Row(children: [
                    Text(
                      '${getTranslated('holder_name', context)} : \t',
                      style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                    ),
                    Text(
                      '${bankProvider.bankInfo.holderName ?? getTranslated('no_data_found', context)}',
                      style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                      textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ]),
                  Row(children: [
                    Text(
                      '${getTranslated('account_no', context)} : \t',
                      style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      bankProvider.bankInfo.accountNo ?? getTranslated('no_data_found', context),
                      style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                      textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ]),
                  SizedBox(height: 10),
                  CustomButton(
                    btnTxt: getTranslated('edit', context),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BankEditingScreen(sellerModel: bankProvider.bankInfo))),
                  ),
                ],
              ),
            ) : NoDataScreen(),
          ),
        ),
      ),
    );
  }
}
