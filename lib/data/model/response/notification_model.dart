// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> welcomeFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String welcomeToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  NotificationModel({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  WelcomeData? data;
  dynamic readAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"],
        type: json["type"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        data: WelcomeData.NotificationModel(json["data"]),
        readAt: json["read_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "notifiable_type": notifiableType,
        "notifiable_id": notifiableId,
        "data": data!.toJson(),
        "read_at": readAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class WelcomeData {
  WelcomeData({
    this.data,
  });

  DataData? data;

  factory WelcomeData.NotificationModel(Map<String, dynamic> json) =>
      WelcomeData(
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class DataData {
  DataData({
    this.message,
    this.orderId,
    this.confirmationLink,
    this.webConfirmationLink,
    this.rejectionLink,
    this.webRejectionLink,
  });

  String? message;
  int? orderId;
  String? confirmationLink;
  String? webConfirmationLink;
  String? rejectionLink;
  String? webRejectionLink;

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        message: json["message"],
        orderId: json["order_id"],
        confirmationLink: json["confirmation_link"],
        webConfirmationLink: json["web_confirmation_link"],
        rejectionLink: json["rejection_link"],
        webRejectionLink: json["web_rejection_link"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "order_id": orderId,
        "confirmation_link": confirmationLink,
        "web_confirmation_link": webConfirmationLink,
        "rejection_link": rejectionLink,
        "web_rejection_link": webRejectionLink,
      };
}
