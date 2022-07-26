import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hundredminute_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:hundredminute_seller/data/model/response/base/api_response.dart';
import 'package:hundredminute_seller/data/model/response/notification_model.dart';
import 'package:hundredminute_seller/data/repository/notification_repo.dart';
import 'package:hundredminute_seller/helper/api_checker.dart';
import 'package:hundredminute_seller/utill/app_constants.dart';

class NotificationProvider extends ChangeNotifier {
  final NotificationRepo notificationRepo;

  NotificationProvider({@required this.notificationRepo});

  List<NotificationModel> notificationList;

  int count = 0;

  // List<NotificationModel> get notificationList => _notificationList;

  DioClient dioClient;

  getCounts() async {
    final sl = GetIt.instance;
    dioClient = sl();
    Response response =
        await dioClient.get(AppConstants.NOTIFICATION_URI + "/count");
    print("counts: " + response.data.toString());
    count = response.data;
    notifyListeners();
  }

  Future<void> initNotificationList(BuildContext context) async {
    ApiResponse apiResponse = await notificationRepo.getNotificationList();
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      notificationList = [];

      notificationList = List<NotificationModel>.from(
          apiResponse.response.data.map((x) => NotificationModel.fromJson(x)));

      // List<NotificationModel> notificationModelFromMap =
      //     List<NotificationModel>.from(json
      //         .decode(apiResponse.response.data)
      //         .map((x) => NotificationModel.fromMap(x)));

      apiResponse.response.data.forEach((notification) =>
          notificationList.add(NotificationModel.fromJson(notification)));
      print(notificationList.length);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
  }
}
