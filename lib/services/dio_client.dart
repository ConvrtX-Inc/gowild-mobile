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
      throw Exception("Failed to register user");
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
      throw Exception("Failed to  log in user");
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
    final token =
        await SecureStorage.readValue(key: SecureStorage.userTokenKey);
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
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to create get request - get user");
    }
  }

  Future<RouteList> getRoutes() async {
    final String? token =
        await SecureStorage.readValue(key: SecureStorage.userTokenKey);

    const String postEndPoint = baseUrl + '/api/v1/route?sort=created_date,DESC';
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

  Future<Routes> getRoute() async {
    final token =
        await SecureStorage.readValue(key: SecureStorage.userTokenKey);
    final id = await SecureStorage.readValue(key: SecureStorage.userIdKey);
    String postEndPoint =
        baseUrl + '/api/v1/route/64ed8173-2ac1-436f-8a0b-0edd8950fe9b';
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
      return Routes.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to create get request - get routes");
    }
  }

  Future<UserModel> postGoogleLogin() async {
    final token =
        await SecureStorage.readValue(key: SecureStorage.userTokenKey);
    debugPrint(token);
    final String postEndPoint = baseUrl + ApiPath().googleLogin;
    BaseOptions options = BaseOptions(
      baseUrl: postEndPoint,
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    final Dio dio = Dio(options);
    try {
      Response response = await dio.post(postEndPoint, data: {
        "id_token": '$token',
      });
      debugPrint(response.toString());

      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to log in with Google");
    }
  }

  // Future<UserModel>postForgotPassword()async{

  // }
}
