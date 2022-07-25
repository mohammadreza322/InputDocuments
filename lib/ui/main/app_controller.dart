import 'package:chisco/data/dataclass/divice.dart';
import 'package:flutter/material.dart';

class AppController extends ChangeNotifier {
  final List<Device> _userDevices = [];

  List<String> listOfDevicesCategory=['نمایش همه','پذیرایی','اتاق مهمان','اتاق خواب','سال غدا خوری','نمایش همه','پذیرایی','اتاق مهمان','اتاق خواب','سال غدا خوری'];

  get getUserDevices =>_userDevices;
  isUserHaveDevice() => _userDevices.isEmpty;


}