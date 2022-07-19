import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/categoriesModel.dart';

class CategoryServices {
  ///Create Category
  Future createCategory(CategoriesModel addShopModel) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("CategoryCollection").doc();
    return await docRef.set(addShopModel.toJson(docRef.id));
  }

  ///Fetch Catgeories

  Stream<List<CategoriesModel>> streamCategories(String shopID) {
    return FirebaseFirestore.instance
        .collection('CategoryCollection')
        .where("shopID", isEqualTo: shopID)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => CategoriesModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///Delete Catgeory
  Future deleteCatgory(String categoryID) async {
    return await FirebaseFirestore.instance
        .collection('CategoryCollection')
        .doc(categoryID)
        .delete();
  }

  ///Update Category with Image

  Future updateCatgorywithImage(CategoriesModel addShopModel) async {
    return await FirebaseFirestore.instance
        .collection('CategoryCollection')
        .doc(addShopModel.categoryId)
        .update({
      'categoryImage': addShopModel.categoryImage,
      'categoryName': addShopModel.categoryName,
      "shopID": addShopModel.shopId
    });
  }

  ///Update shop withoutImage
  Future updateCategoryWithoutImage(CategoriesModel addShopModel) async {
    return await FirebaseFirestore.instance
        .collection('CategoryCollection')
        .doc(addShopModel.categoryId)
        .update({
      // 'shopImage': addShopModel.shopImage,
      'categoryName': addShopModel.categoryName,
      "shopID": addShopModel.shopId
    });
  }
}
