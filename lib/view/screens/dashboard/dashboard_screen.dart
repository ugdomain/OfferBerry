import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper/network_info.dart';
import '../../../localization/language_constrants.dart';
import '../../../notification/PushNotifications.dart';
import '../../../provider/notification_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/dimensions.dart';
import '../../../utill/styles.dart';
import '../addproduct/addproduct_screen.dart';
import '../home/home_screen.dart';
import '../menu/menu_screen.dart';
import '../notification/notification_screen.dart';
import '../order/order_screen.dart';

class DashboardScreen extends StatefulWidget {

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  List<Widget>? _screens;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    PushNotificationService(firebaseMessaging).initialise();

    Provider.of<NotificationProvider>(context, listen: false).getCounts();

    _screens = [
      HomeScreen(callback: () {
        setState(() {
          _setPage(1);
        });
      }),
      OrderScreen(),
      add_product(),
      NotificationScreen(),
    ];

    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: ColorResources.HINT_TEXT_COLOR,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _barItem(Icons.home, getTranslated('home', context), 0),
            _barItem(Icons.shopping_bag, getTranslated('my_order', context), 1),
            _barItem(
                Icons.add_box_sharp, getTranslated('add_product', context), 2),
            _barItem(Icons.menu, getTranslated('menu', context), 3),
            _barItem(Icons.notification_important,
                getTranslated('notification', context), 4),
          ],
          onTap: (int index) {
            if (index != 3) {
              setState(() {
                _setPage(index);
              });
            } else {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (con) => MenuBottomSheet());
            }
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens!.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens![index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon,
              color: index == _pageIndex
                  ? Theme.of(context).primaryColor
                  : ColorResources.HINT_TEXT_COLOR,
              size: 25),
          icon == Icons.notification_important
              ? Positioned(
                  top: -4,
                  right: -4,
                  child: CircleAvatar(
                      radius: 7,
                      backgroundColor: ColorResources.RED,
                      child: Consumer<NotificationProvider>(
                        builder: (context, value, child) {
                          return Text("${value.count}",
                              style: titilliumSemiBold.copyWith(
                                color: ColorResources.WHITE,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              ));
                        },
                      )),
                )
              : const Text("")
        ],
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
