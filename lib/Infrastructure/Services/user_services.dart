import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../Models/user_model.dart';

class UserServices {
  ///Create User
  Future createUser(UserModel userModel) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("userCollection")
        .doc(userModel.userID);
    return await docRef.set(userModel.toJson(docRef.id));
  }

  ///Fetch User Record
  Stream<UserModel> fetchUserRecord(String userID) {
    return FirebaseFirestore.instance
        .collection("userCollection")
        .doc(userID)
        .snapshots()
        .map((userData) => UserModel.fromJson(userData.data()!));
  }

  ///update Shop Owner Balance
  Future<void> updateBalance(String UserId, num amount) {
    return FirebaseFirestore.instance
        .collection("userCollection")
        .doc(UserId)
        .update({"totalBalance": FieldValue.increment(amount)});
  }

  ///update Shop Owner Total Earning
  Future<void> updateTotalEarnings(String UserId, num amount) {
    return FirebaseFirestore.instance
        .collection("userCollection")
        .doc(UserId)
        .update({"totalEarning": FieldValue.increment(amount)});
  }
  ///update Shop Status to New Shop
  Future<void> updateShopStatustoNewShop(String UserId) {

    return FirebaseFirestore.instance
        .collection("userCollection")
        .doc(UserId)
        .update({"shopStatus": "New Shop"});
  }

  ///update Shop Status to level one
  Future<void> updateShopStatustoLeveOne(String UserId) {

    return FirebaseFirestore.instance
        .collection("userCollection")
        .doc(UserId)
        .update({"shopStatus": "Level One Shop"});
  }

  ///update Shop Status to level two
  Future<void> updateShopStatustoLevelTwo(String UserId) {

    return FirebaseFirestore.instance
        .collection("userCollection")
        .doc(UserId)
        .update({"shopStatus": "Level Two Shop"});
  }

  ///update Shop Status to Top Rated
  Future<void> updateShopStatustoTopRated(String UserId) {

    return FirebaseFirestore.instance
        .collection("userCollection")
        .doc(UserId)
        .update({"shopStatus": "Top Rated Shop"});
  }

  ///Update user record with Image

  Future updateUserDetailswithImage(UserModel userModel) async {
    return await FirebaseFirestore.instance
        .collection("userCollection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      //"firstName": userModel.firstName,
      // "userNumber": userModel.userNumber,
      "userImage": userModel.userImage,
    }, SetOptions(merge: true));
  }

  ///Update user record with Image

  Future updateUserDetailsWithoutImage(UserModel userModel) async {
    return await FirebaseFirestore.instance
        .collection("userCollection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "fullName": userModel.fullName,
      "PhoneNumber": userModel.PhoneNumber,
      // "userImage": userModel.userImage,
    }, SetOptions(merge: true));
  }
}
