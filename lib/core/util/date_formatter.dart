import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

String formatDDMMYYY({@required DateTime date}) {
  return DateFormat('dd-MM-yyyy').format(date);
}

String formatYYYYMMDD({@required DateTime date}) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatTransactionDate({@required String dateTime}){
   final DateTime date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTime);
   return DateFormat('dd-MM-yyyy').format(date);
}