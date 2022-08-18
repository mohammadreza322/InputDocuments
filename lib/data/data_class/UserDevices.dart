import 'package:chisco/data/data_class/Cooler.dart';
import 'package:chisco/data/data_class/Power.dart';

class UserDevices {
    final List<String>  categories;
    final List<Cooler>  coolers;
    final List<Power> powers;

    UserDevices({required this.categories, required this.coolers, required this.powers});

    factory UserDevices.fromJson(Map<String, dynamic> json) {
        return UserDevices(
            categories: json['categories'] != null ? List<String>.from(json['categories']) : const [],
            coolers: json['coolers'] != null ? (json['coolers'] as List).map((i) => Cooler.fromJson(i)).toList() : [],
            powers: json['powers'] != null ? (json['powers'] as List).map((i) => Power.fromJson(i)).toList() : [],
        );
    }


}