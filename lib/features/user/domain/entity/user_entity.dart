class UserEntity {
  int id;
  String name;
  String email;
  String countryCode;
  String mobileNumber;
  String roleId;
  String createdAt;
  String updatedAt;
  String deletedAt;

  UserEntity(
      {this.id,
      this.name = "",
      this.email = "",
      this.countryCode = "",
      this.mobileNumber = "",
      this.roleId = "",
      this.createdAt = "",
      this.updatedAt = "",
      this.deletedAt = ""});
}
