import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/src/controllers/registration_controller.dart';
import 'package:notesriver_mobile/widget/stylish_button.dart';
import 'package:notesriver_mobile/widget/stylishheader_text.dart';
import 'package:notesriver_mobile/widget/stylistpage_poper.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<RegistrationController>(builder: (regController) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Navigator.canPop(context) == true
              ? StylishPagePopper()
              : Container(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StylishHeaderText(
              firstText: 'Sign',
              secondText: 'UP',
              showLogo: true,
              showHeader: true,
            ),
            regController.showError.isTrue
                ? Container(
                    alignment: Alignment.center,
                    child: Text(
                      regController.errorMessage,
                      style: GoogleFonts.firaSans(
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Container(),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: TextField(
                enabled: !regController.isEnable.value,
                controller: regController.nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_add,
                    color: Colors.indigo.shade600,
                  ),
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  focusColor: Colors.indigo.shade600,
                ),
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextField(
                      enabled: !regController.isEnable.value,
                      onChanged: (Value) async {
                        await regController.checkUsername();
                      },
                      controller: regController.usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.indigo.shade600,
                        ),
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                        focusColor: Colors.indigo.shade600,
                      ),
                      style: GoogleFonts.firaSans(
                        color: Colors.indigo.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  regController.usernameState.value == regController.enums[0]
                      ? const Expanded(
                          flex: 1,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : regController.usernameState.value ==
                              regController.enums[1]
                          ? const Expanded(
                              child: Center(
                                child: Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                              ),
                              flex: 1,
                            )
                          : regController.usernameState.value ==
                                  regController.enums[2]
                              ? const Expanded(
                                  child: Center(
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  ),
                                  flex: 1,
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextField(
                      enabled: !regController.isEnable.value,
                      onChanged: (value) async {
                        await regController.checkEmail();
                      },
                      controller: regController.emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.indigo.shade600,
                        ),
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        focusColor: Colors.indigo.shade600,
                      ),
                      style: GoogleFonts.firaSans(
                        color: Colors.indigo.shade600,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  regController.emailState.value == regController.enums[0]
                      ? const Expanded(
                          flex: 1,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : regController.emailState.value == regController.enums[1]
                          ? const Expanded(
                              child: Center(
                                child: Icon(
                                  Icons.done,
                                  color: Colors.green,
                                ),
                              ),
                              flex: 1,
                            )
                          : regController.emailState.value ==
                                  regController.enums[2]
                              ? const Expanded(
                                  child: Center(
                                    child: Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                  ),
                                  flex: 1,
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: TextField(
                enabled: !regController.isEnable.value,
                controller: regController.passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      regController.showHidePassword();
                    },
                    icon: FaIcon(
                      regController.hidePassword.isTrue
                          ? FontAwesomeIcons.eye
                          : FontAwesomeIcons.eyeSlash,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.password,
                    color: Colors.indigo.shade600,
                  ),
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  focusColor: Colors.indigo.shade600,
                ),
                obscureText: regController.hidePassword.value,
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            regController.isLoading.isTrue
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : StylishButton(
                    onTap: () async {
                      await regController.performRegistration();
                      Get.offAndToNamed('/verify');
                    },
                    text: 'Signup'),
            regController.isLoading.isTrue
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Already have an account ? login here',
                        style: GoogleFonts.firaSans(
                          color: Colors.green,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      );
    });
  }
}
