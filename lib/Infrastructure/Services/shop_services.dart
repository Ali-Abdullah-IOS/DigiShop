import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';


import '../Helpers/helper.dart';
import '../Models/add_shop_model.dart';
import '../Models/user_model.dart';

class AddShopServices {
  ///Create Shop
  Future createShop(AddShopModel addShopModel) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("ShopCollection").doc();
    return await docRef.set(addShopModel.toJson(docRef.id));
  }

  ///Fetch Shops

  Stream<List<AddShopModel>> streamShops() {
    return FirebaseFirestore.instance
        .collection('ShopCollection')
        .where("userID", isEqualTo: getUserID())
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => AddShopModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///Delete Shop
  Future deleteshop(String shopID) async {
    return await FirebaseFirestore.instance
        .collection('ShopCollection')
        .doc(shopID)
        .delete();
  }

  ///Update SHop with Image

  Future updateshopwithImage(AddShopModel addShopModel) async {
    return await FirebaseFirestore.instance
        .collection('ShopCollection')
        .doc(addShopModel.shopID)
        .update({
      'shopImage': addShopModel.shopImage,
      'shopName': addShopModel.shopName,
      'shopDescription': addShopModel.shopDescription
    });
  }

  ///Update shop withoutImage
  Future updateShopWithoutImage(AddShopModel addShopModel) async {
    return await FirebaseFirestore.instance
        .collection('ShopCollection')
        .doc(addShopModel.shopID)
        .update({
      // 'shopImage': addShopModel.shopImage,
      'shopName': addShopModel.shopName,
      'shopDescription': addShopModel.shopDescription
    });
  }
}
