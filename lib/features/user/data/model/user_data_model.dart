import 'package:city_flower/features/user/domain/entity/user_entity.dart';

class UserDataModel extends UserEntity {
  UserDataModel(
      int id,
      String name,
      String email,
      String countryCode,
      String mobileNumber,
      String roleId,
      String createdAt,
      String updatedAt,
      String deletedAt)
      : super(
            id: id,
            name: name,
            email: email,
            countryCode: countryCode,
            mobileNumber: mobileNumber,
            roleId: roleId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt);

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    mobileNumber = json['mobile_number'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country_code'] = this.countryCode;
    data['mobile_number'] = this.mobileNumber;
    data['role_id'] = this.roleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
