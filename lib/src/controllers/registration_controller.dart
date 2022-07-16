import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:notesriver_mobile/src/HttpException.dart';
import 'package:notesriver_mobile/src/config.dart';
import 'package:notesriver_mobile/src/controllers/api_controller.dart';
import 'package:notesriver_mobile/src/controllers/login_controller.dart';

class RegistrationController extends GetxController {
  List<String> enums = [
    'CHECKING',
    'NOT_FOUND',
    'FOUND',
    'ERROR',
    'NOT_CHECKING',
  ];
  RxBool isEnable = false.obs;
  RxBool isLoading = false.obs;
  RxString usernameState = 'NON'.obs;
  RxString emailState = 'NON'.obs;
  String errorMessage = '';
  RxBool showError = false.obs;
  RxBool hidePassword = true.obs;


  late ApiController _apiController;

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RegistrationController() {
    _apiController = Get.find<ApiController>();
  }

  checkUsername() async {
    if (usernameController.text.length >= 6) {
      usernameState.value = enums[0];
      try {
        await _apiController.checkUsernameAndEmail(
            uername: usernameController.text);
      } on HttpException catch (e) {
        usernameState.value = e.message;
        if (e.message == enums[3]) {
          showErrorFun(message: 'Server error try after some times.');
        }
      } catch (e) {
        showErrorFun(message: e.toString());
      }
    } else {
      usernameState.value = enums[4];
      errorMessage = 'Username must have grater then 5 characters.';
      showError.value = true;
      Timer(Duration(seconds: 3), () {
        showError.value = false;
      });
    }
  }

  showHidePassword() {
    hidePassword.value = !hidePassword.value;
  }

  checkEmail() async {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      emailState.value = enums[0];
      try {
        await _apiController.checkUsernameAndEmail(
            uername: emailController.text);
      } on HttpException catch (e) {
        emailState.value = e.message;
        if (e.message == enums[3]) {
          showErrorFun(message: e.message);
        }
      } catch (e) {
        showErrorFun(message: e.toString());
      }
    } else {
      emailState.value = enums[4];
    }
  }

  performValidation() {
    if (nameController.text.length == 0) {
      showErrorFun(message: 'Please Enter your name');
      return false;
    } else if (usernameState != enums[1]) {
      showErrorFun(
          message:
              'You can\'t continue with this username. Please try another one.');
      return false;
    } else if (emailState != enums[1]) {
      showErrorFun(
          message:
              'You can\'t continue with this email. Please try another one');
      return false;
    } else if (passwordController.text.length <= 6) {
      showErrorFun(message: 'Password must have greater then 6 character');
      return false;
    } else
      return true;
  }

  showErrorFun({required String message}) {
    errorMessage = message;
    showError.value = true;
    Timer(Duration(seconds: 3), () {
      showError.value = false;
    });
  }

  performRegistration() async {
    if (performValidation()) {
      changeLoading(value: true);
      await registrationApiCall();
    }
  }

  registrationApiCall() async {
    try {
      await _apiController.registerUser(
        name: nameController.text,
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
    } on HttpException catch (e) {
      changeLoading(value: false);
      showErrorFun(message: e.message);
    } catch (e) {
      changeLoading(value: false);
      showErrorFun(message: 'Check your network connection');
    }
  }

  changeLoading({required bool value}) {
    isEnable.value = value;
    isLoading.value = value;
  }

  disposeEveryThing() {
    usernameController.dispose();
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }
}
