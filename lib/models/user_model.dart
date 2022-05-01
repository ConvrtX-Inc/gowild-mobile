class UserModel {
  String? fullName;
  String? email;
  String? password;
  String? address1;
  String? address2;
  String? phoneNumber;
  String? uid;
  String? profileImg;
  DateTime? accountCreated;
  bool? isLoggedIn;
  UserModel(
      {this.fullName,
      this.email,
      this.password,
      this.address1,
      this.address2,
      this.accountCreated,
      this.phoneNumber,
      this.isLoggedIn,
      this.uid,
      this.profileImg});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        fullName: json['full_name'],
        email: json['email'],
        phoneNumber: json['phone_no'],
        address1: json['address_line1'],
        address2: json['address_line2'],
        profileImg: json['profile_photo']);
  }
}
