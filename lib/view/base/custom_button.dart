import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';
import '../../utill/color_resources.dart';
import '../../utill/styles.dart';

class CustomButton extends StatelessWidget {
  final Function? onTap;
  final String? btnTxt;
  final Color? backgroundColor;
  CustomButton({this.onTap, @required this.btnTxt, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap! as Function(),
      style: TextButton.styleFrom(padding: EdgeInsets.all(0),
        backgroundColor: onTap == null ? ColorResources.getGrey(context) : backgroundColor == null ? Theme.of(context).primaryColor : backgroundColor,
      ),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorResources.getChatIcon(context),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
            ],
            gradient: (Provider.of<ThemeProvider>(context).darkTheme || onTap == null) ? null : LinearGradient(colors: [
              Theme.of(context).primaryColor,
              ColorResources.getBlue(context),
              ColorResources.getBlue(context),
            ]),
            borderRadius: BorderRadius.circular(10)),
        child: Text(btnTxt!,
            style: titilliumSemiBold.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            )),
      ),
    );
  }
}
