import 'dart:convert';

import 'package:auth_restfull/utils/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final dio = Dio();
      final resp = await dio.post(
        "$baseUrl$UrlRegisterEmail",
        data: {
          "name": nameController.text,
          "email": emailController.text.trim(),
          "password": passwordController.text,
        },
        options: Options(headers: headers),
      );
      if (resp.statusCode == 200) {
        final json = jsonDecode(resp.data);
        if (json['code'] == 0) {
          final token = json['data']['Token'];
          print(token);
          final SharedPreferences prefs = await _prefs;

          await prefs.setString('token', token);
          nameController.clear();
          emailController.clear();
          passwordController.clear();
        } else {
          throw json['Message'] ?? "Unknown Error Occured";
        }
      } else {
        throw resp.data['Message'] ?? "Unknown Error Occured";
      }
      print(resp);
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
