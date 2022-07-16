import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesriver_mobile/models/user_profile.model.dart';
import 'package:notesriver_mobile/src/HttpException.dart';
import 'package:notesriver_mobile/src/config.dart';
import 'package:notesriver_mobile/src/controllers/api_controller.dart';
import 'package:notesriver_mobile/src/controllers/storage_controller.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isEnabled = false.obs;
  RxBool remember = false.obs;
  RxBool hidePassword = true.obs;
  String errorMessage = '';
  RxBool showError = false.obs;
  RxBool verify = false.obs;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late StorageController _storageController;
  late ApiController _apiController;
  LoginController() {
    _storageController = Get.find<StorageController>();
    _apiController = Get.find<ApiController>();

    setUsernameAndPasswordValue();
  }

  setUsernameAndPasswordValue() {
    usernameController.text = _storageController.username.value;
    passwordController.text = _storageController.password.value;
  }

  performLogin() async {
    try {
      isLoading.value = true;
      if (remember.isTrue) {
        await _storageController.storeUsernamePassword(
            username: usernameController.text,
            password: passwordController.text);
      }
      await loginApiCall();
    } catch (e) {
      isLoading.value = false;
      showErrorFun(message: e.toString());
    }
  }

  loginApiCall() async {
    try {
      await _apiController.loginUser(
        username: usernameController.text,
        password: passwordController.text,
        cb: (value) {
          verify.value = true;
        },
      );
    } on HttpException catch (e) {
      showErrorFun(message: e.message);
    } catch (e) {
      showErrorFun(message: e.toString());
    }
  }

  changeRememberValue({required bool value}) {
    remember.value = value;
  }

  showHidePassword() {
    hidePassword.value = !hidePassword.value;
  }

  showErrorFun({required String message}) async {
    errorMessage = message;
    showError.value = true;
    Timer(Duration(seconds: 3), () {
      showError.value = false;
      isLoading.value = false;
    });
  }
}
