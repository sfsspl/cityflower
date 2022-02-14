import 'package:city_flower/features/user/domain/entity/my_cf_card_entity.dart';

class MyCfCardModel extends MyCFCardEntity {
  String cardNumber;
  int pointBalance;
  String lastSync;
  int userId;
  String createdAt;
  String updatedAt;

  MyCfCardModel(
      {String cardNumber,
      int pointBalance,
      String lastSync,
      String userId,
      String createdAt,
      String updatedAt})
      : super(cardNumber: cardNumber, pointBalance: pointBalance);

  MyCfCardModel.fromJson(Map<String, dynamic> json) {
    cardNumber = json['card_number'];
    pointBalance = json['point_balance'];
    lastSync = json['last_sync'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['card_number'] = this.cardNumber;
    data['point_balance'] = this.pointBalance;
    data['last_sync'] = this.lastSync;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
  }
}
