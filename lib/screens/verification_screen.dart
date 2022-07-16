import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/src/controllers/storage_controller.dart';
import 'package:notesriver_mobile/src/controllers/verification_controller.dart';
import 'package:notesriver_mobile/widget/resend_widget.dart';
import 'package:notesriver_mobile/widget/stylish_button.dart';
import 'package:notesriver_mobile/widget/stylishheader_text.dart';
import 'package:notesriver_mobile/widget/stylistpage_poper.dart';

class VerifcationScreen extends StatefulWidget {
  const VerifcationScreen({Key? key}) : super(key: key);

  @override
  State<VerifcationScreen> createState() => _VerifcationScreenState();
}

class _VerifcationScreenState extends State<VerifcationScreen> {
  final StorageController storageController = Get.find<StorageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: StylishPagePopper(),
        title: Text(
          'Verification',
          style: GoogleFonts.firaSans(
            color: Colors.indigo.shade500,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: GetX<VerificationController>(
        builder: (verification) {
          return verification.verified.isTrue
              ? Column(
                  children: [
                    StylishHeaderText(
                      firstText: 'Veri',
                      secondText: 'fied',
                      showLogo: true,
                      showHeader: true,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.check,
                        size: 50,
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Text(
                        'your email ' +
                            storageController.profile.value.email +
                            ' is verified successfully. Thank you press continue for start exploring.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.firaSans(
                          color: Colors.indigo.shade500,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    StylishButton(
                      onTap: () {
                        Get.offAllNamed('/home');
                      },
                      text: 'Let\'s explore',
                    )
                  ],
                )
              : Column(
                  children: [
                    StylishHeaderText(
                        firstText: 'Email',
                        secondText: ' Verification',
                        showLogo: true,
                        showHeader: true),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Text(
                        'Please enter your OTP which we sent on your gmail ' +
                            storageController.profile.value.email,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.firaSans(
                          color: Colors.indigo.shade500,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    verification.showErr.isTrue
                        ? Container(
                            padding: EdgeInsets.only(
                                left: 20, right: 20, top: 3, bottom: 3),
                            alignment: Alignment.center,
                            child: Text(
                              verification.errMessage,
                              style: GoogleFonts.firaSans(
                                color: verification.showSuccess == true
                                    ? Colors.indigo.shade600
                                    : Colors.red.shade600,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        : Container(),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      child: TextField(
                        controller: verification.otpController,
                        enabled: !verification.isLoading.value,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Your OTP',
                          border: OutlineInputBorder(),
                          focusColor: Colors.indigo.shade600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: ResendScreen(verification: verification),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  if (verification.isLoading.isFalse) {
                                    verification.verifyUsingOtp();
                                  }
                                },
                                child: verification.isLoading.isTrue
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(),
                                      )
                                    : Container(
                                        height: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.indigo.shade600,
                                        ),
                                        child: Text(
                                          'VERIFY',
                                          style: GoogleFonts.firaSans(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
