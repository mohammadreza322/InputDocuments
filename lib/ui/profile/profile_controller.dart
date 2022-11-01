import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/EditUserResponse.dart';
import 'package:chisco/data/data_class/MessageResponse.dart';
import 'package:chisco/data/data_class/User.dart';
import 'package:chisco/data/data_class/UserDetail.dart';
import 'package:chisco/data/repository/account/account_repository.dart';
import 'package:chisco/ui/account/account_controller.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/chisco_flush_bar.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

class ProfileController extends ChangeNotifier {
  final BuildContext context;
  AccountRepositoryImpl accountRepositoryImpl = AccountRepositoryImpl();
  String selectedStringDate = '';
  int selectedDateLong = 0;
  bool isHintDate = true;
  bool isPageLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  ProfileController(this.context);

  init() {
    isPageLoading = true;
    UserDetail userDetail = Provider.of<AppController>(context).getUserDetail();
    print('Birthday AppController');
    print(Provider.of<AppController>(context).getUserDetail().birthday);
    nameController.text = userDetail.fullName;
    numberController.text = userDetail.phoneNumber;
    locationController.text = userDetail.address;
    AppController appController = Provider.of<AppController>(context);
    appController.setContext(context);
    if (userDetail.birthday != null) {
      print('BirthDay in if ${userDetail.birthday}');
      int second = (userDetail.birthday as int) * 1000;
      var date = DateTime.fromMillisecondsSinceEpoch(second);
      print(date.millisecondsSinceEpoch);
      changeSelectedDate(date);
    } else {
      selectedStringDate = 'ندارد';
    }
    //jalali Birthday
  }

  changeSelectedDate(DateTime selectedDate) {
    Jalali jalali = Jalali.fromDateTime(selectedDate);
    selectedStringDate = jalali.formatCompactDate();
    print(selectedDate);
    selectedDateLong = selectedDate.millisecondsSinceEpoch;
    print(selectedDateLong);
    isHintDate = false;
    Future.delayed(const Duration(milliseconds: 250), () {
      notifyListeners();
    });
  }

  submitEditUserBtnClicked(
      String name, String? birthday, String? location) async {
    ChiscoResponse response = await accountRepositoryImpl.editUserInformation(
        location, selectedDateLong, name);
    print('OnClick Long : ${selectedDateLong}');
    if (response.status) {
      print(response.object);
      EditUserResponse editUserResponse = response.object;

      Provider.of<AppController>(context, listen: false).refreshUserData(
          name: editUserResponse.details.fullName,
          date: editUserResponse.details.birthday,
          location: editUserResponse.details.address);
      Navigator.pop(context);
      ChiscoFlushBar.showSuccessFlushBar(context, editUserResponse.message);
    } else {
      print("Error Edit User");
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);
    }
  }
}
