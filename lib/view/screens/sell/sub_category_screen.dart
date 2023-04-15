import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hundredminute_seller/controllers/sub_category_controller.dart';
import 'package:hundredminute_seller/view/screens/home/home_screen.dart';
import 'package:hundredminute_seller/view/screens/sell/post_ad/addproduct_screen.dart';
import '../../../controllers/category_controller.dart';
import '../../../controllers/selling_method_controller.dart';
import '../../../controllers/sub_category_attr_controller.dart';

class SubCategoryScreen extends StatelessWidget {
  SubCategoryScreen({
    super.key,
  });

  final SubCategoryController _subCategoryController = Get.find();
  final CategoryController _categoryController = Get.find();
  final SubCategoryAttrController _attrController = Get.find();
  final SellingMethodController _sellingMethodController =
      Get.find<SellingMethodController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryController.categoryValue.value),
      ),
      body: FutureBuilder(
          future: _subCategoryController
              .fetchSubCategory(_categoryController.categoryId.value),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: GridView.builder(
                    itemCount: _subCategoryController.subCategoryList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 1,
                      childAspectRatio: 1.3,
                    ),
                    itemBuilder: (context, index) {
                      final category =
                          _subCategoryController.subCategoryList[index];
                      return GestureDetector(
                        onTap: () async {
                          if (HomeScreen.sellingMethodController.isWholeSale) {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Product Type"),
                                  content: Text("Select Product Type"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        _sellingMethodController
                                            .isProductNew(true);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("New"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _sellingMethodController
                                            .isProductNew(false);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Existing"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          _subCategoryController
                              .setSelectedValue(category.name?.toString());
                          _attrController.attrList.clear();
                          _subCategoryController.setSubCategoryId(
                              category.id.toString(),
                              _categoryController.categoryId.toString());
                          _subCategoryController
                              .setSelectedValue(category.name.toString());
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return AddProduct();
                              },
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(category.name!),
                          ),

                          /* ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            "${AppConstants.BASE_URL + AppConstants.ICON_URL}${category.icon}",
                            // height: 100,
                            // width: 100,
                            fit: BoxFit.cover,
                          ),
                        ), */
                          /* Align(
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
                        ), */
                        ),
                      );
                    },
                  ),
                );
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          }),
    );
  }
}
