import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/sub_category_attr_model.dart';
import '../models/sub_category_model.dart';
import '../services/configuration.dart';

class ProductServices {
  List<getRawCatgory> categoryList = [];
  var categoryJsonBody = [
    [
      {
        "id": 1,
        "name": "Motors",
        "slug": "motors",
        "icon": "2022-07-01-62be845495618.png",
        "parent_id": 0,
        "category": 1,
        "position": 0,
        "commission": "0",
        "created_at": "2022-06-30 22:21:24",
        "updated_at": "2022-06-30 22:21:24"
      }
    ]
  ];
  int _counter = 0;
  Future<List<getRawCatgory>?> getRawCategory() async {
    try {
      if (categoryList.isEmpty) {
        final client = http.Client();
        final response = await client.get(Uri.parse(Url().getRawCategoryurl));
        _counter++;
        print("Category Response $_counter: ${response.statusCode}");

        if (response.statusCode == 200) {
          _counter = 0;
          categoryList.clear();
          var body = jsonDecode(response.body.toString());
          for (List i in body) {
            for (Map<String, dynamic> j in i) {
              categoryList.add(getRawCatgory.fromJson(j));
            }
          }
          return categoryList;
        } else {
          return categoryList;
        }
      } else {
        return categoryList;
      }
    } catch (e) {
      _counter++;
      print("Category link Error $_counter: $e");
      return categoryList;
    } finally {
      //this is the hard coded section for category
      //start
      if (categoryList.isEmpty || categoryList.length == 1) {
        categoryList.clear();
        for (List i in categoryJsonBody) {
          for (Map<String, dynamic> j in i) {
            print(i);
            categoryList.add(getRawCatgory.fromJson(j));
          }
        }
        //end
        return categoryList;
      }
    }
  }

  // fetching sub category data
  List<SubCategoryModel> subCategoryList = [];
  int _subcounter = 0;

  Future<List<SubCategoryModel>?> getRawSubCategoryList(String? id) async {
    try {
      _subcounter++;
      final client = http.Client();
      final response =
          await client.get(Uri.parse(Url().getRawSubCategoryUrl(id!)));
      print("Sub Category Response $_subcounter : ${response.statusCode}");
      if (response.statusCode == 200) {
        _subcounter = 0;
        subCategoryList.clear();
        var body = jsonDecode(response.body);
        for (Map<String, dynamic> i in body) {
          subCategoryList.add(SubCategoryModel.fromJson(i));
        }
        return subCategoryList;
      } else {
        return subCategoryList;
      }
    } catch (e) {
      print("SubCategory link error : $e");
    }
    // finally{
    //   if(subCategoryList.isEmpty) {
    //     var subcategoryJsonBody = [{"id":13,"name":"Mobile","slug":"mobile","icon":null,"parent_id":int.parse(id!),"category":0,"position":1,"commission":0,"created_at":"2022-06-02 14:09:41","updated_at":"2022-06-02 14:09:41"},{"id":14,"name":"Laptop","slug":"laptop","icon":null,"parent_id":12,"category":0,"position":1,"commission":0,"created_at":"2022-06-02 14:09:53","updated_at":"2022-06-02 14:09:53"}];
    //     for (Map<String, dynamic> i in subcategoryJsonBody) {
    //     subCategoryList.add(getRawSubCategory.fromJson(i));
    //     }
    //     return subCategoryList;
    //   }
    // }
  }

  // fetching sub category attr data
  List<SubCategoryAttr> categoryAttrList = [];
  int _catAttrCounter = 0;

  Future<List<SubCategoryAttr>?> subCategoryAttr(
      String? catId, String? parentId) async {
    try {
      var response = await http
          .get(Uri.parse(Url().getRawSubCategoryAttrUrl(catId!, parentId!)));
      _catAttrCounter++;
      print(
          "SubCategoryAttr Response $_catAttrCounter : ${response.statusCode.toString()}");

      if (response.statusCode == 200) {
        _catAttrCounter = 0;
        categoryAttrList.clear();
        print("data is ${response.body}");
        Map<String, dynamic> data = json.decode(response.body.toString());
        print("test is $data");
        if (data.isNotEmpty) {
          categoryAttrList.add(SubCategoryAttr.fromJson(data));
        }
        return categoryAttrList;
      } else {
        return categoryAttrList;
      }
    } catch (e) {
      print("Sub Category Attr link error : $e");
      rethrow;
    }
    // finally{
    //   if(catId == "12" && parentId == "13") {
    //     var attrJsonBody = {"id":10,"cat_id":int.parse(catId!),"parent_id":int.parse(parentId!),"attrs":[{"control":"input","control_name":"Model","control_validation":"required"},{"control":"input","control_name":"Mfg","control_validation":"required"},{"control":"select","control_name":"Condition","control_options":["Excelent"," Good"," Poor"],"control_validation":"required"}]};
    //   categoryAttrList.add(SubCategoryAttr.fromJson(attrJsonBody));
    //   return categoryAttrList;}
    // }
  }
}
