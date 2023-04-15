import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundredminute_seller/controllers/selling_method_controller.dart';
import 'package:hundredminute_seller/utill/images.dart';
import 'package:hundredminute_seller/view/screens/sell/category_screen.dart';

import 'auction/auction_screen.dart';

class ChooseSellingMethodScreen extends StatelessWidget {
  ChooseSellingMethodScreen({super.key});

  final SellingMethodController _sellingMethodController =
      Get.put(SellingMethodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Selling Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Images.mini_logo,
              fit: BoxFit.cover,
            ),
            Text(
              "WELCOME TO OFFER BARRY",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text("The trusted community of buyers and sellers"),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                _sellingMethodController.setWholeSale(false);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return CategoryScreen();
                    },
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.post_add),
                  Text("Post Ad"),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.sell_outlined),
                  Text("Sell Online"),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AuctionScreen();
                    },
                  ),
                );
                // bool isAppInstalled = await LaunchApp.isAppInstalled(
                //     androidPackageName:
                //         'com.khybercoded.hundredminute_seller.seller_app');
                // if (isAppInstalled) {
                //   LaunchApp.openApp(
                //     androidPackageName:
                //         "com.khybercoded.hundredminute_seller.seller_app",
                //   );
                // } else {
                //   await launchUrl(
                //     Uri.parse(
                //         "https://play.google.com/store/apps/details?id=com.ehsas.khybercoded.relax_player.Music_Player"),
                //     mode: LaunchMode.externalApplication,
                //   );
                // }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.gavel),
                  Text("Auction"),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () async {
                _sellingMethodController.setWholeSale(true);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return CategoryScreen();
                    },
                  ),
                );

                // await launchUrl(
                //   Uri.parse(
                //       "https://play.google.com/store/apps/details?id=com.ehsas.khybercoded.relax_player.Music_Player"),
                //   mode: LaunchMode.externalApplication,
                // );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.person),
                  Text("Whole Seller"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
