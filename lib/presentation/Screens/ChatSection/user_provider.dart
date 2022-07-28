
import 'package:digirental_shop_app/Infrastructure/Models/user_model.dart';
import 'package:flutter/cupertino.dart';



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