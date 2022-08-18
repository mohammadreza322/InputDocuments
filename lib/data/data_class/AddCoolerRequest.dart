class AddCooler {
  String brand;
  String category;
  String model;
  String name;
  String serialNumber;

  AddCooler(
      {required this.brand,
      required this.category,
      required this.model,
      required this.name,
      required this.serialNumber});

  factory AddCooler.fromJson(Map<String, dynamic> json) {
    return AddCooler(
      brand: json['brand'],
      category: json['category'],
      model: json['model'],
      name: json['name'],
      serialNumber: json['serialNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['category'] = this.category;
    data['model'] = this.model;
    data['name'] = this.name;
    data['serialNumber'] = this.serialNumber;
    return data;
  }
}
