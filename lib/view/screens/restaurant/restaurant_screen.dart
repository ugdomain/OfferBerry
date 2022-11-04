import 'package:flutter/material.dart';
import 'package:hundredminute_seller/view/screens/restaurant/restaurant_settings.dart';
import 'package:provider/provider.dart';
import '../../../data/model/response/restaurant_model.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/restaurant_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/styles.dart';
import '../../base/custom_app_bar.dart';
import '../../base/no_data_screen.dart';

class RestaurantScreen extends StatelessWidget {
  final RestaurantModel? restaurantModel;
  RestaurantScreen({this.restaurantModel});

  @override
  Widget build(BuildContext context) {

    Provider.of<RestaurantProvider>(context, listen: false).getRestaurant(context);
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('my_shop', context)),
      body: SafeArea(
          child: Consumer<RestaurantProvider>(
              builder: (context, resProvider, child) {
                return resProvider.restaurant !=null ? resProvider.restaurant.isNotEmpty ?
                 ListView.builder(
                  itemCount: resProvider.restaurant.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RestaurantSettingsScreen())),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                      margin: const EdgeInsets.all( Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      decoration: BoxDecoration(
                        color: ColorResources.getBottomSheetColor(context),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!, spreadRadius: 0.5, blurRadius: 0.3)],
                      ),
                      child: Column(
                        children: [
                          Row(children: [
                            Container(
                              height: 70,
                              width: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  resProvider.restaurant[index].image,
                                  height: 70,
                                  width: 85,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column( crossAxisAlignment: CrossAxisAlignment.start,children: [
                              Text('Name : ${resProvider.restaurant[index].resName}', style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_LARGE)),
                              Text('Phone :  ${'0123456789'}', style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_SMALL)),
                              Row(
                                children: [
                                  Text('Address : ', style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: 11)),
                                  Text( '3460, Pallet Street, New York', style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: 11)),
                                ],
                              ),
                            ],)
                          ],),
                        ],
                      ),
                    ),
                  ),
               )
                    : NoDataScreen()
                    : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)));

              })
      )
    );
  }
}
