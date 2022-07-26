// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sixvalley_vendor_app/data/model/response/order_details_model.dart';
// import 'package:sixvalley_vendor_app/helper/price_converter.dart';
// import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
// import 'package:sixvalley_vendor_app/provider/theme_provider.dart';
// import 'package:sixvalley_vendor_app/utill/color_resources.dart';
// import 'package:sixvalley_vendor_app/utill/dimensions.dart';
// import 'package:sixvalley_vendor_app/utill/styles.dart';
//
// class OrderDetailsWidget extends StatelessWidget {
//   final OrderDetailsModel orderDetailsModel;
//   OrderDetailsWidget({this.orderDetailsModel});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return InkWell(
//
//       onTap: () { },
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             Container(
//               margin: EdgeInsets.only( bottom: 15),
//               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//               decoration: BoxDecoration(
//                 color: ColorResources.getBottomSheetColor(context),
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200], spreadRadius: 0.5, blurRadius: 0.3)],
//               ),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//
//                 SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
//
//                 Row(children: [
//                   SizedBox(width: 145,) ,
//                   Expanded(
//                     flex: 3,
//                     child: Text(getTranslated('item', context),
//                       style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: Theme.of(context).hintColor),
//                       maxLines: 2, overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   SizedBox(width: 35),
//                   Expanded(
//                       flex: 2,
//                       child: Text(getTranslated('price', context), style: titilliumSemiBold.copyWith(color: ColorResources.getTextColor(context)),)),
//                 ],),
//                 SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
//
//                 Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                   Text(getTranslated('total_amount', context),
//                       style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Theme.of(context).primaryColor)),
//                   Text(
//                     PriceConverter.convertPrice(context, totalPrice),
//                     style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: Theme.of(context).primaryColor),
//                   ),
//                 ]),
//                 SizedBox(height: 30),
//
//               ]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
