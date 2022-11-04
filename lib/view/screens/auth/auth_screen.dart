import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import 'login_screen.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider.of<ProfileProvider>(context, listen: false).initAddressTypeList(context);
    Provider.of<AuthProvider>(context, listen: false).isActiveRememberMe;

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // background
          Provider.of<ThemeProvider>(context).darkTheme
              ? SizedBox()
              : Image.asset(Images.background,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width),

          Consumer<AuthProvider>(
            builder: (context, auth, child) => SafeArea(
              child: ListView(
                children: [
                  SizedBox(height: 30),
                  Center(
                    child: Padding(
                      padding:
                          EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: Image.asset(
                        Images.mini_logo,
                        height: 200,
                        width: 200, /*color: Theme.of(context).primaryColor*/
                      ),
                    ),
                  ),
                  Center(
                      child: Text(
                    getTranslated('login', context),
                    style: titilliumBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                  )),
                  SignInWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
