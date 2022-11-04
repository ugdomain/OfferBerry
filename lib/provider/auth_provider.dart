import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../data/model/response/base/api_response.dart';
import '../data/model/response/base/error_response.dart';
import '../data/model/response/response_model.dart';
import '../data/repository/auth_repo.dart';
import '../notification/PushNotifications.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo? authRepo;

  AuthProvider({@required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // for login section
  String _loginErrorMessage = '';

  String get loginErrorMessage => _loginErrorMessage;

  Future<ResponseModel> login({String? emailAddress, String? password}) async {
    _isLoading = true;
    _loginErrorMessage = '';
    notifyListeners();
    ApiResponse apiResponse =
        await authRepo!.login(emailAddress: emailAddress, password: password);
    _isLoading = false;
    notifyListeners();
    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      PushNotificationService(firebaseMessaging).updateDeviceToken();

      Map map = apiResponse.response!.data;
      String token = map["token"];
      authRepo!.saveUserToken(token);
      responseModel = ResponseModel(true, '');
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      _loginErrorMessage = errorMessage;
      responseModel = ResponseModel(false, errorMessage);
    }
    notifyListeners();
    return responseModel;
  }

  // for Remember Me Section
  bool _isActiveRememberMe = false;

  bool get isActiveRememberMe => _isActiveRememberMe;

  toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    notifyListeners();
  }

  bool isLoggedIn() {
    return authRepo!.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo!.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo!.saveUserNumberAndPassword(number, password);
  }

  String getUserEmail() {
    return authRepo!.getUserEmail() ?? "";
  }

  String getUserPassword() {
    return authRepo!.getUserPassword() ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo!.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authRepo!.getUserToken();
  }
}
