import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/MessageResponse.dart';
import 'package:chisco/data/data_class/UserDetail.dart';
import 'package:chisco/data/repository/account/account_repository.dart';
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
    nameController.text = userDetail.fullName;
    numberController.text = userDetail.phoneNumber;
    locationController.text = userDetail.address;
    selectedStringDate = userDetail.birthday.isEmpty ? '1377/09/25' : userDetail.birthday;
    //jalali Birthday
  }

  changeSelectedDate(DateTime selectedDate) {
    Jalali jalali = Jalali.fromDateTime(selectedDate);
    selectedStringDate = jalali.formatCompactDate();
    selectedDateLong = selectedDate.millisecondsSinceEpoch;
    isHintDate = false;
    notifyListeners();
  }

  submitEditUserBtnClicked(
      String name, String? birthday, String? location) async {
    ChiscoResponse response = await accountRepositoryImpl.editUserInformation(
        location, selectedDateLong, name);

    if (!response.status) {
      print("Error Edit User");
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);

      return;
    } else {

      MessageResponse messageResponse = response.object;

      ChiscoFlushBar.showSuccessFlushBar(context,messageResponse.message);
      Navigator.pop(context);
    }
  }
}
