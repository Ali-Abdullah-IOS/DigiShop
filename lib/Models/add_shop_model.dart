// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

AddShopModel addShopModelFromJson(String str) =>
    AddShopModel.fromJson(json.decode(str));

String addShopModel(AddShopModel data) => json.encode(data.shopID.toString());

class AddShopModel {
  AddShopModel({
    this.shopID,
    this.shopName,
    this.shopImage,
    this.shopDescription,
    this.userID,
  });

  String? shopID;
  String? shopName;
  String? shopImage;
  String? shopDescription;
  String? userID;

  factory AddShopModel.fromJson(Map<String, dynamic> json) => AddShopModel(
        shopID: json["shopID"],
        shopName: json["shopName"],
        shopImage: json["shopImage"],
        shopDescription: json["shopDescription"],
        userID: json["userID"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "shopID": docID,
        "shopName": shopName,
        "shopImage": shopImage,
        "shopDescription": shopDescription,
        "userID": userID,
      };
}
