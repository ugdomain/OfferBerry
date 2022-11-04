import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/addproduct/widget/add_image_to_listview.dart';
import 'get_image_controller.dart';


class ListViewImageOperationSelectionDrawer extends StatelessWidget {
  ListViewImageOperationSelectionDrawer({
    Key? key,
    required this.index,
    required this.size, required this.listIndex,
  }) : super(key: key);

  final int listIndex;

  final Size size;

  final int index;

  AddImageToListViewController imageCon = Get.put(AddImageToListViewController());
  final ChooseImageController chooseImg = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      width: 400,
      height: 100,
      child: Obx(
        ()=> imageCon
            .isImageListUpdated
            .value ?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){
                imageCon.changeImage(index);
                imageCon.isImageListUpdated(true);
                Get.back();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("CHANGE",style: TextStyle(fontSize: 15),),
                  Icon(Icons.change_circle_outlined,size: 30,),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                // imageCon.chooseImage(index);
                imageCon.isImageListUpdated(true);
                Get.back();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("EDIT",style: TextStyle(fontSize: 15),),
                  Icon(Icons.edit,size: 30,),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                chooseImg.listOfImages[listIndex].removeAt(index);
                chooseImg.listOfJsonImages[listIndex].removeAt(index);
                debugPrint("imageslist = ${chooseImg.listOfImages}");
                imageCon.isImageListUpdated(true);
                Get.back();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("REMOVE",style: TextStyle(fontSize: 15),),
                  Icon(Icons.delete,size: 30,),
                ],
              ),
            ),
          ],)
            :Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){
                // imageCon.pickImageFromCamera(index);
                Get.back();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("CHANGE",style: TextStyle(fontSize: 15),),
                  Icon(Icons.change_circle_outlined,size: 30,),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                // imageCon.chooseImage(index);
                Get.back();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("EDIT",style: TextStyle(fontSize: 15),),
                  Icon(Icons.edit,size: 30,),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
                // imageCon.chooseImage(index);
                chooseImg.listOfImages[listIndex].removeAt(index);
                chooseImg.listOfJsonImages[listIndex].removeAt(index);
                debugPrint("imageslist = ${chooseImg.listOfImages}");
                Get.back();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("REMOVE",style: TextStyle(fontSize: 15),),
                  Icon(Icons.delete,size: 30,),
                ],
              ),
            ),
          ],),
      ),
    );
  }
}
