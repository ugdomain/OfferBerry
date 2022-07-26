import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hundredminute_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:hundredminute_seller/data/datasource/remote/exception/api_error_handler.dart';
import 'package:hundredminute_seller/data/model/response/base/api_response.dart';
import 'package:hundredminute_seller/data/model/response/restaurant_model.dart';
import 'package:hundredminute_seller/data/model/response/restaurant_view_model.dart';
import 'package:hundredminute_seller/utill/images.dart';

class RestaurantRepo {
  final DioClient dioClient;
  RestaurantRepo({@required this.dioClient});

  Future<ApiResponse> getRestaurant() async {
    try {
      List<RestaurantModel> _restaurant = [
        RestaurantModel(image: Images.restaurant_image, id: 1, resName: 'Parallax Restaurant',location: 'Real Madrid, Spain', rating: '4.6', distance: '25', time: '9:30 am to 11:00 pm',availableTimeStarts: '10:30:00', availableTimeEnds: '2:30:00',discount: '20', description: 'description'),
      ];
      final response = Response(requestOptions: RequestOptions(path: ''), data: _restaurant, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




  Future<ApiResponse> getPaymentView() async {
    try {
      List<RestaurantViewModel> _restaurantView = [
        RestaurantViewModel(id: 1, title: 'Pending Orders', item: 10 ),
        RestaurantViewModel(id: 2, title: 'Delivered', item: 7),
        RestaurantViewModel(id: 3, title: 'Return', item: 2),
        RestaurantViewModel(id: 4, title: 'Failed',item: 1),
      ];
      final response = Response(requestOptions: RequestOptions(path: ''), data: _restaurantView, statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}