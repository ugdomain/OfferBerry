import 'package:flutter/material.dart';
import 'package:hundredminute_seller/data/model/response/base/api_response.dart';
import 'package:hundredminute_seller/data/model/response/restaurant_model.dart';
import 'package:hundredminute_seller/data/model/response/restaurant_view_model.dart';
import 'package:hundredminute_seller/data/repository/restaurant_repo.dart';
import 'package:hundredminute_seller/helper/api_checker.dart';

class RestaurantProvider extends ChangeNotifier {
  final RestaurantRepo restaurantRepo;

  RestaurantProvider({@required this.restaurantRepo});

  List<RestaurantModel> _restaurant;
  List<RestaurantModel> get restaurant => _restaurant;


  List<RestaurantViewModel> _restaurantViewList;
  List<RestaurantViewModel> get restaurantViewList => _restaurantViewList;


  Future<void> getRestaurant(BuildContext context) async {
    if(_restaurant == null ){
      ApiResponse apiResponse = await restaurantRepo.getRestaurant();
      if (apiResponse.response != null && apiResponse.response.statusCode == 200) {
        _restaurant = [];
        apiResponse.response.data.forEach((restaurant) => _restaurant.add(restaurant));
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }



  /*Future<void> getRestaurant(BuildContext context) async{
  ApiResponse apiResponse = await restaurantRepo.getRestaurant();
  if(apiResponse.response.statusCode==200){
    _restaurant=RestaurantModel.fromJson(apiResponse.response.data);
  }else{
    ApiChecker.checkApi(context, apiResponse);
  }
  notifyListeners();
}*/

}
