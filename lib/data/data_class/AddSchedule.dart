class AddSchedule {
  String? endTime;
  List<String> repeat;
  String serialNumber;
  String? startTime;

  AddSchedule(
      {required this.endTime,
      required this.repeat,
      required this.serialNumber,
      required this.startTime});

  factory AddSchedule.fromJson(Map<String, dynamic> json) {
    return AddSchedule(
      endTime: json['endTime'],
      repeat: json['repeat'] != null ? List<String>.from(json['repeat']) : [],
      serialNumber: json['serialNumber'],
      startTime: json['startTime'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['endTime'] = endTime ?? '';
    data['serialNumber'] = serialNumber;
    data['startTime'] = startTime ?? '';
    data['repeat'] = repeat;

    return data;
  }
}
