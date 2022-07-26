// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<OrderModel> welcomeFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String welcomeToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
    this.id,
    this.customerId,
    this.customerType,
    this.paymentStatus,
    this.orderStatus,
    this.paymentMethod,
    this.transactionRef,
    this.orderAmount,
    this.shippingAddress,
    this.createdAt,
    this.updatedAt,
    this.discountAmount,
    this.discountType,
    this.customer,
  });

  int id;
  int customerId;
  String customerType;
  String paymentStatus;
  String orderStatus;
  dynamic paymentMethod;
  dynamic transactionRef;
  int orderAmount;
  String shippingAddress;
  String createdAt;
  String updatedAt;
  int discountAmount;
  dynamic discountType;
  Customer customer;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        customerId: json["customer_id"],
        customerType: json["customer_type"],
        paymentStatus: json["payment_status"],
        orderStatus: json["order_status"],
        paymentMethod: json["payment_method"],
        transactionRef: json["transaction_ref"],
        orderAmount: json["order_amount"],
        shippingAddress: json["shipping_address"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        discountAmount: json["discount_amount"],
        discountType: json["discount_type"],
        customer: json["customer"] != null
            ? Customer.fromJson(json["customer"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "customer_type": customerType,
        "payment_status": paymentStatus,
        "order_status": orderStatus,
        "payment_method": paymentMethod,
        "transaction_ref": transactionRef,
        "order_amount": orderAmount,
        "shipping_address": shippingAddress,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "discount_amount": discountAmount,
        "discount_type": discountType,
        "customer": customer.toJson(),
      };
}

class Customer {
  Customer({
    this.id,
    this.name,
    this.fName,
    this.lName,
    this.phone,
    this.image,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.streetAddress,
    this.country,
    this.city,
    this.zip,
    this.houseNo,
    this.apartmentNo,
    this.cmFirebaseToken,
    this.lt,
    this.lg,
  });

  int id;
  dynamic name;
  String fName;
  String lName;
  String phone;
  String image;
  String email;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic streetAddress;
  dynamic country;
  dynamic city;
  dynamic zip;
  dynamic houseNo;
  dynamic apartmentNo;
  String cmFirebaseToken;
  String lt;
  String lg;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        fName: json["f_name"],
        lName: json["l_name"],
        phone: json["phone"],
        image: json["image"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        streetAddress: json["street_address"],
        country: json["country"],
        city: json["city"],
        zip: json["zip"],
        houseNo: json["house_no"],
        apartmentNo: json["apartment_no"],
        cmFirebaseToken: json["cm_firebase_token"],
        lt: json["lt"],
        lg: json["lg"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "f_name": fName,
        "l_name": lName,
        "phone": phone,
        "image": image,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "street_address": streetAddress,
        "country": country,
        "city": city,
        "zip": zip,
        "house_no": houseNo,
        "apartment_no": apartmentNo,
        "cm_firebase_token": cmFirebaseToken,
        "lt": lt,
        "lg": lg,
      };
}
