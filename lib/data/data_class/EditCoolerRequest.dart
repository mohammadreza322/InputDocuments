class EditCooler {

  String category;
  String brand;
  String model;
  String name;
  String serialNumber;

  EditCooler(
      {
        required this.category,
        required this.brand,
        required this.model,
        required this.name,
        required this.serialNumber});

  factory EditCooler.fromJson(Map<String, dynamic> json) {
    return EditCooler(

      category: json['category'],
      model: json['model'],
      brand: json['brand'],
      name: json['name'],
      serialNumber: json['serialNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['name'] = this.name;
    data['serialNumber'] = this.serialNumber;
    return data;
  }
}
