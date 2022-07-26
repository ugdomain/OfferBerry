import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hundredminute_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:hundredminute_seller/data/model/response/order_model.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/provider/notification_provider.dart';
import 'package:hundredminute_seller/provider/order_provider.dart';
import 'package:hundredminute_seller/utill/app_constants.dart';
import 'package:hundredminute_seller/utill/color_resources.dart';
import 'package:hundredminute_seller/utill/dimensions.dart';
import 'package:hundredminute_seller/utill/styles.dart';
import 'package:hundredminute_seller/view/base/custom_app_bar.dart';
import 'package:hundredminute_seller/view/screens/order/order_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends StatelessWidget {
  final bool isBacButtonExist;
  NotificationScreen({this.isBacButtonExist = true});

  @override
  Widget build(BuildContext context) {
    Provider.of<NotificationProvider>(context, listen: false)
        .initNotificationList(context);

    return Scaffold(
      body: Column(children: [
        CustomAppBar(
            title: getTranslated('notification', context),
            isBackButtonExist: isBacButtonExist),
        Expanded(
          child: Consumer<NotificationProvider>(
            builder: (context, notification, child) {
              return notification.notificationList != null
                  ? notification.notificationList.length != 0
                      ? RefreshIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                          onRefresh: () async {
                            await Provider.of<NotificationProvider>(context,
                                    listen: false)
                                .initNotificationList(context);
                          },
                          child: ListView.builder(
                            itemCount:
                                Provider.of<NotificationProvider>(context)
                                    .notificationList
                                    .length,
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_SMALL),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  String nid =
                                      notification.notificationList[index].id;
                                  String oid = notification
                                      .notificationList[index].data.data.orderId
                                      .toString();

                                  print("mssgg ok next screen");

                                  print("oid: " + oid);
                                  getOrderModel(oid, nid, context);
                                  Provider.of<OrderProvider>(context,
                                          listen: false)
                                      .setIndex(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.PADDING_SIZE_SMALL),
                                  color: ColorResources.getGrey(context),
                                  child: ListTile(
                                    // leading: ClipOval(
                                    //     child: FadeInImage.assetNetwork(
                                    //   placeholder: Images.placeholder,
                                    //   image:
                                    //       '${Provider.of<SplashProvider>(context, listen: false).baseUrls.notificationImageUrl}/${notification.notificationList[index].id}',
                                    //   height: 50,
                                    //   width: 50,
                                    //   fit: BoxFit.cover,
                                    // )),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            notification.notificationList[index]
                                                .data.data.message
                                                .toString(),
                                            style: titilliumRegular.copyWith(
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL,
                                            )),
                                        RaisedButton(
                                          onPressed: () => callapi(notification
                                              .notificationList[index]
                                              .data
                                              .data
                                              .confirmationLink),
                                          child: Text("Accept"),
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat('hh:mm  dd/MM/yyyy')
                                              .format(notification
                                                  .notificationList[index]
                                                  .createdAt),
                                          style: titilliumRegular.copyWith(
                                              fontSize: Dimensions
                                                  .FONT_SIZE_EXTRA_SMALL,
                                              color: ColorResources.getHint(
                                                  context)),
                                        ),
                                        RaisedButton(
                                          onPressed: () => callapi(notification
                                              .notificationList[index]
                                              .data
                                              .data
                                              .rejectionLink)
                                          // Navigator.push(
                                          // context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             WebviewClass(notification
                                          //                 .notificationList[
                                          //                     index]
                                          //                 .data
                                          //                 .data
                                          //                 .rejectionLink)));
                                          ,
                                          child: Text("Reject"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Container()
                  : NotificationShimmer();
            },
          ),
        ),
      ]),
    );
  }

  getOrderModel(String oid, String nid, BuildContext context) async {
    int id = int.parse(oid);
    DioClient dioClient;
    final sl = GetIt.instance;
    dioClient = sl();

    final response = await dioClient.get(AppConstants.ORDER_DETAILS + oid);
    OrderModel orderModel;
    print(response.data.toString());
    if (response != null && response.statusCode == 200) {
      orderModel = OrderModel.fromJson(response.data);
      print(orderModel.customerId);
      print("nid: $nid");

      final response1 =
          await dioClient.get(AppConstants.NOTIFICATION_URI + "/$nid/unread");
      print("read ");
      print(response1.data.toString());
      // print("read ");
      // print(response1.data.toString());
      Provider.of<NotificationProvider>(context, listen: false).getCounts();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OrderDetailsScreen(orderModel: orderModel, orderId: id)));
    } else {
      // ApiChecker.checkApi(context, apiResponse);
    }
  }

  callapi(String url) async {
    DioClient dioClient;
    final sl = GetIt.instance;
    dioClient = sl();
    final response = await dioClient.get(url);
    print("response");
    print(response.data);
  }
}

class NotificationShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
          color: ColorResources.getGrey(context),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled:
                Provider.of<NotificationProvider>(context).notificationList ==
                    null,
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: ColorResources.WHITE),
              subtitle:
                  Container(height: 10, width: 50, color: ColorResources.WHITE),
            ),
          ),
        );
      },
    );
  }
}
