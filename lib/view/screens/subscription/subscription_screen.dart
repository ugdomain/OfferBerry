import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hundredminute_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:hundredminute_seller/utill/app_constants.dart';
import 'package:hundredminute_seller/view/base/custom_app_bar.dart';
import 'package:hundredminute_seller/view/screens/subscription/save_file_mobile.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Subscription_Screen extends StatefulWidget {
  final bool isBacButtonExist;
  Subscription_Screen({this.isBacButtonExist = false});
  @override
  _Subscription_ScreenState createState() => _Subscription_ScreenState();
}

class _Subscription_ScreenState extends State<Subscription_Screen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Subscription"),
      body: Column(
        children: [
          Container(
            child: FutureBuilder<ReciptData>(
              future: getreciept(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Subscription Start Date:\t",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text("${snapshot.data.dataStart}"),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Date end: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text("${snapshot.data.dataEnd}"),
                            ],
                          ),
                          // Text("Date end: ${snapshot.data.dataEnd}"),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Price: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text("${snapshot.data.price}"),
                            ],
                          ),
                          // Text("Price: ${snapshot.data.price}"),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "plan duration: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                  "${snapshot.data.planDuration}\t${snapshot.data.planType}"),
                            ],
                          ),
                          // Text("plan duration: ${snapshot.data.planDuration}"),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "Plan Type: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              Text("${snapshot.data.planType}"),
                            ],
                          ),
                          // Text("Month: ${snapshot.data.planType}"),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                "Invoice Link: ",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              // Text("${snapshot.data.planType}"),
                            ],
                          ),
                          Text(" ${snapshot.data.invoiceDownloadLink}"),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                  // return Container(
                  //   child: Center(child: Text("No Data")),
                  // );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  // Future<String> downloadFile(String link) async {
  //   print('called');
  //
  //   DioClient dioClient;
  //   final sl = GetIt.instance;
  //   dioClient = sl();
  //
  //   try {
  //     Directory dir = await getTemporaryDirectory();
  //     String fullPath = dir.path + "/invoice.pdf'";
  //     print('full path ${fullPath}');
  //
  //     final response = await dioClient
  //         .get('api/v2/seller/user/invoice/in_1K55nuIQQvGjGutYfn1rx29R');
  //
  //     if (response.statusCode == 200) {
  //       // print(response.data);
  //       File file = File(fullPath);
  //       // var bytes = response.data;
  //       // print("response invoice");
  //       // print(bytes);
  //
  //       // await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice1.pdf');
  //
  //       var raf = file.openSync(mode: FileMode.write);
  //       // // response.data is List<int> type
  //       raf.writeFromSync(response.data);
  //
  //       await raf.close();
  //       // var bytes = await   dioClient.dio. consolidateHttpClientResponseBytes(response);
  //       // file = File(fullPath);
  //       // await file.writeAsBytes(bytes);
  //     } else {}
  //   } catch (ex) {
  //     print(ex);
  //   }
  // }

  Future<String> downloadFile(String url) async {
    Directory dir = await getTemporaryDirectory();
    String fullPath = dir.path + "/invoice.pdf'";
    print('full path ${fullPath}');

    HttpClient httpClient = new HttpClient();
    File file;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(AppConstants.TOKEN);

    // String filePath = '';
    // String myUrl = '';
    // var map = {
    //   'Content-Type': 'application/json; charset=UTF-8',
    //   'Authorization': 'Bearer $token'
    // };

    try {
      // myUrl = url+'/'+fileName;

      var request = await httpClient.getUrl(Uri.parse(
          "https://alhafizcloth.com/100min/api/v2/seller/user/invoice/in_1K55nuIQQvGjGutYfn1rx29R"));
      request.headers.add('Content-Type', 'application/json; charset=UTF-8');
      request.headers.add('Authorization', 'Bearer $token');
      var response = await request.close();
      if (response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        // filePath = '$dir/$fileName';
        file = File(fullPath);
        print(bytes.toString());
        if (Platform.isAndroid) {
          await file.writeAsBytes(bytes, mode: FileMode.write, flush: false);

          await FileSaveHelper.saveAndLaunchFile(bytes, 'Invoice1.pdf');
        }
      } else {}
    } catch (ex) {
      print("exception");
      print(ex);
    }
  }

  Future<ReciptData> getreciept() async {
    DioClient dioClient;
    final sl = GetIt.instance;
    dioClient = sl();
    final response = await dioClient.get('api/v2/seller/subscription-info');
    print("response reciept");
    print(response.data.toString());
    ReciptData reciptData = ReciptData.fromMap(response.data);
    print(reciptData.invoiceDownloadLink);
    downloadFile(reciptData.invoiceDownloadLink);
    return reciptData;
  }
}

// To parse this JSON data, do
//
//     final reciptData = reciptDataFromMap(jsonString);

ReciptData reciptDataFromMap(String str) =>
    ReciptData.fromMap(json.decode(str));

String reciptDataToMap(ReciptData data) => json.encode(data.toMap());

class ReciptData {
  ReciptData({
    @required this.dataEnd,
    @required this.dataStart,
    @required this.planType,
    @required this.planDuration,
    @required this.price,
    @required this.invoiceDownloadLink,
  });

  DateTime dataEnd;
  DateTime dataStart;
  String planType;
  int planDuration;
  int price;
  String invoiceDownloadLink;

  factory ReciptData.fromMap(Map<String, dynamic> json) => ReciptData(
        dataEnd: DateTime.parse(json["data_end"]),
        dataStart: DateTime.parse(json["data_start"]),
        planType: json["plan_type"],
        planDuration: json["plan_duration"],
        price: json["price"],
        invoiceDownloadLink: json["invoice_download_link"],
      );

  Map<String, dynamic> toMap() => {
        "data_end":
            "${dataEnd.year.toString().padLeft(4, '0')}-${dataEnd.month.toString().padLeft(2, '0')}-${dataEnd.day.toString().padLeft(2, '0')}",
        "data_start":
            "${dataStart.year.toString().padLeft(4, '0')}-${dataStart.month.toString().padLeft(2, '0')}-${dataStart.day.toString().padLeft(2, '0')}",
        "plan_type": planType,
        "plan_duration": planDuration,
        "price": price,
        "invoice_download_link": invoiceDownloadLink,
      };
}
