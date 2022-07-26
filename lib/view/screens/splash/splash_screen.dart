import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hundredminute_seller/helper/network_info.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/provider/auth_provider.dart';
import 'package:hundredminute_seller/provider/splash_provider.dart';
import 'package:hundredminute_seller/provider/theme_provider.dart';
import 'package:hundredminute_seller/utill/app_constants.dart';
import 'package:hundredminute_seller/utill/color_resources.dart';
import 'package:hundredminute_seller/utill/dimensions.dart';
import 'package:hundredminute_seller/utill/images.dart';
import 'package:hundredminute_seller/utill/styles.dart';
import 'package:hundredminute_seller/view/screens/auth/auth_screen.dart';
import 'package:hundredminute_seller/view/screens/dashboard/dashboard_screen.dart';
import 'package:hundredminute_seller/view/screens/splash/widget/splash_painter.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    NetworkInfo.checkConnectivity(context);

    // Provider.of<SplashProvider>(context, listen: false).initSharedPrefData();
    // Provider.of<CartProvider>(context, listen: false).getCartData();
    Provider.of<SplashProvider>(context, listen: false)
        .initConfig(context)
        .then((bool isSuccess) {
      if (isSuccess) {
        Timer(Duration(seconds: 1), () {
          if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => DashboardScreen()));
          } else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => AuthScreen()));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Provider.of<ThemeProvider>(context).darkTheme
              ? Colors.black
              : ColorResources.getPrimary(context),
          child: CustomPaint(
            painter: SplashPainter(),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Images.app_logo,
                height: 250.0,
                fit: BoxFit.scaleDown,
                width: 250.0, /*color: Theme.of(context).accentColor*/
              ),
              // Text(
              //   AppConstants.APP_NAME, style: titilliumBold.copyWith(fontSize: Dimensions.PADDING_SIZE_EXTRA_LARGE,
              //     color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : ColorResources.WHITE),
              // ),
              SizedBox(height: 10),
              Text(
                getTranslated('vendor', context),
                style: titilliumBold.copyWith(
                    color: Provider.of<ThemeProvider>(context).darkTheme
                        ? Colors.white
                        : ColorResources.WHITE),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
