//for add new schedule this data class use
class AddSchedule {
  String? endTime;
  List<String> repeat;
  String serialNumber;
  int? portNumber;
  String? startTime;
  bool enable;
  String? id;

  AddSchedule(
      {required this.endTime,
      required this.repeat,
      required this.serialNumber,
      required this.startTime,this.enable =true, this.portNumber,this.id});

  factory AddSchedule.fromJson(Map<String, dynamic> json) {
    return AddSchedule(
      endTime: json['endTime'],
      repeat: json['repeat'] != null ? List<String>.from(json['repeat']) : [],
      serialNumber: json['serialNumber'],
      startTime: json['startTime'], portNumber: null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(endTime != null)
      data['endTime'] = endTime ;

    if(startTime != null) {
      data['startTime'] = startTime;
    }
    data['serialNumber'] = serialNumber;

    data['repeat'] = repeat;
    data['portNumber'] = portNumber;
    data['enable'] = enable;
    data['id'] =id;
    return data;
  }
}
