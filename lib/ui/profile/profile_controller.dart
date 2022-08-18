import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/MessageResponse.dart';
import 'package:chisco/data/data_class/UserDetail.dart';
import 'package:chisco/data/repository/account/account_repository.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileController extends ChangeNotifier {
  final BuildContext context;
  AccountRepositoryImpl accountRepositoryImpl = AccountRepositoryImpl();
  String selectedDate = '';

  bool isHintDate = true;

  ProfileController(this.context);

  UserDetail init() {
    UserDetail userDetail = Provider.of<AppController>(context).getUserDetail();
    selectedDate =
        userDetail.birthday.length == 0 ? '1377/09/25' : userDetail.birthday;
    return userDetail;
  }

  changeSelectedDate(String selectedDate) {
    this.selectedDate = selectedDate;
    print(selectedDate.toString());
    this.isHintDate = false;
    notifyListeners();
  }

  submitEditUserBtnClicked(
      String name, String? birthday, String? location) async {
    ChiscoResponse response = await accountRepositoryImpl.editUserInformation(
        location, birthday, name);

    if (!response.status) {
      print("Error Edit User");

      return;
    } else {
      MessageResponse messageResponse =
          MessageResponse.fromJson(response.object);
      //Show messageResponse To user;
      print(messageResponse.message);
      Navigator.pop(context);
    }
  }
}
