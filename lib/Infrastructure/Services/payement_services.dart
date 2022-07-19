import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/payement_Model.dart';


class PayementServices {
  ///Create Payement
  Future createPayment(PayementModel payementModel) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("PaymentsCollection").doc();
    return await docRef.set(payementModel.toJson(docRef.id));
  }

  ///Stream Payements
  Stream<List<PayementModel>> streamPaymenstHistory(String myId) {
    return FirebaseFirestore.instance
        .collection('PaymentsCollection')
        .where('ownerID', isEqualTo: myId)
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => PayementModel.fromJson(singleDoc.data()))
            .toList());
  }
}
