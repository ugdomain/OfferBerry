import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hundredminute_seller/provider/splash_provider.dart';
import 'package:provider/provider.dart';
import 'package:hundredminute_seller/helper/price_converter.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/provider/bank_info_provider.dart';
import 'package:hundredminute_seller/provider/order_provider.dart';
import 'package:hundredminute_seller/provider/profile_provider.dart';
import 'package:hundredminute_seller/provider/theme_provider.dart';
import 'package:hundredminute_seller/utill/app_constants.dart';
import 'package:hundredminute_seller/utill/color_resources.dart';
import 'package:hundredminute_seller/utill/dimensions.dart';
import 'package:hundredminute_seller/utill/images.dart';
import 'package:hundredminute_seller/utill/styles.dart';
import 'package:hundredminute_seller/view/base/custom_edit_dialog.dart';
import 'package:hundredminute_seller/view/screens/home/widget/bar_chart.dart';
import 'package:hundredminute_seller/view/screens/home/widget/order_type_button.dart';

class HomeScreen extends StatelessWidget {
  final Function callback;
  HomeScreen({@required this.callback});

  Future<void> _loadData(BuildContext context, bool reload) async {
    await Provider.of<SplashProvider>(context, listen: false)
        .initConfig(context);
    await Provider.of<SplashProvider>(context, listen: false)
        .initSharedPrefData();
    await Provider.of<BankInfoProvider>(context, listen: false)
        .getUserEarnings(context);
    await Provider.of<ProfileProvider>(context, listen: false)
        .getSellerInfo(context);
    await Provider.of<BankInfoProvider>(context, listen: false)
        .getBankInfo(context);
    await Provider.of<OrderProvider>(context, listen: false)
        .getOrderList(context);
  }

  @override
  Widget build(BuildContext context) {
    _loadData(context, false);

    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: 0,
        title: Row(
          children: [
            Image.asset(
              Images.mini_logo,
              height: 40,
              width: 40,
              /* color:
                  Provider.of<ThemeProvider>(context, listen: false).darkTheme
                      ? ColorResources.WHITE
                      : Theme.of(context).primaryColor,*/
              fit: BoxFit.scaleDown,
              matchTextDirection: true,
            ),
            SizedBox(width: 10),
            Text(AppConstants.APP_NAME,
                style: titilliumBold.copyWith(
                    color: Theme.of(context).textTheme.bodyText1.color)),
          ],
        ),
        backgroundColor: ColorResources.getBottomSheetColor(context),
        elevation: 0,
      ),
      body: Consumer<OrderProvider>(
        builder: (context, order, child) {
          return order.orderList != null
              ? SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await _loadData(context, true);
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // for restaurant view

                          order.pendingList != null
                              ? Consumer<OrderProvider>(
                                  builder: (context, orderProvider, child) =>
                                      Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                    child: SizedBox(
                                      height: 150,
                                      child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          OrderTypeButton(
                                            text: getTranslated('all', context),
                                            index: 0,
                                            orderList: orderProvider.orderList,
                                            callback: callback,
                                          ),
                                          OrderTypeButton(
                                            text: getTranslated(
                                                'pending', context),
                                            index: 1,
                                            orderList:
                                                orderProvider.pendingList,
                                            callback: callback,
                                          ),
                                          OrderTypeButton(
                                            text: getTranslated(
                                                'processing', context),
                                            index: 2,
                                            orderList: orderProvider.processing,
                                            callback: callback,
                                          ),
                                          OrderTypeButton(
                                            text: getTranslated(
                                                'delivered', context),
                                            index: 3,
                                            orderList:
                                                orderProvider.deliveredList,
                                            callback: callback,
                                          ),
                                          OrderTypeButton(
                                            text: getTranslated(
                                                'return', context),
                                            index: 4,
                                            orderList: orderProvider.returnList,
                                            callback: callback,
                                          ),
                                          OrderTypeButton(
                                            text: getTranslated(
                                                'failed', context),
                                            index: 5,
                                            orderList:
                                                orderProvider.canceledList,
                                            callback: callback,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 150,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context)
                                                  .primaryColor)))),

                          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),

                          Consumer<ProfileProvider>(
                            builder: (context, seller, child) => seller
                                        .userInfoModel !=
                                    null
                                ? SizedBox(
                                    height: 120,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        Container(
                                          width: 280,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_DEFAULT),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[
                                                      Provider.of<ThemeProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .darkTheme
                                                          ? 800
                                                          : 200],
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.3)
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  getTranslated(
                                                      'balance_withdraw',
                                                      context),
                                                  style: titilliumBold.copyWith(
                                                      color:
                                                          ColorResources.WHITE,
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_LARGE),
                                                  textAlign: TextAlign.start),
                                              Text(
                                                  PriceConverter.convertPrice(
                                                      context,
                                                      seller.userInfoModel
                                                                  .wallet !=
                                                              null
                                                          ? seller
                                                                  .userInfoModel
                                                                  .wallet
                                                                  .balance ??
                                                              0
                                                          : 0),
                                                  style: titilliumBold.copyWith(
                                                      color:
                                                          ColorResources.WHITE,
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_LARGE),
                                                  textAlign: TextAlign.start),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: InkWell(
                                                  onTap: () =>
                                                      showCupertinoModalPopup(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          builder: (_) =>
                                                              CustomEditDialog()),
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: ColorResources
                                                            .WHITE,
                                                      ),
                                                      child: Text(
                                                          getTranslated(
                                                              'withdraw',
                                                              context),
                                                          style: titilliumSemiBold.copyWith(
                                                              fontSize: Dimensions
                                                                  .PADDING_SIZE_DEFAULT,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor))),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 280,
                                          padding: EdgeInsets.all(
                                              Dimensions.PADDING_SIZE_DEFAULT),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          decoration: BoxDecoration(
                                            color: ColorResources.COLUMBIA_BLUE,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[
                                                      Provider.of<ThemeProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .darkTheme
                                                          ? 800
                                                          : 200],
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.3)
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  getTranslated(
                                                      'withdrawn', context),
                                                  style: titilliumBold.copyWith(
                                                      color:
                                                          ColorResources.WHITE,
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_LARGE),
                                                  textAlign: TextAlign.start),
                                              Text(
                                                  PriceConverter.convertPrice(
                                                      context,
                                                      seller.userInfoModel
                                                                  .wallet !=
                                                              null
                                                          ? seller.userInfoModel
                                                              .wallet.withdrawn
                                                              .toDouble()
                                                          : 0),
                                                  style: titilliumBold.copyWith(
                                                      color:
                                                          ColorResources.WHITE,
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_LARGE),
                                                  textAlign: TextAlign.start),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 280,
                                          padding: EdgeInsets.all(
                                              Dimensions.PADDING_SIZE_DEFAULT),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          decoration: BoxDecoration(
                                            color: ColorResources.SELLER_TXT,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[
                                                      Provider.of<ThemeProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .darkTheme
                                                          ? 800
                                                          : 200],
                                                  spreadRadius: 0.5,
                                                  blurRadius: 0.3)
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  getTranslated(
                                                      'total_earning', context),
                                                  style: titilliumBold.copyWith(
                                                      color:
                                                          ColorResources.WHITE,
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_LARGE),
                                                  textAlign: TextAlign.start),
                                              Text(
                                                  PriceConverter.convertPrice(
                                                      context,
                                                      seller.userInfoModel
                                                                  .wallet !=
                                                              null
                                                          ? seller
                                                                  .userInfoModel
                                                                  .wallet
                                                                  .balance +
                                                              seller
                                                                  .userInfoModel
                                                                  .wallet
                                                                  .withdrawn
                                                          : 0),
                                                  style: titilliumBold.copyWith(
                                                      color:
                                                          ColorResources.WHITE,
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_LARGE),
                                                  textAlign: TextAlign.start),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))
                                : Center(
                                    child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Theme.of(context).primaryColor))),
                          ),

                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Consumer<BankInfoProvider>(
                                builder: (context, bankInfo, child) {
                              List<double> _earnings = [];
                              for (double earn in bankInfo.userEarnings) {
                                _earnings.add(PriceConverter.convertAmount(
                                    earn, context));
                              }
                              List<double> _counts = [];
                              _counts.addAll(_earnings);
                              _counts.sort();
                              double _max = _counts[_counts.length - 1];
                              return EarningChart(
                                  earnings: _earnings, max: _max);
                            }),
                          ),

/*
                    Text(getTranslated('withdraw_request',  context), style: titilliumBold.copyWith(color: ColorResources.getTextColor(context),fontSize: Dimensions.PADDING_SIZE_DEFAULT)),

                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: ColorResources.getBottomSheetColor(context),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200], spreadRadius: 0.5, blurRadius: 0.3)],
                      ),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(getTranslated('amount',  context), style: titilliumBold.copyWith(color: ColorResources.getTextColor(context),fontSize: 14),),
                              TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    backgroundColor: ColorResources.RED
                                ),
                                onPressed: () =>  showCupertinoModalPopup(context: context, builder: (_) => CancelDialog()),
                                child: Text(getTranslated('cancel', context),
                                    style: titilliumRegular.copyWith(color: ColorResources.WHITE,fontSize: 12)),

                              ),
                            ],
                          ),

                          Text('${getTranslated('request_time', context)} :', style: titilliumRegular.copyWith(color: ColorResources.getSellerTxt(context),fontSize: Dimensions.FONT_SIZE_DEFAULT)),

                          Container(height: 0.5, margin: EdgeInsets.all(5), color: ColorResources.getHint(context),),

                          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                decoration: BoxDecoration(
                                  color: ColorResources.getFloatingBtn(context),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text('Pending', style: titilliumSemiBold),
                              ),
                            ],
                          )
                        ],
                      ),
                    )*/
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor)));
        },
      ),
    );
  }
}
