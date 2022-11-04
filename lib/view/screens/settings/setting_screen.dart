import 'package:flutter/material.dart';
import 'package:hundredminute_seller/view/screens/settings/widget/language_dialog.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/splash_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/styles.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_dialog.dart';
import '../transaction/transaction_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<SplashProvider>(context, listen: false).setFromSetting(true);

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('more', context),),
      body: SafeArea( 
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          children: [

            const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
            TitleButton(
              icon: Icons.language,
              title: getTranslated('choose_language', context),
              onTap: () => showAnimatedDialog(context, LanguageDialog(isCurrency: false)),
            ),
            TitleButton(
              icon: Icons.monetization_on,
              title: '${getTranslated('currency', context)} (${Provider.of<SplashProvider>(context).myCurrency.name})',
              onTap: () => showAnimatedDialog(context, LanguageDialog(isCurrency: true)),
            ),
            TitleButton(
                icon: Icons.list_alt,
                title: getTranslated('transactions', context),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => TransactionScreen()))
            ),
          ],
        ),
      ),
    );
  }

}
class TitleButton extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Function? onTap;
  TitleButton({@required this.icon, @required this.title, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: ColorResources.getPrimary(context)),
      title: Text(title!, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: onTap! as Function(),
    );
  }
}

