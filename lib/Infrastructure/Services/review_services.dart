import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/Review_Model.dart';

class ReviewServices {
  ///Create Review
  Future createReview(ReviewModel reviewModel) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("ReviewsCollection").doc();
    return await docRef.set(reviewModel.toJson(docRef.id));
  }

  ///Stream Reviews
  Stream<List<ReviewModel>> streamReviewstHistory(String myId) {
    return FirebaseFirestore.instance
        .collection('ReviewsCollection')
        .where('ownerID', isEqualTo: myId)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => ReviewModel.fromJson(singleDoc.data()))
            .toList());
  }
}
