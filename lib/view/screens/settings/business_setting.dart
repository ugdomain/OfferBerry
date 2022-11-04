import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../provider/business_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/styles.dart';
import '../../base/custom_app_bar.dart';
import '../../base/no_data_screen.dart';
import 'business_setting_details.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<BusinessProvider>(context, listen: false).getBusinessList(context);

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('business_settings', context)),
      body: SafeArea(
        child: Consumer<BusinessProvider>(
          builder: (context, businessProv, child) => Column(
            children: [

              businessProv.businessList !=null ? businessProv.businessList.isNotEmpty ? Expanded(
                  child: ListView.builder(
                    itemCount: businessProv.businessList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ShippingMethodScreen())),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
                        margin: const EdgeInsets.all( Dimensions.PADDING_SIZE_DEFAULT),
                        decoration: BoxDecoration(
                          color: ColorResources.getBottomSheetColor(context),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 800 : 200]!, spreadRadius: 0.5, blurRadius: 0.3)],
                        ),
                        child: Column(
                          children: [
                            Row(children: [
                              Column( crossAxisAlignment: CrossAxisAlignment.start,children: [
                                Text('Title : ${businessProv.businessList[index].title}', style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_LARGE)),
                                Text('Duration : ${businessProv.businessList[index].duration}days', style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: Dimensions.FONT_SIZE_SMALL)),
                                Row(
                                  children: [
                                    Text('Cost: \$${businessProv.businessList[index].cost}', style: titilliumBold.copyWith(color: ColorResources.getTextColor(context), fontSize: 11)),
                                  ],
                                ),
                              ],)
                            ],),
                          ],
                        ),
                      ),
                    ),
                  ))
                  : NoDataScreen()
                  : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)))
            ],
          ),
        ),
      ),
    );
  }
}
