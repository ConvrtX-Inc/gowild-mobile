import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:gowild_mobile/constants/api_path_constants.dart';
import 'package:gowild_mobile/services/secure_storage.dart';
import 'package:http/http.dart' as http;

/// Request type
enum RequestType { GET, POST, PATCH, DELETE }

class ApiServices {
  /// is debugging
  final bool isDebugging = true;

  /// API base mode
  final String apiBaseMode = ApiPathConstants.apiBaseMode;

  /// API base url
  final String apiBaseUrl = ApiPathConstants.apiBaseUrl;

  /// This this Global function for creating api request
  Future<dynamic> request(String url, RequestType type,
      {bool needAccessToken = false,
      Map<String, dynamic> data = const <String, dynamic>{},
      bool returnStatusCodeOnly = false}) async {
    final Uri completeUri = Uri.parse('$apiBaseMode$apiBaseUrl/$url');
    String? token;
    dynamic body;

    final http.Request request = http.Request(describeEnum(type), completeUri);
    final Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };
    if (needAccessToken) {
      token = await SecureStorage.readValue(key: SecureStorage.userTokenKey);
      headers['Authorization'] = 'Bearer $token';
      print(token);
    }
    request.headers.addAll(headers);

    request.body = jsonEncode(data);

    final http.StreamedResponse streamedResponse = await request.send();
    final http.Response response =
        await http.Response.fromStream(streamedResponse);

    print(completeUri.toString());
    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }

    // debugPrint(response.statusCode.toString());
    // debugPrint(body.toString());

    if (returnStatusCodeOnly) {
      print(response.body);
      return response.statusCode;
    }

    if (response.statusCode != 200 && response.statusCode != 201) {
      switch (response.statusCode) {
        case 500:
          {
            print(completeUri.toString());
          }
          break;
        case 422:
          {
            print(completeUri.toString());
          }
          break;
        case 401:
          {
            // await refreshAccessToken();
          }
          break;
      }

      if (body.containsKey('errors')) {}
    } else {
      if (body == null) {
        return response.statusCode;
      }
    }

    if (type == RequestType.GET) {
      //Do if request type is GET
    }

    return body;
  }
}
