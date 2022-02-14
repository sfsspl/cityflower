import 'package:city_flower/core/util/date_formatter.dart';

class PointsHistoryEntity {

  int entryNumber;
  String transactionDate;
  int point;
  String entryType;

  PointsHistoryEntity(
      {this.entryNumber, this.transactionDate, this.point, this.entryType});

  String getFormattedTime() {
    return formatTransactionDate(dateTime: this.transactionDate);
  }
}
