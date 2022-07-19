// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

CategoriesModel categoriesModelFromJson(String str) =>
    CategoriesModel.fromJson(json.decode(str));

String categoriesModelToJson(CategoriesModel data) =>
    json.encode(data.categoryId.toString());

class CategoriesModel {
  CategoriesModel({
    this.categoryId,
    this.shopId,
    this.categoryName,
    this.categoryImage,
  });

  String? categoryId;
  String? shopId;
  String? categoryName;
  String? categoryImage;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        categoryId: json["categoryID"],
        shopId: json["shopID"],
        categoryName: json["categoryName"],
        categoryImage: json["categoryImage"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "categoryID": docID,
        "shopID": shopId,
        "categoryName": categoryName,
        "categoryImage": categoryImage,
      };
}
