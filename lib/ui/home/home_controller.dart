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


  List<String> _categories = [];
  List<Device> devices = [];
  List<Device> _listDevices = [];
  List<Device> _filteredDevices = [];
  int _coolerCount = 0;
  int _powerCount =0;

  User? user;

  bool isPageLoading = false;

  String selectedCategory = 'نمایش همه';

  /*refreshDevice(){
    User? u = Provider.of<AppController>(context).getUser();
    _listDevices = [
      ...u!.devices.powers,
      ...u.devices.coolers
    ];
  }*/
  List<String> get categories => _categories;

  List<Device> get filteredDevices => _filteredDevices;

  get getListDevices => _listDevices;

  get getCoolerCount =>_coolerCount;
  get getPowerCount =>_powerCount;


  init() {
    print("ok1");
    isPageLoading = true;
    AppController appController = Provider.of<AppController>(context);
    user = appController.getUser();


  }


  addCoolerBtnClicked(AddCooler cooler) async {
    ChiscoResponse response = await deviceRepository.addCooler(cooler);
    if (!response.status) {
      print("Error...........");
      return;
    } else {
      print(response.object.toString());
      AddDeviceResponse addDeviceResponse = response.object;

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



  homeList(){
    _coolerCount =Provider.of<AppController>(context).getCoolers().length;
    _powerCount = Provider.of<AppController>(context).getPowers().length;
    _listDevices = Provider.of<AppController>(context).getUserDevicesList;
    _categories = Provider.of<AppController>(context).getCategories;

    if(!_categories.contains('نمایش همه')) {
      _categories.insert(0, 'نمایش همه');
    }
    filteringDevices(selectedCategory);
  }

  isUserHaveDevice() {
    if (_listDevices.length ==0) {
      return false;
    } else {
      return true;
    }
  }
}
