// To parse this JSON data, do
//
//     final payementModel = payementModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digirental_shop_app/Infrastructure/Models/user_model.dart';

PayementModel payementModelFromJson(String str) =>
    PayementModel.fromJson(json.decode(str));

String payementModelToJson(PayementModel data) =>
    json.encode(data.toJson(data.paymentID.toString()));

class PayementModel {
  PayementModel(
      {this.userId,
      this.user,
      this.ownerID,
      this.ownerName,
      this.ownerImage,
      this.paymentID,
      this.payementAmount,
      this.payementDate

      //   this.paymentDate,
      });

  String? userId;
  UserModel? user;
  String? ownerID;
  String? ownerName;
  String? ownerImage;
  String? paymentID;
  num? payementAmount;
  Timestamp? payementDate;

  // Timestamp? paymentDate;

  factory PayementModel.fromJson(Map<String, dynamic> json) => PayementModel(
        userId: json["userID"],
        user: UserModel.fromJson(json["user"]),
        ownerID: json["ownerID"],
        ownerName: json["ownerName"],
        ownerImage: json["ownerImage"],

        paymentID: json["paymentID"],
        payementAmount: json["PayementAmount"],
        payementDate: json["payementDate"],
        //  paymentDate: json["paymentDate"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "userID": userId,
        "user": user!.toJson(docID),
        "ownerID": ownerID,
        "ownerName": ownerName,
        "ownerImage": ownerImage,
        "paymentID": docID,
        "PayementAmount": payementAmount,
        "payementDate": payementDate,
        // "paymentDate": paymentDate,
      };
}
