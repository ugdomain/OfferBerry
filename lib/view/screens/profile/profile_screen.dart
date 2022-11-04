import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../data/model/body/seller_body.dart';
import '../../../data/model/response/seller_info.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/bank_info_provider.dart';
import '../../../provider/profile_provider.dart';
import '../../../provider/splash_provider.dart';
import '../../../provider/theme_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/images.dart';
import '../../../utill/styles.dart';
import '../../base/custom_button.dart';
import '../../base/textfeild/custom_text_feild.dart';

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FocusNode _fNameFocus = FocusNode();
  final FocusNode _lNameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  File? file;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  void _choose() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _updateUserAccount() async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _firstNameController.text.trim();
    String _phoneNumber = _phoneController.text.trim();

    if (Provider.of<ProfileProvider>(context, listen: false)
                .userInfoModel!
                .fName ==
            _firstNameController.text &&
        Provider.of<ProfileProvider>(context, listen: false)
                .userInfoModel!
                .lName ==
            _lastNameController.text &&
        Provider.of<ProfileProvider>(context, listen: false)
                .userInfoModel!
                .phone ==
            _phoneController.text &&
        file == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Change something to update'),
          backgroundColor: ColorResources.RED));
    } else if (_firstName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('enter_first_name', context)),
          backgroundColor: ColorResources.RED));
    } else if (_lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('enter_first_name', context)),
          backgroundColor: ColorResources.RED));
    } else if (_phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('enter_phone_number', context)),
          backgroundColor: ColorResources.RED));
    } else {
      SellerModel updateUserInfoModel =
          Provider.of<ProfileProvider>(context, listen: false).userInfoModel!;
      updateUserInfoModel.fName = _firstNameController.text ?? "";
      updateUserInfoModel.lName = _lastNameController.text ?? "";
      updateUserInfoModel.phone = _phoneController.text ?? '';

      SellerModel _bank =
          Provider.of<BankInfoProvider>(context, listen: false).bankInfo;
      SellerBody _sellerBody = SellerBody(
        sMethod: '_put',
        fName: _firstNameController.text ?? "",
        lName: _lastNameController.text ?? "",
        image: updateUserInfoModel.image,
        bankName: _bank.bankName,
        branch: _bank.branch,
        holderName: _bank.holderName,
        accountNo: _bank.accountNo,
      );

      await Provider.of<ProfileProvider>(context, listen: false)
          .updateUserInfo(
        updateUserInfoModel,
        _sellerBody,
        file!,
        Provider.of<AuthProvider>(context, listen: false).getUserToken(),
      )
          .then((response) {
        if (response.isSuccess) {
          Provider.of<ProfileProvider>(context, listen: false)
              .getSellerInfo(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Updated Successfully'),
              backgroundColor: Colors.green));
          setState(() {});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response.message), backgroundColor: Colors.red));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Consumer<ProfileProvider>(
        builder: (context, profile, child) {
          _firstNameController.text = profile.userInfoModel!.fName!;
          _lastNameController.text = profile.userInfoModel!.lName!;
          _phoneController.text = profile.userInfoModel!.phone!;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                Images.toolbar_background,
                fit: BoxFit.fill,
                height: 500,
                color: Provider.of<ThemeProvider>(context).darkTheme
                    ? Colors.black
                    : null,
              ),
              Container(
                padding: const EdgeInsets.only(top: 35, left: 15),
                child: Row(children: [
                  CupertinoNavigationBarBackButton(
                    onPressed: () => Navigator.of(context).pop(),
                    color: ColorResources.getBottomSheetColor(context),
                  ),
                  const SizedBox(width: 10),
                  Text(getTranslated('my_profile', context),
                      style: titilliumRegular.copyWith(
                          fontSize: 20, color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ]),
              ),
              Container(
                padding: const EdgeInsets.only(top: 55),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            border: Border.all(color: Colors.white, width: 3),
                            shape: BoxShape.circle,
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: file == null
                                    ? FadeInImage.assetNetwork(
                                        placeholder: Images.placeholder_image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        image:
                                            '${Provider.of<SplashProvider>(context, listen: false).baseUrls.sellerImageUrl}/${profile.userInfoModel!.image}',
                                      )
                                    : Image.file(file!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill),
                              ),
                              Positioned(
                                bottom: 0,
                                right: -10,
                                child: CircleAvatar(
                                  backgroundColor:
                                      ColorResources.LIGHT_SKY_BLUE,
                                  radius: 14,
                                  child: IconButton(
                                    onPressed: _choose,
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(Icons.edit,
                                        color: ColorResources.WHITE, size: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${profile.userInfoModel!.fName} ${profile.userInfoModel!.lName}',
                          style: titilliumSemiBold.copyWith(
                              color: ColorResources.WHITE, fontSize: 20.0),
                        )
                      ],
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResources.getIconBg(context),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                              topRight: Radius.circular(
                                  Dimensions.PADDING_SIZE_DEFAULT),
                            )),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: Dimensions.PADDING_SIZE_DEFAULT,
                                  left: Dimensions.PADDING_SIZE_DEFAULT,
                                  right: Dimensions.PADDING_SIZE_DEFAULT),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person,
                                          color: ColorResources.getLightSkyBlue(
                                              context),
                                          size: 20),
                                      const SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text(getTranslated('first_name', context),
                                          style: titilliumRegular)
                                    ],
                                  ),
                                  const SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL),
                                  CustomTextField(
                                    textInputType: TextInputType.name,
                                    focusNode: _fNameFocus,
                                    nextNode: _lNameFocus,
                                    hintText: profile.userInfoModel!.fName ?? '',
                                    controller: _firstNameController,
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      Icon(Icons.person,
                                          color: ColorResources.getLightSkyBlue(
                                              context),
                                          size: 20),
                                      const SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text(getTranslated('last_name', context),
                                          style: titilliumRegular)
                                    ],
                                  ),
                                  const SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL),
                                  CustomTextField(
                                    textInputType: TextInputType.name,
                                    focusNode: _lNameFocus,
                                    nextNode: _phoneFocus,
                                    hintText: profile.userInfoModel!.lName,
                                    controller: _lastNameController,
                                  ),
                                ],
                              ),
                            ),

                            // for Phone No
                            Container(
                              margin: const EdgeInsets.only(
                                  top: Dimensions.PADDING_SIZE_DEFAULT,
                                  left: Dimensions.PADDING_SIZE_DEFAULT,
                                  right: Dimensions.PADDING_SIZE_DEFAULT),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.dialpad,
                                          color: ColorResources.getLightSkyBlue(
                                              context),
                                          size: 20),
                                      const SizedBox(
                                          width: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),
                                      Text(getTranslated('phone_no', context),
                                          style: titilliumRegular)
                                    ],
                                  ),
                                  const SizedBox(
                                      height: Dimensions.PADDING_SIZE_SMALL),
                                  CustomTextField(
                                    textInputType: TextInputType.number,
                                    focusNode: _phoneFocus,
                                    hintText: profile.userInfoModel!.phone ?? "",
                                    controller: _phoneController,
                                    isPhoneNumber: true,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_LARGE,
                          vertical: Dimensions.PADDING_SIZE_SMALL),
                      child: !Provider.of<ProfileProvider>(context).isLoading
                          ? CustomButton(
                              backgroundColor: ColorResources.WHITE,
                              onTap: _updateUserAccount,
                              btnTxt: getTranslated('update_profile', context))
                          : Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).primaryColor))),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
