import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/provider/profile_provider.dart';
import 'package:hundredminute_seller/provider/splash_provider.dart';
import 'package:hundredminute_seller/provider/theme_provider.dart';
import 'package:hundredminute_seller/utill/color_resources.dart';
import 'package:hundredminute_seller/utill/dimensions.dart';
import 'package:hundredminute_seller/utill/images.dart';
import 'package:hundredminute_seller/utill/styles.dart';
import 'package:hundredminute_seller/view/base/custom_bottom_sheet.dart';
import 'package:hundredminute_seller/view/screens/bank_info/bank_info_screen.dart';
import 'package:hundredminute_seller/view/screens/chat/inbox_screen.dart';
import 'package:hundredminute_seller/view/screens/home/home_screen.dart';
import 'package:hundredminute_seller/view/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:hundredminute_seller/view/screens/profile/profile_screen.dart';
import 'package:hundredminute_seller/view/screens/restaurant/shop_screen.dart';
import 'package:hundredminute_seller/view/screens/settings/setting_screen.dart';
import 'package:hundredminute_seller/view/screens/subscription/subscription_screen.dart';
import 'package:provider/provider.dart';

Future<void> _loadData(BuildContext context, bool reload) async {
  await Provider.of<SplashProvider>(context, listen: false).initConfig(context);
  await Provider.of<ProfileProvider>(context, listen: false)
      .getSellerInfo(context);
  await Provider.of<ProfileProvider>(context, listen: false)
      .getSellerInfo(context);
}

class MenuBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _loadData(context, false);
    Provider.of<ProfileProvider>(context, listen: false).getSellerInfo(context);
    return Container(
      height: 320,
      decoration: BoxDecoration(
        color: ColorResources.getHomeBg(context),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getTranslated('dark_theme', context),
                    style: titilliumSemiBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE)),
                FlutterSwitch(
                  width: 50.0,
                  height: 25.0,
                  toggleSize: 30.0,
                  value: Provider.of<ThemeProvider>(context).darkTheme,
                  borderRadius: 10.0,
                  activeColor: Theme.of(context).primaryColor,
                  padding: 1.0,
                  activeIcon: Image.asset(Images.dark_mode,
                      width: 30, height: 30, fit: BoxFit.scaleDown),
                  inactiveIcon: Image.asset(
                    Images.light_mode,
                    width: 30,
                    height: 30,
                    fit: BoxFit.scaleDown,
                  ),
                  onToggle: (bool isActive) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(),
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ProfileScreen())),
                    child: Container(
                      height: 120,
                      width: 120,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorResources.getBottomSheetColor(context),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[
                                  Provider.of<ThemeProvider>(context).darkTheme
                                      ? 800
                                      : 200],
                              spreadRadius: 0.5,
                              blurRadius: 0.3)
                        ],
                      ),
                      child: Consumer<ProfileProvider>(
                        builder: (context, profileProvider, child) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: ColorResources.WHITE, width: 2)),
                                child: ClipOval(
                                    child: FadeInImage.assetNetwork(
                                  placeholder: Images.placeholder_image,
                                  image:
                                      // 'https://alhafizcloth.com/100min/storage/app/public/seller/'
                                      '${Provider.of<SplashProvider>(context, listen: false).baseUrls.sellerImageUrl}'
                                      '/${profileProvider.userInfoModel.image}',
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                )),
                              ),
                              Center(
                                child: Text(
                                  getTranslated('profile', context),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  CustomBottomSheet(
                      image: Icons.message,
                      title: getTranslated('message', context),
                      widget: InboxScreen()),
                  CustomBottomSheet(
                      image: Icons.business,
                      title: getTranslated('bank_info', context),
                      widget: BankInfoScreen()),
                  CustomBottomSheet(
                      image: Icons.home_filled,
                      title: getTranslated('my_shop', context),
                      widget: ShopScreen()),
                  CustomBottomSheet(
                      image: Icons.settings,
                      title: getTranslated('more', context),
                      widget: SettingsScreen()),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Subscription_Screen()));
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorResources.getBottomSheetColor(context),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[
                                  Provider.of<ThemeProvider>(context).darkTheme
                                      ? 800
                                      : 200],
                              spreadRadius: 0.5,
                              blurRadius: 0.3)
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.download_outlined,
                              size: 30,
                            ),
                            Center(
                              child: Text(
                                "Subscription",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      showCupertinoModalPopup(
                          context: context,
                          builder: (_) => SignOutConfirmationDialog());
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorResources.getBottomSheetColor(context),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[
                                  Provider.of<ThemeProvider>(context).darkTheme
                                      ? 800
                                      : 200],
                              spreadRadius: 0.5,
                              blurRadius: 0.3)
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Images.logout,
                                height: 30,
                                width: 30,
                                color: Theme.of(context).primaryColor),
                            Center(
                              child: Text(
                                getTranslated('logout', context),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  /*InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Subscription_Screen()));
                    },
                    child: Container(
                      height: 120,
                      width: 120,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorResources.getBottomSheetColor(context),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[
                                  Provider.of<ThemeProvider>(context).darkTheme
                                      ? 800
                                      : 200],
                              spreadRadius: 0.5,
                              blurRadius: 0.3)
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.download_outlined,
                              size: 30,
                            ),
                            Center(
                              child: Text(
                                "subscription",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
