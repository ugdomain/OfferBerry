import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:hundredminute_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:hundredminute_seller/utill/app_constants.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;

  PushNotificationService(this._fcm);

  Future initialise() async {
    // if (Platform.isIOS) {
    //   _fcm.requestNotificationPermissions(IosNotificationSettings());
    // }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("notification listned");
      // RemoteNotification notification = message.notification;
      // AndroidNotification android = message.notification?.android;

      // if (notification != null && android != null) {
      //   flutterLocalNotificationsPlugin.show(
      //       notification.hashCode,
      //       notification.title,
      //       notification.body,
      //       NotificationDetails(
      //         android: AndroidNotificationDetails(
      //           channel.id,
      //           channel.name,
      //           channel.description,
      //           // TODO add a proper drawable resource to android, for now using
      //           //      one that already exists in example app.
      //           icon: 'launch_background',
      //         ),
      //       ));
      // }
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   // Navigator.pushNamed(context, '/message',
    //   //     arguments: MessageArguments(message, true));
    // });
    //
    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((value) => {print(value?.data)});

    // onMessage: When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage data: ${message.data}");
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp data: ${message.data}');
      // _serialiseAndNavigate(message);
    });
  }

  updateDeviceToken() async {
    String token = await _fcm.getToken();
    print("FirebaseMessaging token: $token");

    if (token != null) {
      DioClient dioClient;
      final sl = GetIt.instance;
      dioClient = sl();
      var map = {"cm-firebase-token": "$token"};
      final response = await dioClient.put(
        AppConstants.TOKEN_URI + "?cm_firebase_token=$token",
      );
      print(response.data.toString());

      if (response != null && response.statusCode == 200) {
        print(response.data.toString());
        print("Fcm Token saved");
      } else {
        // ApiChecker.checkApi(context, apiResponse);
      }

      // FirebaseFirestore.instance
      //     .collection(id == 1 ? "Sales" : 'Technicians')
      //     .doc(uid)
      //     .collection('token')
      //     .doc(token)
      //     .set({
      //   'token': token,
      //   'createdAt':
      //       DateTime.now().millisecondsSinceEpoch.toString(), // optional
      //   'platform': Platform.operatingSystem // optional
      // }).then((value) => print("Updated"));
    }
  }
}
