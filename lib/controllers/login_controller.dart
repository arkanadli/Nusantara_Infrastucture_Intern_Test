import 'dart:convert';

import 'package:auth_restfull/views/note/screens/home.dart';
import 'package:auth_restfull/utils/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final dio = Dio();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    try {
      // final headers = {'Content-Type': 'application/json'};

      final user = jsonEncode({
        "email": emailController.text.trim(),
        "password": passwordController.text,
      });
      final resp = await dio.post(
        "$authBaseUrl$endPointEmail",
        data: user,
        // options: Options(headers: headers),
      );
      if (resp.statusCode == 200) {
        final json = resp.data;

        print(json);
        if (json['code'] == 0) {
          final token = json['data']['Token'];
          final name = json['data']['Name'];
          final SharedPreferences prefs = await _prefs;

          await prefs.setString('token', token);
          await prefs.setString('name', name);
          emailController.clear();
          passwordController.clear();
          Get.offAll(const HomeScreen());
        } else {
          throw resp.data['Message'] ?? "Unknown Error Occured";
        }
      } else {
        throw resp.data['Message'] ?? "Unknown Error Occured";
      }
    } catch (e) {
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) => SimpleDialog(
          title: const Text('Error'),
          contentPadding: const EdgeInsets.all(20),
          children: [
            Text(
              e.toString(),
            )
          ],
        ),
      );
    }
  }
}
