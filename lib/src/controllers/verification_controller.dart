import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesriver_mobile/src/HttpException.dart';
import 'package:notesriver_mobile/src/controllers/api_controller.dart';

class VerificationController extends GetxController {
  RxBool resendLoading = false.obs;
  late ApiController _apiController;
  RxBool showErr = false.obs;
  String errMessage = '';
  bool showSuccess = false;
  RxBool verified = false.obs;

  RxBool isLoading = false.obs;
  final TextEditingController otpController = TextEditingController();

  VerificationController() {
    _apiController = Get.find<ApiController>();
  }

  resendRequest({required Function timer}) async {
    resendLoading.value = true;
    try {
      final status = await _apiController.otpBasedVerificationRequest();
      if (status) {
        showSuccess = true;
        resendLoading.value = false;
        timer();
        errMessage = 'OTP Sended';
        showErr.value = true;
        Timer(Duration(seconds: 4), () {
          showSuccess = false;
          showErr.value = false;
        });
      }
    } on HttpException catch (e) {
      resendLoading.value = false;
      errMessage = e.message;
      showErr.value = true;
      Timer(Duration(seconds: 4), () {
        showErr.value = false;
      });
    } catch (e) {
      resendLoading.value = false;
      errMessage = e.toString();
      showErr.value = true;
      Timer(Duration(seconds: 4), () {
        showErr.value = false;
      });
    }
  }

  verifyUsingOtp() async {
    if (otpController.text.length > 5) {
      try {
        isLoading.value = true;
        final status =
            await _apiController.verificationWithOtp(otp: otpController.text);
        if (status == true) {
          isLoading.value = false;
          verified.value = true;
        }
      } on HttpException catch (e) {
        isLoading.value = false;
        errMessage = e.message;
        showErr.value = true;
        Timer(Duration(seconds: 4), () {
          showErr.value = false;
        });
      } catch (e) {
        isLoading.value = false;
        errMessage = e.toString();
        showErr.value = true;
        Timer(Duration(seconds: 4), () {
          showErr.value = false;
        });
      }
    } else {
      isLoading.value = false;
      errMessage = 'OTP length should be 6 digits';
      showErr.value = true;
      Timer(Duration(seconds: 4), () {
        showErr.value = false;
      });
    }
  }

  disposeController() {
    otpController.dispose();
  }
}
