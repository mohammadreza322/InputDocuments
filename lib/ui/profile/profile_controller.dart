import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/MessageResponse.dart';
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
  String selectedCity = '';
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
    print(userDetail.address);
    nameController.text = userDetail.fullName;
    numberController.text = userDetail.phoneNumber;
    locationController.text = userDetail.address;
  //print(userDetail.birthday);
    if (userDetail.birthday != null) {
      int second = (userDetail.birthday as int)*1000;
      var date = DateTime.fromMillisecondsSinceEpoch(second);
      print(date.millisecondsSinceEpoch);
      changeSelectedDate(date);
    } else {
      selectedStringDate = 'ندارد';
    }
    selectedCity = userDetail.address;
    //jalali Birthday
  }

  changeSelectedDate(DateTime selectedDate) {
    Jalali jalali = Jalali.fromDateTime(selectedDate);
    selectedStringDate = jalali.formatCompactDate();
    print(selectedDate);
    selectedDateLong = selectedDate.millisecondsSinceEpoch;
    print(selectedDateLong);
    isHintDate = false;
    Future.delayed(const Duration(milliseconds: 250),() {
      notifyListeners();
    });
  }

  submitEditUserBtnClicked(
      String name, String? birthday, String? location) async {
    ChiscoResponse response = await accountRepositoryImpl.editUserInformation(location, selectedDateLong, name);

    if (response.status) {
      MessageResponse messageResponse = response.object;
      Provider.of<AppController>(context, listen: false).refreshUserData(name: name, date: selectedDateLong, location: location!);

      Navigator.pop(context);


      ChiscoFlushBar.showSuccessFlushBar(context, messageResponse.message);
    } else {
      print("Error Edit User");
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);
    }
  }
}
