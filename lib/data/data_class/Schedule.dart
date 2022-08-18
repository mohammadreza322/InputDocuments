class Schedule {
    String id;
    bool enable;
    String? end;
    List<String> repeat;
    String? start;
    //Port for Power ???
    Schedule({required this.id, required this.enable, this.end, required this.repeat, required this.start});

    factory Schedule.fromJson(Map<String, dynamic> json) {
        return Schedule(
            id: json['_id'],
            enable: json['enable'], 
            end: json['end'] ,
            repeat: json['repeat'],
            start: json['start'], 
        );
    }



}