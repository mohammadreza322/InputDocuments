class EditCooler {

  String category;

  String name;
  String serialNumber;

  EditCooler(
      {
        required this.category,

        required this.name,
        required this.serialNumber});

  factory EditCooler.fromJson(Map<String, dynamic> json) {
    return EditCooler(

      category: json['category'],

      name: json['name'],
      serialNumber: json['serialNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;

    data['name'] = this.name;
    data['serialNumber'] = this.serialNumber;
    return data;
  }
}
