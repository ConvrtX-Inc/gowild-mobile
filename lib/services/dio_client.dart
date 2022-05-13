import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gowild_mobile/constants/api_path.dart';
import 'package:gowild_mobile/models/user_model.dart';
import 'package:gowild_mobile/services/secure_storage.dart';

import '../models/route.dart';

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
      await SecureStorage.saveValue(
          key: SecureStorage.userTokenKey, value: response.data['token']);
      await SecureStorage.saveValue(
          key: SecureStorage.userIdKey, value: response.data['user']['id']);
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

  Future<UserModel> getUser({String? token}) async {
    final String postEndPoint = baseUrl + ApiPath().getUser;
    BaseOptions options = BaseOptions(
      baseUrl: postEndPoint,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    final Dio dio = Dio(options);
    try {
      Response response = await dio.get(
        postEndPoint,
        options: Options(
          headers: {
            "authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjMxMDYyODQzLWY5YzktNGNjMC1iMzYzLWYwZmM0NDc5ODAzYyIsImlhdCI6MTY1MjIzOTI0NSwiZXhwIjoxNjUyMzI1NjQ1fQ.0kjQeEIE4AcfKL2gLNqvU8PliNdQiRsl50oz5u4O0Z4",
          },
        ),
      );
      debugPrint(response.toString());
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to create get request - get user");
    }
  }

  Future<Routes> getRoute() async {
    const String postEndPoint =
        baseUrl + '/api/v1/route/2f1ab43e-e7db-482a-91a3-3990020f271b';
    BaseOptions options = BaseOptions(
      baseUrl: postEndPoint,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    final Dio dio = Dio(options);
    try {
      Response response = await dio.get(
        postEndPoint,
        options: Options(
          headers: {
            "authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjMxMDYyODQzLWY5YzktNGNjMC1iMzYzLWYwZmM0NDc5ODAzYyIsImlhdCI6MTY1MjIzOTI0NSwiZXhwIjoxNjUyMzI1NjQ1fQ.0kjQeEIE4AcfKL2gLNqvU8PliNdQiRsl50oz5u4O0Z4",
          },
        ),
      );
      debugPrint(response.toString());
      return Routes.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to create get request - get routes");
    }
  }

  Future<RouteList> getRoutes() async {
    final String? token =
        await SecureStorage.readValue(key: SecureStorage.userTokenKey);

    const String postEndPoint = baseUrl + '/api/v1/route';
    BaseOptions options = BaseOptions(
      baseUrl: postEndPoint,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    final Dio dio = Dio(options);
    try {
      Response response = await dio.get(
        postEndPoint,
        options: Options(
          headers: {
            "authorization": "Bearer $token",
          },
        ),
      );
      debugPrint(response.toString());
      return RouteList.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to create get request - get routes");
    }
  }
}
