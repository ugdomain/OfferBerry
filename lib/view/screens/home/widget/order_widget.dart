import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hundredminute_seller/data/model/response/order_model.dart';
import 'package:hundredminute_seller/helper/date_converter.dart';
import 'package:hundredminute_seller/helper/price_converter.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/provider/theme_provider.dart';
import 'package:hundredminute_seller/utill/color_resources.dart';
import 'package:hundredminute_seller/utill/dimensions.dart';
import 'package:hundredminute_seller/utill/styles.dart';
import 'package:hundredminute_seller/view/screens/order/order_details_screen.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel orderModel;
  OrderWidget({@required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: ColorResources.getBottomSheetColor(context),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200], spreadRadius: 0.5, blurRadius: 0.3)],
      ),
      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              children: [
               Text('${getTranslated('order_no', context)} : #${orderModel.id}', style: titilliumBold.copyWith(color: ColorResources.getTextColor(context),fontSize: 14),),
               Expanded(child: SizedBox()),
                Container(
                  height: 10,
                  width: 15,
                  decoration: BoxDecoration(shape: BoxShape.circle, color:orderModel.paymentStatus == 'paid' ? ColorResources.GREEN : ColorResources.RED),),
                Text(orderModel.paymentStatus.toUpperCase(), style: titilliumBold.copyWith(color: orderModel.paymentStatus == 'paid' ? ColorResources.GREEN : ColorResources.RED, fontSize: 14)),
              ]
          ),
          SizedBox(height: 10),

          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  color: ColorResources.getFloatingBtn(context),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(DateConverter.isoStringToLocalDateOnly(orderModel.createdAt), style: titilliumSemiBold),
              ),
              Expanded(child: SizedBox()),
              InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailsScreen (
                    orderModel: orderModel ,orderId: orderModel.id))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                    child: Text('${getTranslated('view_details', context)}',
                        style: titilliumRegular.copyWith(color: ColorResources.getTextColor(context),fontSize: 12)),
                  ),
              ),
            Icon(Icons.arrow_forward_outlined, color: Theme.of(context).primaryColor)
            ],
          )
        ],
      ),
    );
  }
}
