import 'package:meta/meta.dart';

class MyCFCardEntity {
  String cardNumber;
  int pointBalance;

  MyCFCardEntity({@required this.cardNumber, @required this.pointBalance});

  @override
  String toString() {
    return 'MyCFCardEntity{cardNumber: $cardNumber, pointBalance: $pointBalance}';
  }
}
