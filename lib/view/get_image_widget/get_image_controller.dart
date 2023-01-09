import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';

class ChooseImageController extends GetxController{
  final List images = [].obs;
  final picker = ImagePicker();
  final List listOfImages = [];

  final List jsonImages = [].obs;
  final List listOfJsonImages = [];

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if (pickedFile != null) {
        images.add(File(pickedFile.path));
        jsonImages.clear();
        for(var i in images) {
          Uint8List imageBytes = i.readAsBytesSync();
          var jsonImage = base64Encode(imageBytes);
          jsonImages.add("\"$jsonImage\"");
        }
    }
  }

  changeImage(int index)async{
    final pickedFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if(pickedFile != null){
      images[index] = File(pickedFile.path);
      List list = [];
      jsonImages.clear();
      for(var i in images) {
        Uint8List imageBytes = i.readAsBytesSync();
        var jsonImage = base64Encode(imageBytes);
        jsonImages.add("\"$jsonImage\"");
      }
    }
  }

  pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera,imageQuality: 80);
    if (pickedFile != null) {
        images.add(File(pickedFile.path));
        jsonImages.clear();
        for(var i in images){
          Uint8List imageBytes = i.readAsBytesSync();
          var jsonImage = base64Encode(imageBytes);
          jsonImages.add("\"$jsonImage\"");
        }
    }
  }

  addImagesToListOfImages(){
    listOfImages.add(List.from(images));
    listOfJsonImages.add(List.from(jsonImages));
    jsonImages.clear();
    images.clear();
  }
  editImagesInListOfImages(int index){
    if(images.isNotEmpty) {
      listOfImages[index] = List.from(images);
      listOfJsonImages[index] = List.from(jsonImages);
      images.clear();
      jsonImages.clear();
    }
  }

  addImagesToListOfJsonImages(){
    listOfJsonImages.add(List.from(jsonImages));
    jsonImages.clear();
  }
}