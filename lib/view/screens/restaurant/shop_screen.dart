import 'package:flutter/material.dart';
import 'package:hundredminute_seller/view/screens/restaurant/shop_settings.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/shop_info_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/no_data_screen.dart';

class ShopScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Provider.of<ShopProvider>(context, listen: false).getShopInfo(context);
    return Scaffold(
        appBar: CustomAppBar(title: getTranslated('my_shop', context)),
        body: SafeArea(
            child: Consumer<ShopProvider>(
                builder: (context, resProvider, child) {
                  return resProvider !=null ? resProvider.shopModel != null ?
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                    margin: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!, spreadRadius: 0.5, blurRadius: 0.3)],
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
                                  image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.shopImageUrl}/${resProvider.shopModel!.image}',
                                  fit: BoxFit.cover, height: 100, width: 100,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              '${getTranslated('name', context)} : ${resProvider.shopModel!.name ?? ''}',
                              style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_LARGE),
                            ),
                            Text(
                              '${getTranslated('contact', context)} :  ${resProvider.shopModel!.contact ?? ''}',
                              style: titilliumBold.copyWith(color: ColorResources.getTextColor(context),fontSize: Dimensions.FONT_SIZE_SMALL),
                              overflow: TextOverflow.ellipsis, maxLines: 1,
                            ),
                            Text(
                              '${getTranslated('address', context)} :  ${resProvider.shopModel!.address ?? ''}',
                              style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_SMALL),
                              overflow: TextOverflow.ellipsis, maxLines: 1,
                            ),
                            const SizedBox(height: 20),
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

