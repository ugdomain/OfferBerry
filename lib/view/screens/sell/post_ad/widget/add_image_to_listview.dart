import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';

import '../../../../get_image_widget/get_image_controller.dart';

class AddImageToListViewController extends GetxController {
  final List images = [].obs;
  final picker = ImagePicker();
  final List jsonImages = [].obs;

  final isImageListUpdated = false.obs;

  final ChooseImageController chooseImg = Get.find();

  chooseImage(int index) async {
    print("index in image selection = $index");
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      images.add(File(pickedFile.path));
      chooseImg.jsonImages.clear();
      for (var i in images) {
        Uint8List imageBytes = i.readAsBytesSync();
        var jsonImage = base64Encode(imageBytes);
        chooseImg.jsonImages.add("\"$jsonImage\"");
      }
    }
    debugPrint("listOfImages => ${chooseImg.listOfImages}");
    addImagesToListOfImages(index);
  }

  changeImage(int index) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      images[index] = File(pickedFile.path);
      List list = [];
      chooseImg.jsonImages.clear();
      var idx = 0;
      for (var i in images) {
        Uint8List imageBytes = i.readAsBytesSync();
        var jsonImage = base64Encode(imageBytes);
        chooseImg.jsonImages.add("\"$jsonImage\"");
      }
    }
    addImagesToListOfImages(index);
  }

  pickImageFromCamera(int index) async {
    int indx = 0;
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (pickedFile != null) {
      images.add(File(pickedFile.path));
      chooseImg.jsonImages.clear();
      for (var i in images) {
        Uint8List imageBytes = i.readAsBytesSync();
        var jsonImage = base64Encode(imageBytes);
        chooseImg.jsonImages.add("\"$jsonImage\"");
      }
    }
    addImagesToListOfImages(index);
  }

  addImagesToListOfImages(int index) {
    if (chooseImg.listOfImages[index].length < 5) {
      chooseImg.listOfImages[index].insertAll(0, images);
      print("listOfImages ${chooseImg.listOfImages}");
      chooseImg.listOfJsonImages[index].insertAll(0, chooseImg.jsonImages);
      print("jsonImages => ${chooseImg.jsonImages}");
      chooseImg.jsonImages.clear();
      images.clear();
      isImageListUpdated(true);
    }
  }

  addImagesToListOfJsonImages(int index) {
    chooseImg.listOfJsonImages.add(List.from(jsonImages));
    jsonImages.clear();
  }
}
