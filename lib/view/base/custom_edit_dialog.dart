import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/provider/profile_provider.dart';
import 'package:hundredminute_seller/provider/splash_provider.dart';
import 'package:hundredminute_seller/utill/color_resources.dart';
import 'package:hundredminute_seller/utill/dimensions.dart';
import 'package:hundredminute_seller/utill/styles.dart';



class CustomEditDialog extends StatefulWidget {
  _CustomEditDialogState createState() => _CustomEditDialogState();
}

class _CustomEditDialogState extends State<CustomEditDialog> {

  final TextEditingController _balanceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorResources.getBottomSheetColor(context),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(getTranslated('withdraw_request', context),
            style: titilliumSemiBold.copyWith(
                fontSize: Dimensions.FONT_SIZE_LARGE,
                color: ColorResources.getTextColor(context)),),

          SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
          Text('${getTranslated('amount', context)} :',
              style: titilliumBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                  color: ColorResources.getHintColor(context)))
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _balanceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: Dimensions.FONT_SIZE_DEFAULT),
                  border: OutlineInputBorder(),
                ),
            ),
          ),

          SizedBox(height: 10),

          !Provider.of<ProfileProvider>(context).isLoading
              ? Row( mainAxisAlignment: MainAxisAlignment.end,
              children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorResources.COLOR_LIGHT_BLACK
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(getTranslated('close', context),
                  style: titilliumBold.copyWith(color: ColorResources.WHITE),),
              ),
            ),
            SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).primaryColor
              ),
              child: TextButton(
                  onPressed: () {
                    _updateUserAccount();
                  },
                  child: Text(getTranslated('request', context), style: titilliumBold.copyWith(color: ColorResources.WHITE))
              ),
            ),

          ]) : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
        ],
      ),
    );
  }

  void _updateUserAccount() async {
    String _balance = _balanceController.text.trim();
    double _bal = 0;
    if(_balance.isNotEmpty) {
      _bal = double.parse(_balance) / Provider.of<SplashProvider>(context, listen: false).myCurrency.exchangeRate;
    }
    double _myBalance = Provider.of<ProfileProvider>(context, listen: false).userInfoModel.wallet.balance
        * Provider.of<SplashProvider>(context, listen: false).usdCurrency.exchangeRate;

    if (_balance.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(getTranslated('enter_balance', context)),
        backgroundColor: Colors.red,
      ));
    }else if(_myBalance < _bal) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(getTranslated('enter_lower_amount', context)),
        backgroundColor: Colors.red,
      ));
    }else if(_bal < 2) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${getTranslated('enter_minimum_amount', context)} '
            '${2 * Provider.of<SplashProvider>(context, listen: false).myCurrency.exchangeRate}'),
        backgroundColor: Colors.red,
      ));
    }else {
      await Provider.of<ProfileProvider>(context, listen: false).updateBalance(_bal.toString()).then((response) {
        if(response.isSuccess) {
          Provider.of<ProfileProvider>(context, listen: false).getSellerInfo(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message), backgroundColor: Colors.green));
          Navigator.pop(context);
        }else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message), backgroundColor: Colors.red));
        }
      });
    }
  }
}
