import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import  'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import 'get_image_controller.dart';
import 'selection_drawer.dart';

class ChooseImage extends StatelessWidget {
  ChooseImage({Key? key}) : super(key: key);

  ChooseImageController imageController = Get.put(ChooseImageController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 300,minHeight: 100,maxHeight: 300, maxWidth: 300),
        child: MasonryGridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          itemCount: imageController.images.length >= 5 ? 5 : imageController.images.length + 1,
          itemBuilder: (BuildContext context, index) {
            return index == imageController.images.length
                ? GestureDetector(
              onTap: () {
                Get.bottomSheet(SelectionDrawer(size: MediaQuery.of(context).size, index: index,));
              },
              child: Stack(children: [
                DottedBorder(
                  dashPattern: [8, 4],
                  color: Colors.grey,
                  child: ClipRRect(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.picture_in_picture,size: 40,
                          ),
                          Text("Choose Image"),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            )
                : GestureDetector(
              onTap: (){
                imageController.changeImage(index);
              },
                  child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(imageController.images[index]), fit: BoxFit.cover),
              ),
            ),
                );
          },
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
        ),
      ),
    );
  }
}