
import 'package:flutter/cupertino.dart';

import '../../../Models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;

  void saveUserDetails(UserModel? userModel) {
    print("HI");
    print(userModel!.toJson('docID'));
    _userModel = userModel;
    notifyListeners();
  }

  UserModel? getUserDetails() => _userModel;
}