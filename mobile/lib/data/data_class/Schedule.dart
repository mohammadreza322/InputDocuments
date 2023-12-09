///this data class is use in @Cooler and @Power data classes (List<Schedule>)


class Schedule {
  String id;
  bool enable;
  String end;
  List<String> repeat;
  String start;
  int? port;

  Schedule(
      {required this.id,
      required this.enable,
        required this.end,
      required this.repeat,
      required this.start,
      required this.port});



  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        id: json['_id'],
        enable: json['enable'],
        end: json['end']!=null ? json['end']:'',
        repeat: List<String>.from(json['repeat']),
        start: json['start']!=null ?(json['start']):'',
        port: json['port']);
  }
}
