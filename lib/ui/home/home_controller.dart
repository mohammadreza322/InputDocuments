import 'dart:ui';

import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/Cooler.dart';
import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/User.dart';
import 'package:chisco/data/data_class/UserDevices.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/data/repository/device/device_reposiory_impl.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeController extends ChangeNotifier {

  final DeviceRepositoryImpl deviceRepository = DeviceRepositoryImpl();
  final BuildContext context;
  HomeController(this.context);

  List<Cooler> _coolers = [];
  List<Power> _powers = [];
  List<String> _categories = [];
  List<Device> devices = [];
  List<Device> _listDevices = [];
  List<Device> _filteredDevices = [];

  User? user;

  bool isPageLoading = false;

  String selectedCategory = 'نمایش همه';


  init() {
    print("ok1");
    isPageLoading = true;
    user = Provider.of<AppController>(context).getUser();
    _coolers = user!.devices.coolers;
    _categories = user!.devices.categories;
    _categories.insert(0, 'نمایش همه');
    _powers = user!.devices.powers;
    convertDevices();
  }

  addCoolerBtnClicked(AddCooler cooler) async {
    ChiscoResponse response = await deviceRepository.addCooler(cooler);
    if (!response.status) {
      print("Error...........");
      return;
    } else {
      print(response.object.toString());
      AddDeviceResponse addDeviceResponse = response.object;
      _powers = addDeviceResponse.devices.powers;
      _coolers = addDeviceResponse.devices.coolers;
      _categories = addDeviceResponse.devices.categories;
      convertDevices();
      Navigator.pop(context);
    }
  }

  addPowerBtnClicked(AddPower power) async {
    ChiscoResponse response = await deviceRepository.addPower(power);
    if (!response.status) {
      print("Error From add power");
      return;
    }
    // bind response to all lists

    print(response.object.toString());
    Navigator.pop(context);
  }


  filteringDevices(String category) {
    print('Devices : ${_listDevices.toString()}');
    if (category == 'نمایش همه') {
      filteredDevices.clear();
      _filteredDevices.addAll(_listDevices);
      selectedCategory = category;
    } else {

      print('else');
      _filteredDevices = _listDevices.where((element) =>element.category == category).toList();
      print(filteredDevices.toString());
      selectedCategory = category;
      print(selectedCategory);
    }
    notifyListeners();
  }

  List<Cooler> get coolers => _coolers;

  List<Power> get powers => _powers;

  List<String> get categories => _categories;

  List<Device> get filteredDevices => _filteredDevices;

  get getListDevices => _listDevices;

  convertDevices() {
    _listDevices = List.from(_coolers)..addAll(_powers);
  }
}
