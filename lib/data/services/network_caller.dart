import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';

import '../../ui/screens/auth/sign_in_screen.dart';
import '../models/network_response.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({
    required String url,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(uri.toString());
      String? token = AuthController.accessToken;
      print("token: $token");
      final Response response = await get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': token.toString(),
        },
      );
      printResponse(url, response);
      printRequest(url: url, headers: response.request!.headers, body: null);

      final decodedData = jsonDecode(
        response.body,
      );

      if (response.statusCode == 200) {
        if (decodedData["status"] == 'fail') {
          return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedData['data'],
          );
        }

        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      } else if (response.statusCode == 400) {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Bad Request',
        );
      } else if (response.statusCode == 401) {
        _moveToLoginScreen();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthorized',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedData['data'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint(uri.toString());
      String? token = AuthController.accessToken;
      print("token: $token");
      final Response response = await post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'token': token.toString(),
        },
        body: jsonEncode(body),
      );
      printRequest(url: url, headers:  response.request!.headers, body :body!);
      printResponse(url, response);

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedData,
        );
      } else if (response.statusCode == 400) {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Bad Request',
        );
      } else if (response.statusCode == 401) {
        _moveToLoginScreen();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthorized',
        );
      } else if (response.statusCode == 404) {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'No user found. Try again!',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: decodedData['data'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void printResponse(String url, Response response) {
    debugPrint(
      'URL: $url\n RESPONSE_CODE: ${response.statusCode}\n BODY: ${response.body}',
    );
  }

  static void printRequest(
      {required String url, required Map<String, dynamic> headers, required Map<String, dynamic>? body}) {
    debugPrint(
      'URL: $url\n HEADERS: $headers\n BODY: $body',
    );
  }

  static void _moveToLoginScreen() async {
    await AuthController.clearAuthDetails();
    Navigator.pushAndRemoveUntil(
      TaskManagerApp.navigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (_) => const SignInScreen(),
      ),
      (route) => false,
    );
  }
}
