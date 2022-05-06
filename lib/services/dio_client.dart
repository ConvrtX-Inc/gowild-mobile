import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/api_path.dart';
import 'package:gowild_mobile/models/user_model.dart';

class DioClient {
  static const String baseUrl = 'https://gowild-api-dev.herokuapp.com';

  Future<UserModel> registerUser(String email, String password, String fullName,
      String address1, String address2, String phoneNumber) async {
    final String postEndPoint = baseUrl + ApiPath().registerNewAccount;
    BaseOptions options = BaseOptions(
      baseUrl: postEndPoint,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    final Dio dio = Dio(options);
    try {
      Response response = await dio.post(postEndPoint, data: {
        "email": email,
        "password": password,
        "full_name": fullName,
        "address_line1": address1,
        "address_line2": address2,
        "phone_no": phoneNumber
      });
      debugPrint(response.toString());
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to create post request - register user");
    }
  }

  Future<UserModel> loginUser(
    String email,
    String password,
  ) async {
    final String postEndPoint = baseUrl + ApiPath().loginUser;
    BaseOptions options = BaseOptions(
      baseUrl: postEndPoint,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    final Dio dio = Dio(options);
    try {
      Response response = await dio.post(postEndPoint, data: {
        "email": email,
        "password": password,
      });
      debugPrint(response.toString());
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to create post request - log in user");
    }
  }

  Future<UserModel> smsCode(
    String phoneNumber,
    String message,
  ) async {
    final String postEndPoint = baseUrl + ApiPath().smsCode;
    BaseOptions options = BaseOptions(
      baseUrl: postEndPoint,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    final Dio dio = Dio(options);
    try {
      Response response = await dio.post(postEndPoint,
          data: {"phone_number": phoneNumber, "message": message});
      debugPrint(response.toString());
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to create post request");
    }
  }

  Future<UserModel> getUser() async {
    final String postEndPoint = baseUrl + ApiPath().getUser;
    BaseOptions options = BaseOptions(
      baseUrl: postEndPoint,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    final Dio dio = Dio(options);
    try {
      Response response = await dio.get(postEndPoint);
      debugPrint(response.toString());
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to create post request - get user");
    }
  }
}
