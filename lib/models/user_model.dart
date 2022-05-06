import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

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

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        password: json["password"],
        fullName: json["full_name"],
        address1: json["address_line1"],
        address2: json["address_line2"],
        phoneNumber: json["phone_no"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "full_name": fullName,
        "address_line1": address1,
        "address_line2": address2,
        "phone_no": phoneNumber,
      };
}
