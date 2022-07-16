import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/src/controllers/verification_controller.dart';

class ResendScreen extends StatefulWidget {
  ResendScreen({Key? key, required this.verification}) : super(key: key);
  VerificationController verification;

  @override
  State<ResendScreen> createState() => _ResendScreenState();
}

class _ResendScreenState extends State<ResendScreen> {
  int _time = 59;
  late Timer _timer;
  bool showTimer = false;
  void startTimer() {
    _time = 59;
    setState(() {
      showTimer = true;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_time == 0) {
        setState(() {
          showTimer = false;
          _timer.cancel();
        });
      } else {
        setState(() {
          _time--;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          if (widget.verification.resendLoading.isFalse && showTimer == false) {
            widget.verification.resendRequest(timer: startTimer);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'you can request for resend mail after ' +
                      _time.toString() +
                      ' Seconds.',
                ),
              ),
            );
          }
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          child: widget.verification.resendLoading.isTrue
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  showTimer ? "(" + _time.toString() + ")" : 'RESEND',
                  style: GoogleFonts.firaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
        ),
      );
    });
  }
}
