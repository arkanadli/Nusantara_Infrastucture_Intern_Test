import 'dart:convert';

import 'package:auth_restfull/screens/note/screens/home.dart';
import 'package:auth_restfull/utils/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final dio = Dio();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final user = {
        "name": nameController.text,
        "email": emailController.text.trim(),
        "password": passwordController.text,
      };
      final resp = await dio.postUri(
        Uri.parse("$baseUrl$UrlRegisterEmail"),
        data: user,
        options: Options(headers: headers),
      );
      final json = resp.data;
      print(json);
      if (resp.statusCode == 200) {
        if (json['code'] == 0) {
          final token = json['data']['Token'];
          final name = json['data']['Name'];
          final SharedPreferences prefs = await _prefs;

          await prefs.setString('token', token);
          await prefs.setString('name', name);
          nameController.clear();
          emailController.clear();
          passwordController.clear();
          Get.offAll(const HomeScreen());
        } else {
          throw json['Message'] ?? "Unknown Erro  r Occured";
        }
      } else {
        throw resp.data['Message'] ?? "Unknown Error Occured";
      }
      print(resp);
    } on DioException catch (dioError) {
      print('DioException: $dioError');
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
