import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/response/order_model.dart';
import '../../../../provider/order_provider.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';
import '../../../../utill/styles.dart';

class OrderTypeButton extends StatelessWidget {
  final String? text;
  final int? index;
  final Function? callback;
  final List<OrderModel>? orderList;
  OrderTypeButton({@required this.text, @required this.index, @required this.callback, @required this.orderList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<OrderProvider>(context, listen: false).setIndex(index!);
        callback!();
      },
      child: Container(
        alignment: Alignment.center,
        width: 120,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 5),
        decoration: BoxDecoration(
          color: ColorResources.getBottomSheetColor(context),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!, spreadRadius: 0.5, blurRadius: 0.3)],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(orderList!.length.toString(),
                style: titilliumBold.copyWith(color: ColorResources.getPrimary(context), fontSize: Dimensions.PADDING_SIZE_LARGE)),

            Text(text!,
                style: titilliumBold.copyWith(color: ColorResources.getPrimary(context))),

          ],
        ),
      ),
    );
  }
}
