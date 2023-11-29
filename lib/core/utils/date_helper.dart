import 'package:jiffy/jiffy.dart';

abstract class DateHelper {
  static int getHour24({required String time}) {
    String helper = time.substring(time.length - 2, time.length);
    int hour = int.parse(time.substring(0, 2));
    if (hour == 12 && helper == 'AM') {
      return 0;
    } else {
      if (helper == 'PM' && hour != 12) {
        return (hour + 12);
      }
      return hour;
    }
  }

  static String getCurrentDate() {
    final Jiffy jiffy = Jiffy.now();
    final String day = jiffy.EEEE;
    final String date = jiffy.MMMd;
    return '$day $date';
  }
}
