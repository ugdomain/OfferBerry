import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundredminute_seller/controllers/category_controller.dart';
import 'package:hundredminute_seller/controllers/sub_category_controller.dart';
import 'package:hundredminute_seller/view/screens/sell/sub_category_screen.dart';

import '../../../controllers/sub_category_attr_controller.dart';
import '../../../utill/app_constants.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({
    super.key,
  });

  final CategoryController _categoryController = Get.find();
  final SubCategoryController _subCategoryController = Get.find();
  final SubCategoryAttrController _attrController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        child: GridView.builder(
          itemCount: _categoryController.categoryList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            final category = _categoryController.categoryList[index];
            return GestureDetector(
              onTap: () {
                _subCategoryController.subCategoryList.clear();
                _attrController.attrList.clear();
                _categoryController.setSelected(category.name!.toString());
                _subCategoryController.subCategoryValue("null");
                _categoryController.setSelectedCategory(category.id.toString());
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return SubCategoryScreen();
                  },
                ));
              },
              child: Card(
                elevation: 5,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        "${AppConstants.BASE_URL + AppConstants.ICON_URL}${category.icon}",
                        // height: 100,
                        // width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        width: double.infinity,
                        height: 25,
                        alignment: Alignment.center,
                        child: FittedBox(
                          child: Text(
                            category.name ?? "",
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
