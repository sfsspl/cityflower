import 'package:city_flower/features/points_history/domain/entity/points_history_entity.dart';

class PointsHistoryModel extends PointsHistoryEntity {
  String cardNumber;

  PointsHistoryModel(
      {int entryNumber,
      String transactionDate,
      int point,
      String entryType,
      this.cardNumber})
      : super(
            entryNumber: entryNumber,
            transactionDate: transactionDate,
            point: point,
            entryType: entryType);

  factory PointsHistoryModel.fromJSON(Map<String, dynamic> json) {
    return PointsHistoryModel(
        entryNumber: json['entry_number'],
        transactionDate: json['transaction_date'],
        point: json['point'],
        entryType: json['entry_type'],
        cardNumber: json['card_number']);
  }
}
