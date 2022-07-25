import 'package:chisco/data/dataclass/divice.dart';
import 'package:chisco/ui/main/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeController extends ChangeNotifier {
  final BuildContext context;

  HomeController(this.context);

  List<Device> _userDevices = [];
  List<Device> _filterdDevices = [];

  String selectedCategory = 'نمایش همه';

  init() {
    _userDevices = Provider.of<AppController>(context).getUserDevices;
  }

  filteringDevices(String category) {
    _filterdDevices =
        _userDevices.where((element) => element.category == category).toList();
    selectedCategory = category;
    print(selectedCategory);
    notifyListeners();
  }
}
