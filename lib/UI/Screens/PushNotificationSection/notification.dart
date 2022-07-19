import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  ///Push 1-1 Notification
  Future pushOneToOneNotification({
    required String title,
    required String body,
    required String sendTo,
  }) async {
    print("I am sending to : $sendTo");
    return await http
        .post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "key=AAAA4llW5a8:APA91bHWIowsUCdwKufy6di0OBXS8WRcOnlFe-nkRr2j6gBFwuFBoguMay2LWH92baqTsb22dkek5jeAaizzqP5cWIc3tmBqpCD0Y5wj5VsOKIvx9KN2oydgpSnBqyO_N6scAFX7Py3h"
            },
            body: json.encode({
              "data": {"body": body, "title": title, "sound": "default"},
              "android": {"priority": "high"},
              "apns": {
                "payload": {
                  "aps": {"sound": "default"}
                }
              },
              "to": sendTo
            }))
        .then((value) => print(value.body));
  }

  //
  Future pushBroadCastNotification({
    required String title,
    required String body,
    required String department,
  }) async {
    String toParams = "/topics/" + department;
    return await http
        .post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "key=AAAARbr2UPs:APA91bHQMVw02J6HvR8T-FofXCrz0E6m-CAzDJPShYdfrcXgLaNWG5Jx9mU5J9aSCmeK9qT0dlK6GClyTI53nyZILrW155pB70dZWKI28PhMbiqaWVKL6IiIw7Kmq6nC_i5GjsBR3I6c"
            },
            body: json.encode({
              "data": {"body": body, "title": title, "sound": "default"},
              "android": {"priority": "high"},
              "content_available": true,
              "apn-priority": 5,
              "apns": {
                "payload": {
                  "aps": {"sound": "default"}
                }
              },
              "to": "$toParams"
            }))
        .then((value) {
      print("Body: ${value.body}");
      print(value.statusCode);
    }).catchError((e) {
      print(e.toString());
    });
  }

  ///Get One Specific User Token
  Stream<String> streamSpecificUserToken(String docID) {
    return FirebaseFirestore.instance
        .collection('deviceTokens')
        .doc(docID)
        .snapshots()
        .map((event) {
      return event.data()!['deviceTokens'];
    });
  }
}
