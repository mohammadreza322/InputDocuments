import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/Cooler.dart';
import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/UserDetail.dart';
import 'package:chisco/data/data_class/UserDevices.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/data/data_class/User.dart';
import 'package:chisco/ui/home/home_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppController extends ChangeNotifier {
   User? _user;

  List<Cooler> _coolers = [];

  List<Power> _powers = [];

  List<String> _categories = [];


  List<Device> _userDevicesList =[];

  setData(User value) {
    _user = value;
    _categories = _user!.devices.categories;
    _coolers = _user!.devices.coolers;
    _powers = _user!.devices.powers;
    print("User Devices from App Controller : ${_user!.devices.toString()}");
    convertDeviceList();

    notifyListeners();
  }

  setUserDevices(UserDevices devices){
    _categories = devices.categories;
    _coolers = devices.coolers;
    _powers = devices.powers;
    notifyListeners();
  }

  UserDetail getUserDetail() {
    return _user!.userDetail;
  }

  List<Cooler> getCoolers() => _coolers;

  List<Power> getPowers() => _powers;

  User? getUser() => _user;

  get getCategories => _categories;

  isUserHaveDevice() {
    if (_coolers.length == 0 && _powers.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  convertDeviceList(){
    _userDevicesList = List.from(_powers)..addAll(_coolers);
    print("User Device List : ${_userDevicesList.toString()}");
  }



  refreshData(AddDeviceResponse response){
    _coolers = response.devices.coolers;
    _powers = response.devices.powers;
    _categories = response.devices.categories;
    notifyListeners();
  }

  get getUserDevicesList=>_userDevicesList;

}
