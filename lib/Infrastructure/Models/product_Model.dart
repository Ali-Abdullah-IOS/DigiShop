// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import 'package:digirental_shop_app/Infrastructure/Models/user_model.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) =>
    json.encode(data.toJson(data.productId.toString()));

class ProductModel {
  ProductModel({
    this.UserId,
    this.user,
    this.productId,
    this.categoryId,
    this.productName,
    this.productImage,
    this.productPrice,
    this.productquantity,
    this.productDesc,
    this.ShopID,
    this.isFavorite,
    this.favouriteCount,
  });

  String? UserId;
  UserModel? user;
  String? productId;
  String? categoryId;
  String? productName;
  String? productImage;
  num? productPrice;
  String? productquantity;
  String? productDesc;
  String? ShopID;
  bool? isFavorite;
  int? favouriteCount;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        UserId: json["UserId"],
        user: UserModel.fromJson(json["user"]),
        productId: json["productID"],
        categoryId: json["categoryID"],
        productName: json["productName"],
        productImage: json["productImage"],
        productPrice: json["productPrice"],
        productquantity: json["productquantity"],
        productDesc: json["productDesc"],
        ShopID: json["ShopID"],
        isFavorite: json["isFavorite"],
        favouriteCount: json["favouriteCount"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "UserId": UserId,
        "user": user!.toJson(docID),
        "productID": docID,
        "categoryID": categoryId,
        "productName": productName,
        "productImage": productImage,
        "productPrice": productPrice,
        "productquantity": productquantity,
        "productDesc": productDesc,
        "ShopID": ShopID,
        "isFavorite": isFavorite,
        "favouriteCount": favouriteCount,
      };
}
