import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/product_Model.dart';

class ProductServices {
  ///Create Product
  Future createProduct(ProductModel productModel) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("ProductsCollection").doc();
    return await docRef.set(productModel.toJson(docRef.id));
  }

  ///Fetch Products

  Stream<List<ProductModel>> streamProducts(String categoryID) {
    return FirebaseFirestore.instance
        .collection('ProductsCollection')
        .where("categoryID", isEqualTo: categoryID)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => ProductModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///Fetch All Products

  Stream<List<ProductModel>> streamAllProducts() {
    return FirebaseFirestore.instance
        .collection('ProductsCollection')
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => ProductModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///STream only my shop products

  Stream<List<ProductModel>> streamOnlyProducts(String myId) {
    return FirebaseFirestore.instance
        .collection('ProductsCollection')
        .where("UserId", isEqualTo: myId)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => ProductModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///Delete Product
  Future deleteProduct(String productID) async {
    return await FirebaseFirestore.instance
        .collection('ProductsCollection')
        .doc(productID)
        .delete();
  }

  ///Update Product with Image

  Future updateProductwithImage(ProductModel productModel) async {
    return await FirebaseFirestore.instance
        .collection('ProductsCollection')
        .doc(productModel.productId)
        .update({
      'productName': productModel.productName,
      'productPrice': productModel.productPrice,
      "categoryID": productModel.categoryId,
      "productDesc": productModel.productDesc,
      "productquantity": productModel.productquantity,
      "productImage": productModel.productImage
    });
  }

  ///Update Product withoutImage
  Future updateProductWithoutImage(ProductModel productModel) async {
    return await FirebaseFirestore.instance
        .collection('ProductsCollection')
        .doc(productModel.productId)
        .update({
      'productName': productModel.productName,
      'productPrice': productModel.productPrice,
      "categoryID": productModel.categoryId,
      "productDesc": productModel.productDesc,
      "productquantity": productModel.productquantity,
    });
  }
}
