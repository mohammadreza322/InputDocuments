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
  late User _user;

  List<Cooler> _coolers = [];

  List<Power> _powers = [];

  List<String> _categories = [];

  setData(User value) async {
    _user = value;
    _categories = _user.devices.categories;
    _coolers = _user.devices.coolers;
    _powers = _user.devices.powers;

    print("User Devices from App Controller : ${_user.devices.toString()}");
  }

  UserDetail getUserDetail() {
    return _user.userDetail;
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
}
