import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/sell/post_ad/widget/add_image_to_listview.dart';
import 'get_image_controller.dart';

class ListViewSelectionDrawer extends StatelessWidget {
  ListViewSelectionDrawer({
    Key? key,
    required this.index,
    required this.size,
  }) : super(key: key);

  final Size size;

  final int index;

  AddImageToListViewController imageCon =
      Get.put(AddImageToListViewController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      width: 400,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              imageCon.pickImageFromCamera(index);
              Get.back();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "CAMERA",
                  style: TextStyle(fontSize: 15),
                ),
                Icon(
                  Icons.camera_alt,
                  size: 30,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              imageCon.chooseImage(index);
              Get.back();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "GALLERY",
                  style: TextStyle(fontSize: 15),
                ),
                Icon(
                  Icons.folder_copy,
                  size: 30,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
