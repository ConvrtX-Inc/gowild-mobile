class UserModel {
  String? fullName;
  String? email;
  String? password;
  String? address1;
  String? address2;
  String? phoneNumber;
  String? uid;
  DateTime? accountCreated;
  UserModel(
      {this.fullName,
      this.email,
      this.password,
      this.address1,
      this.address2,
      this.accountCreated,
      this.phoneNumber,
      this.uid});
}
