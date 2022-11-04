import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../screens/addproduct/widget/add_image_to_listview.dart';
import 'listview_image_operation_drawer.dart';
class ShowListOfImages extends StatelessWidget {
  ShowListOfImages({
    Key? key, required this.listOfImages,required this.index
  }) : super(key: key);

  final List listOfImages;
  final int index;
  final AddImageToListViewController _updateListViewImageController =
  Get.put(AddImageToListViewController());

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 390,minHeight: 150,
          maxHeight: 400, maxWidth: 420),
      child: MasonryGridView.count(
        shrinkWrap: true,
        padding: const EdgeInsets.all(5),
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        itemCount:listOfImages[index].length ?? 0,
        itemBuilder: (c, i){
            return Obx(
                ()=>
                _updateListViewImageController.isImageListUpdated.value?
                    GestureDetector(
                onLongPress: (){
                  print("Images longPress action");
                  Get.bottomSheet(ListViewImageOperationSelectionDrawer(index: i,size: MediaQuery.of(context).size, listIndex: index,));
                },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: 60,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: const Border(top: BorderSide(),right: BorderSide(),left: BorderSide(),bottom: BorderSide()),
                        image: DecorationImage(
                          fit:BoxFit.cover,
                            image: FileImage(
                                listOfImages[index][i]))),)):
                GestureDetector(
                    onLongPress: (){
                      Get.bottomSheet(ListViewImageOperationSelectionDrawer(index: i,size: MediaQuery.of(context).size, listIndex: index,));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: 60,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: const Border(top: BorderSide(),right: BorderSide(),left: BorderSide(),bottom: BorderSide()),
                          image: DecorationImage(
                              fit:BoxFit.cover,
                              image: FileImage(
                                  listOfImages[index][i]))),)),
            );}
    ),
    );
  }
}