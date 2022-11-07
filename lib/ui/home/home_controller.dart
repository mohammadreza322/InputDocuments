import 'dart:async';
import 'dart:ui';

import 'package:chisco/data/data_class/AddCoolerRequest.dart';
import 'package:chisco/data/data_class/AddDeviceResponse.dart';
import 'package:chisco/data/data_class/AddPowerRequest.dart';
import 'package:chisco/data/data_class/ChiscoResponse.dart';
import 'package:chisco/data/data_class/Connector.dart';
import 'package:chisco/data/data_class/Cooler.dart';
import 'package:chisco/data/data_class/Device.dart';
import 'package:chisco/data/data_class/User.dart';
import 'package:chisco/data/data_class/UserDevices.dart';
import 'package:chisco/data/data_class/Power.dart';
import 'package:chisco/data/repository/device/device_reposiory_impl.dart';
import 'package:chisco/ui/devices/power/power_screen_controller.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:chisco/utils/chisco_flush_bar.dart';
import 'package:chisco/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ChangeNotifier {
  final DeviceRepositoryImpl deviceRepository = DeviceRepositoryImpl();
  final BuildContext context;
  HomeController(this.context);
  List<String> _categories = [];
  List<Device> devices = [];
  List<Device> _listDevices = [];
  List<Device> _filteredDevices = [];
  int _coolerCount = 0;
  int _powerCount = 0;

  User? user;

  bool isPageLoading = false;

  late bool isDeviceActive;

  String selectedCategory = 'نمایش همه';

  List<String> get categories => _categories;

  List<Device> get filteredDevices => _filteredDevices;

  get getListDevices => _listDevices;

  get getCoolerCount => _coolerCount;

  get getPowerCount => _powerCount;

  init() async{
    ///[init] is called only one time when is opened
    isPageLoading = true;
    AppController appController = Provider.of<AppController>(context,listen: false);
    appController.setContext(context);
    user = appController.getUser();
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    //sharedPreferences.setString("access_token", "asd");
    if (!_categories.contains('نمایش همه')) {
      _categories.insert(0, 'نمایش همه');
    }
    filteringDevices(selectedCategory);
  }

  addCoolerBtnClicked(AddCooler cooler) async {
    ChiscoResponse response = await deviceRepository.addCooler(cooler);
    if (!response.status) {
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);

      return;
    } else {
      AddDeviceResponse addDeviceResponse = response.object;
      Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
      ChiscoFlushBar.showSuccessFlushBar(context, addDeviceResponse.message);
      Provider.of<AppController>(context, listen: false).refreshData(response.object);
      Provider.of<AppController>(context, listen: false).subscribe(cooler.serialNumber);
    }
  }

  addPowerBtnClicked(AddPower power) async {
    print("power : ${power.toString()}");
    ChiscoResponse response = await deviceRepository.addPower(power);
    if (!response.status) {
      ChiscoFlushBar.showErrorFlushBar(context, response.errorMessage);

      return;
    }
    // bind response to all lists
    AddDeviceResponse addDeviceResponse = response.object;
    //Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
    ChiscoFlushBar.showSuccessFlushBar(context, addDeviceResponse.message);
    print(response.object.toString());
    Provider.of<AppController>(context, listen: false)
        .refreshData(addDeviceResponse);
    Provider.of<AppController>(context, listen: false)
        .subscribe(power.serialNumber);
    notifyListeners();
  }

  ///this function is for filtering devices with [category]
  ///if user select [نمایش همه] it shows all the devices
  ///and if user select each other it filters devices
  ///for filtering we create a list [filteredDevices] and we use it for showing devices in homePage
  filteringDevices(String category) {
    print('Devices : ${_listDevices.toString()}');
    if (category == 'نمایش همه') {
      filteredDevices.clear();
      _filteredDevices.addAll(_listDevices);
      selectedCategory = category;
    } else {
      print('else');
      _filteredDevices = _listDevices
          .where((element) => element.category == category)
          .toList();
      print(filteredDevices.toString());
      selectedCategory = category;
      print(selectedCategory);
    }

    Future.delayed(const Duration(milliseconds: 250), () {
      notifyListeners();
    });
  }

  homeLists() {
    ///we get these parameters here from [AppController]
    _coolerCount =
        Provider.of<AppController>(context, listen: false).getCoolers().length;
    _powerCount =
        Provider.of<AppController>(context, listen: false).getPowers().length;
    _listDevices =
        Provider.of<AppController>(context, listen: false).getUserDevicesList;
    _categories =
        Provider.of<AppController>(context, listen: false).getCategories;
  }

  ///onClick for all Devices {on or off button} Icon
  onDevicePowerBtnClicked(Device device)  async{
    if (device.deviceType == DeviceType.power) {
      ///if user click on power icon for powers we have to change all [connectors] state
      ///and publish data in Mqtt

      Power power = device as Power;
      await Provider.of<AppController>(context,listen: false).updatePowersConnectors(power,context);
      notifyListeners();


    } else {
      ///and if user click on Cooler's power icon we have only change isPowerActive bool
      ///and publish it in MQTT
      Cooler cooler = device as Cooler;
      bool isPowerActive = changeDevicePowersBtn(device);
      cooler.power = !isPowerActive;
      Provider.of<AppController>(context, listen: false).setCooler(cooler);
      isPowerActive = !isPowerActive;
      Provider.of<AppController>(context, listen: false).publishCoolerMqtt(cooler,context);
      notifyListeners();
    }
  }

  ///this function is for getting device power bool state
  ///we pass Device then we search in our list to find the device
  ///after that we @return deviceIsActive
  bool changeDevicePowersBtn(Device device) {
    if (device.deviceType == DeviceType.power) {
      List<Connector> connectors = (device as Power)
          .connectors
          .where((element) => element.status)
          .toList();
      if (connectors.isEmpty) {
        isDeviceActive = false;
        return false;
      } else {
        isDeviceActive = true;
        return true;
      }
    } else {
      return (device as Cooler).power;
    }
  }
}
