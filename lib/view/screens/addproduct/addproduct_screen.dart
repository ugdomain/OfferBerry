import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/provider/category_provider.dart';
import 'package:hundredminute_seller/utill/styles.dart';
import 'package:hundredminute_seller/view/screens/addproduct/widget/chooseimage.dart';
import 'package:hundredminute_seller/view/screens/addproduct/widget/widgettextfield.dart';
import 'package:provider/provider.dart';

class add_product extends StatefulWidget {
  const add_product({Key key}) : super(key: key);

  @override
  State<add_product> createState() => _add_productState();
}

class _add_productState extends State<add_product> {
  TextEditingController uniprice = TextEditingController();
  TextEditingController purchaseprice = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController totalquantity = TextEditingController();

  int _selectedValue = 1;
  String selectCategory;
  List data = [];
  Future getCategories() async {
    var response = await http.get(
        Uri.parse(
            "https://bionicspharma.com/offer-barry/api/v2/seller/products/get-raw-categories"),
        headers: {"Accept": "application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    print(response.body.toString());

    setState(() {
      data = jsonData;
    });

    print(jsonData);

    return "success";
  }

  String selectsubcategory;
  List subCategorydata = [];
  Future getSubCategory(String id) async {
    var response = await http.get(
      Uri.parse(
          "https://bionicspharma.com/offer-barry/api/v2/seller/products/get-raw-sub-categories?id=$id"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);
    print(response.statusCode);
    print(response.body.toString());
    String a;
    selectsubcategory = a;
    setState(() {
      subCategorydata = jsonData;
    });
    print(jsonData);
    return "success";
  }

  @override
  void initState() {
    super.initState();
    getCategories();
    final getData = Provider.of<CategoryProvider>(context, listen: false);
    getData.apirequest();
    print("object$getData");
    // getSubCategory("id");
  }

  final _formKey = GlobalKey<FormState>();

  int ids = -1;
  List selectdata = List<String>.empty(growable: true);
  List radiotdata = List<String>.empty(growable: true);
//getapidata
  String _mySelection;

  _row(int index, name, field_type, id, field_data, hint) {
    field_type == "Condition" ? selectdata = field_data : selectdata;
    field_type == "Condition" ? radiotdata = field_data : radiotdata;
    if (field_type == "Condition") {
      print(field_type == "Condition");
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: InputDecorator(
            decoration: InputDecoration(
              labelText: name,
              focusColor: Colors.blue,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: Center(
                child: DropdownButton(
              style: TextStyle(color: Colors.black),
              // autofocus: true,
              isDense: true,
              hint: Text("$name"),
              items: selectdata.map((t) {
                return DropdownMenuItem(
                  child: Text("${t}"), //${t}
                  value: t,
                );
              }).toList(),
              value: _mySelection,
              onChanged: (value) {
                /*selectedName =
                    Map<Object, dynamic>.from(value).values.toList()[0];*/
                _mySelection.toString();

                setState(() {
                  _mySelection = value.toString();
                  print(_mySelection);
                });
              },
            ))),
      );
    } else if (name == 'input') {
      // print(field_type == "Condition");
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: new BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.black),
            ),
            labelStyle: TextStyle(),
          ),
          onChanged: (val) {},
        ),
      );
    } else {
      return Container(
        child: Text("hhh"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final getData = Provider.of<CategoryProvider>(context, listen: false);
    getData.apirequest();
    print("Use Provider");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        getTranslated("general_info", context),
                        style: heading,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Text(
                        getTranslated("category", context),
                        style: AddProductHeading,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                              color: Colors.black,
                              width: 0.5,
                            )),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectCategory,
                              onChanged: (String newValue) {
                                setState(() {
                                  selectCategory = newValue;
                                  getSubCategory(selectCategory);
                                  // Provider.of<TenantScheduleProvider>(context,listen: false).onchange("Tid", newValue);
                                });
                              },
                              items: data.map((value) {
                                return DropdownMenuItem(
                                  value: value["id"].toString(),
                                  child: Text(
                                    value["name"],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        getTranslated("sub_category", context),
                        style: AddProductHeading,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border:
                                Border.all(color: Colors.black, width: 0.5)),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: DropdownButton(
                              isExpanded: true,
                              value: selectsubcategory,
                              onChanged: (String newValue) {
                                setState(() {
                                  selectsubcategory = newValue;
                                });
                              },
                              items: subCategorydata.map((value) {
                                return DropdownMenuItem(
                                  value: value["id"].toString(),
                                  child: Text(
                                    value["name"].toString(),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<CategoryProvider>(
                  builder: (context, state, _) => FutureBuilder(
                    future: getData.apirequest(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          child: Text('error'),
                        );
                      }
                      if (snapshot.data != null) {
                        return Card(
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data['attrs'].length,
                              itemBuilder: (context, index) {
                                return _row(
                                  index,
                                  snapshot.data['attrs'][index]
                                      ["control"], //name
                                  snapshot.data['attrs'][index]["control_name"],
                                  snapshot.data['attrs'][index]
                                      ["control_options"],
                                  snapshot.data['attrs'][index]
                                      ["control_options"],
                                  snapshot.data['attrs'][index]["control_name"],
                                );
                              }),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                            child:
                                Container(child: CircularProgressIndicator())),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        getTranslated("product_price_stock", context),
                        style: heading,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Text(
                        getTranslated("unit_price", context),
                        style: AddProductHeading,
                      ),
                      addtextfield(
                        'username',
                        uniprice,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        getTranslated("purchase_price", context),
                        style: AddProductHeading,
                      ),
                      addtextfield('purchase price', purchaseprice),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        getTranslated("tax", context),
                        style: AddProductHeading,
                      ),
                      addtextfield('tax', tax),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  getTranslated("discount", context),
                                  style: AddProductHeading,
                                ),
                                addtextfield('discount', discount),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "",
                                style: AddProductHeading,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                        color: Colors.black, width: 0)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedValue = value as int;
                                      });
                                    },
                                    value: _selectedValue,
                                    items: const [
                                      DropdownMenuItem(
                                        value: 1,
                                        child: Text("Flat"),
                                      ),
                                      DropdownMenuItem(
                                        value: 2,
                                        child: Text("Percent"),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        getTranslated("total_quantity", context),
                        style: AddProductHeading,
                      ),
                      addtextfield('totalquantity', totalquantity),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        getTranslated("product_detail", context),
                        style: heading,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Container(
                          child: TextFormField(
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        getTranslated("upload_product_images", context),
                        style: heading,
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      chose_image(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
