import 'package:intl/intl.dart';

class DateHelper {

  static String dateTimeToString(DateTime date)
  {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:MM');
    return  formatter.format(date);
  } 
}