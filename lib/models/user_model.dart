class UserModel {
  UserModel(
      {this.fullName,
      this.email,
      this.password,
      this.address1,
      this.address2,
      this.accountCreated,
      this.phoneNumber,
      this.isLoggedIn,
      this.uid});

  DateTime? accountCreated;
  String? address1;
  String? address2;
  String? email;
  String? fullName;
  String? password;
  String? phoneNumber;
  String? uid;
  bool? isLoggedIn;
}
