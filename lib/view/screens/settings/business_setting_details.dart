import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/provider/auth_provider.dart';
import 'package:hundredminute_seller/utill/color_resources.dart';
import 'package:hundredminute_seller/utill/dimensions.dart';
import 'package:hundredminute_seller/utill/styles.dart';
import 'package:hundredminute_seller/view/base/custom_app_bar.dart';
import 'package:hundredminute_seller/view/base/custom_button.dart';
import 'package:hundredminute_seller/view/base/textfeild/custom_text_feild.dart';
import 'package:hundredminute_seller/view/screens/settings/business_setting.dart';

class ShippingMethodScreen extends StatefulWidget {
  @override
  _ShippingMethodScreenState createState() => _ShippingMethodScreenState();
}

class _ShippingMethodScreenState extends State<ShippingMethodScreen> {

  TextEditingController _titleController ;
  TextEditingController _durationController ;
  TextEditingController _costController ;

  final FocusNode _resNameNode = FocusNode();
  final FocusNode _addressNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  GlobalKey<FormState> _formKeyLogin;


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _durationController = TextEditingController();
    _costController = TextEditingController();

    _titleController.text = 'Burger';
    _durationController.text = '2-5';
    _costController.text = '100';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _costController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(title: getTranslated('shipping_method', context)),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) => Form(
            key: _formKeyLogin,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [

                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Text(
                    getTranslated('title', context),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.PADDING_SIZE_DEFAULT, color: ColorResources.getHintColor(context),)),

                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                CustomTextField(
                  hintText: getTranslated('title', context),
                  focusNode: _resNameNode,
                  nextNode: _addressNode,
                  controller: _titleController,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                Text(
                    getTranslated('duration', context),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.PADDING_SIZE_DEFAULT, color: ColorResources.getHintColor(context),)),

                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                CustomTextField(
                  hintText: '4-6 days',
                  focusNode: _addressNode,
                  controller: _durationController,
                  textInputType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                ),

                SizedBox(height: 22),
                Text(
                    getTranslated('cost', context),
                    style: titilliumRegular.copyWith(fontSize: Dimensions.PADDING_SIZE_DEFAULT, color: ColorResources.getHintColor(context),)),

                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                CustomTextField(
                  hintText: '\$100',
                  controller: _costController,
                  focusNode: _phoneNode,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                ),

                // for login button
                SizedBox(height: 50),
                CustomButton(
                  btnTxt: getTranslated('save', context),
                  backgroundColor: ColorResources.WHITE,
                  onTap: ()  {
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => BusinessScreen()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
