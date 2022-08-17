import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

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
      this.profileImg =''});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json["email"],
      password: json["password"],
      fullName: json["full_name"],
      address1: json["address_line1"],
      address2: json["address_line2"],
      phoneNumber: json["phone_no"],
      profileImg: json['img_url'] ?? '');

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "full_name": fullName,
        "address_line1": address1,
        "address_line2": address2,
        "phone_no": phoneNumber,
      };
}
