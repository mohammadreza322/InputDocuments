//data Class for send add power request

class AddPower {
  String category;
  String name;
  String serialNumber;

  String? power1;
  String? power2;
  String? power3;
  String? power4;
  String? usb1;
  String? usb2;

  AddPower(
      {required this.category,
      required this.name,
      required this.serialNumber,
      this.power1 = '',
      this.power2 = '',
      this.power3 = '',
      this.power4 = '',
      this.usb1 = '',
      this.usb2 = ''});

  factory AddPower.fromJson(Map<String, dynamic> json) {
    return AddPower(
      category: json['category'],
      serialNumber: json['serialNumber'],
      name: json['name'],
      power1: json['power1'],
      power2: json['power2'],
      power3: json['power3'],
      power4: json['power4'],
      usb1: json['usb1'],
      usb2: json['usb2'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category'] = category;
    data['name'] = name;
    data['serialNumber'] = serialNumber;
    data['power1'] = power1;
    data['power2'] = power2;
    data['power3'] = power3;
    data['power4'] = power4;
    data['usb1'] = usb1;
    data['usb2'] = usb2;
    return data;
  }
}
