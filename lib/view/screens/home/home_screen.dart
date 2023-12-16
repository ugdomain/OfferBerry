import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundredminute_seller/controllers/selling_method_controller.dart';
import 'package:hundredminute_seller/view/screens/home/widget/bar_chart.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../controllers/category_controller.dart';
import '../../../controllers/static_fields_controller.dart';
import '../../../controllers/sub_category_attr_controller.dart';
import '../../../controllers/sub_category_controller.dart';
import '../../../excel_file/excel_page_controller.dart';
import '../../../helper/price_converter.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/bank_info_provider.dart';
import '../../../provider/order_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../base/custom_edit_dialog.dart';
import '../../get_image_widget/get_image_controller.dart';
import '../order/order_screen.dart';

class HomeScreen extends StatelessWidget {
  final Function? callback;
  HomeScreen({@required this.callback});

  final CategoryController _categoryController = Get.put(CategoryController());
  static final SellingMethodController sellingMethodController =
      Get.put(SellingMethodController());
  final SubCategoryController _subCategoryController =
      Get.put(SubCategoryController());
  final SubCategoryAttrController _attrController =
      Get.put(SubCategoryAttrController());
  final ExcelController _excelController = Get.put(ExcelController());
  final StaticFieldsController _fieldsController =
      Get.put(StaticFieldsController());
  final ChooseImageController imageCon = Get.put(ChooseImageController());

  Future<void> _loadData(BuildContext context, bool reload) async {
    await Provider.of<SplashProvider>(context, listen: false)
        .initConfig(context);
    Provider.of<SplashProvider>(context, listen: false).initSharedPrefData();
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
                    color: Theme.of(context).textTheme.bodyText1!.color)),
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

                          SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            // Chart title
                            title:
                                ChartTitle(text: 'Half yearly sales analysis'),
                            // Enable legend
                            legend: Legend(isVisible: true),
                            // Enable tooltip
                            tooltipBehavior: TooltipBehavior(enable: true),

                            series: <SplineAreaSeries<SalesData, String>>[
                              SplineAreaSeries<SalesData, String>(
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    Color.fromARGB(80, 9, 59, 167),
                                    Color(0xFF012168),
                                  ],
                                  stops: <double>[0.2, 0.7],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                                dataSource: <SalesData>[
                                  SalesData('Jan', 35),
                                  SalesData('Feb', 28),
                                  SalesData('Mar', 34),
                                  SalesData('Apr', 32),
                                  SalesData('May', 40)
                                ],
                                xValueMapper: (SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (SalesData sales, _) =>
                                    sales.sales,
                                // Enable data label
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true),
                                markerSettings: const MarkerSettings(
                                  isVisible: false,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),

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
                                          const SizedBox(width: 10),
                                          OrderTypeButton(
                                            text: getTranslated(
                                                'processing', context),
                                            index: 2,
                                            orderList: orderProvider.processing,
                                            callback: callback,
                                          ),
                                          const SizedBox(width: 10),
                                          OrderTypeButton(
                                            text: getTranslated(
                                                'delivered', context),
                                            index: 3,
                                            orderList:
                                                orderProvider.deliveredList,
                                            callback: callback,
                                          ),
                                          const SizedBox(width: 10),
                                          OrderTypeButton(
                                            text: getTranslated(
                                                'return', context),
                                            index: 4,
                                            orderList: orderProvider.returnList,
                                            callback: callback,
                                          ),
                                          const SizedBox(width: 10),
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

                          const SizedBox(
                              height: Dimensions.PADDING_SIZE_DEFAULT),

                          Consumer<ProfileProvider>(
                            builder: (context, seller, child) => seller
                                        .userInfoModel !=
                                    null
                                ? SizedBox(
                                    height: 120,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      children: [
                                        Container(
                                          width: 280,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_DEFAULT),
                                          margin: const EdgeInsets.symmetric(
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
                                                          : 200]!,
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
                                                      seller.userInfoModel!
                                                                  .wallet !=
                                                              null
                                                          ? double.parse(seller
                                                              .userInfoModel!
                                                              .wallet!
                                                              .balance
                                                              .toString())
                                                          : 0.0),
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
                                          padding: const EdgeInsets.all(
                                              Dimensions.PADDING_SIZE_DEFAULT),
                                          margin: const EdgeInsets.symmetric(
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
                                                          : 200]!,
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
                                                      seller.userInfoModel!
                                                                  .wallet !=
                                                              null
                                                          ? seller
                                                              .userInfoModel!
                                                              .wallet!
                                                              .withdrawn!
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
                                          padding: const EdgeInsets.all(
                                              Dimensions.PADDING_SIZE_DEFAULT),
                                          margin: const EdgeInsets.symmetric(
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
                                                          : 200]!,
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
                                                      seller.userInfoModel!
                                                                  .wallet !=
                                                              null
                                                          ? double.parse(seller
                                                                  .userInfoModel!
                                                                  .wallet!
                                                                  .balance!
                                                                  .toString()) +
                                                              seller
                                                                  .userInfoModel!
                                                                  .wallet!
                                                                  .withdrawn!
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
                            padding: const EdgeInsets.all(10),
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
                              },
                            ),
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

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
