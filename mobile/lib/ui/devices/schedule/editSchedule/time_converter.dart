import 'package:sizer/sizer.dart';

class TimeConverter{
  static int getHour(String time){
    List split= time.split(':');

    return int.parse(split[0]);
  }

  static int getMin(String time){
    List split = time.split(':');

    return int.parse(split[1]);
  }
}