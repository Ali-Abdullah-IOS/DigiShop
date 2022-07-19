// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

import 'package:digirental_shop_app/Infrastructure/Models/user_model.dart';

ReviewModel reviewModelFromJson(String str) =>
    ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) =>
    json.encode(data.toJson(data.docId.toString()));

class ReviewModel {
  ReviewModel({
    this.userId,
    this.ownerId,
    this.docId,
    this.user,
    this.experiencedesc,
    this.servicerating,
    this.recommedrating,
  });

  String? userId;
  String? ownerId;
  String? docId;
  UserModel? user;
  String? experiencedesc;
  num? servicerating;
  num? recommedrating;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        userId: json["userID"],
        ownerId: json["ownerID"],
        docId: json["docID"],
        user: UserModel.fromJson(json["user"]),
        experiencedesc: json["experiencedesc"],
        servicerating: json["servicerating"],
        recommedrating: json["recommedrating"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "userID": userId,
        "ownerID": ownerId,
        "docID": docID,
        "user": user!.toJson(docID),
        "experiencedesc": experiencedesc,
        "servicerating": servicerating,
        "recommedrating": recommedrating,
      };
}
