class Schedule {
  String id;
  bool enable;
  String? end;
  List<String> repeat;
  String? start;
  int? port;

  Schedule(
      {required this.id,
      required this.enable,
      this.end,
      required this.repeat,
      required this.start,
      required this.port});



  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        id: json['_id'],
        enable: json['enable'],
        end: json['end'],
        repeat: List<String>.from(json['repeat']),
        start: json['start'],
        port: json['port']);
  }
}
