import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/provider/shop_info_provider.dart';
import 'package:hundredminute_seller/provider/splash_provider.dart';
import 'package:hundredminute_seller/provider/theme_provider.dart';
import 'package:hundredminute_seller/utill/color_resources.dart';
import 'package:hundredminute_seller/utill/dimensions.dart';
import 'package:hundredminute_seller/utill/images.dart';
import 'package:hundredminute_seller/utill/styles.dart';
import 'package:hundredminute_seller/view/base/custom_app_bar.dart';
import 'package:hundredminute_seller/view/base/custom_button.dart';
import 'package:hundredminute_seller/view/base/no_data_screen.dart';
import 'package:hundredminute_seller/view/screens/restaurant/shop_settings.dart';

class ShopScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Provider.of<ShopProvider>(context, listen: false).getShopInfo(context);
    return Scaffold(
        appBar: CustomAppBar(title: getTranslated('my_shop', context)),
        body: SafeArea(
            child: Consumer<ShopProvider>(
                builder: (context, resProvider, child) {
                  return resProvider.shopModel !=null ? resProvider.shopModel != null ? Container(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                    margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200], spreadRadius: 0.5, blurRadius: 0.3)],
                    ),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height-(MediaQuery.of(context).padding.top+50+60),
                          child: Column(mainAxisAlignment: MediaQuery.of(context).size.height > MediaQuery.of(context).size.width ? MainAxisAlignment.center : MainAxisAlignment.start, children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: FadeInImage.assetNetwork(
                                  placeholder: Images.placeholder_image,
                                  image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.shopImageUrl}/${resProvider.shopModel.image}',
                                  fit: BoxFit.cover, height: 100, width: 100,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              '${getTranslated('name', context)} : ${resProvider.shopModel.name ?? ''}',
                              style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                            ),
                            Text(
                              '${getTranslated('contact', context)} :  ${resProvider.shopModel.contact ?? ''}',
                              style: titilliumBold.copyWith(color: ColorResources.getTextColor(context),fontSize: Dimensions.FONT_SIZE_SMALL),
                              overflow: TextOverflow.ellipsis, maxLines: 1,
                            ),
                            Text(
                              '${getTranslated('address', context)} :  ${resProvider.shopModel.address ?? ''}',
                              style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_SMALL),
                              overflow: TextOverflow.ellipsis, maxLines: 1,
                            ),
                            SizedBox(height: 20),
                            CustomButton(
                              btnTxt: getTranslated('edit', context),
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShopSettingsScreen(shopInfoModel: resProvider.shopModel))),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  )
                      : NoDataScreen()
                      : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));
                })
        )
    );
  }
}

