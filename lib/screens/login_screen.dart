import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/src/controllers/login_controller.dart';
import 'package:notesriver_mobile/widget/stylish_button.dart';
import 'package:notesriver_mobile/widget/stylishheader_text.dart';
import 'package:notesriver_mobile/widget/stylistpage_poper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(builder: (logController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Navigator.canPop(context) == true
              ? StylishPagePopper()
              : Container(),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StylishHeaderText(
              firstText: 'Log',
              secondText: 'IN',
              showLogo: true,
              showHeader: true,
            ),
            logController.showError.isTrue
                ? Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      logController.errorMessage,
                      style: GoogleFonts.firaSans(
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              child: TextField(
                controller: logController.usernameController,
                enabled: !logController.isEnabled.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.indigo.shade600,
                  ),
                  labelText: 'username or email',
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
              child: TextField(
                controller: logController.passwordController,
                enabled: !logController.isEnabled.value,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      logController.showHidePassword();
                    },
                    icon: logController.hidePassword.isTrue
                        ? FaIcon(
                            FontAwesomeIcons.eye,
                          )
                        : FaIcon(
                            FontAwesomeIcons.eyeSlash,
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
                obscureText: logController.hidePassword.value,
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            value: logController.remember.value,
                            onChanged: (value) {
                              logController.changeRememberValue(value: value!);
                            }),
                        Text(
                          'remember me',
                          style: GoogleFonts.firaSans(
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    logController.isLoading.isFalse
                        ? TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot password',
                              style: GoogleFonts.firaSans(
                                color: Colors.indigo.shade600,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            ),
                          )
                        : Container(
                            height: 0,
                            width: 0,
                          ),
                  ],
                ),
              ),
            ),
            logController.isLoading.isTrue
                ? Center(child: CircularProgressIndicator())
                : StylishButton(
                    onTap: () async {
                      await logController.performLogin();
                      if (logController.verify.isTrue) {
                        Navigator.of(context).popAndPushNamed('/verify');
                      } else {
                        if (logController.showError.isFalse) {
                          Navigator.of(context).popAndPushNamed('/home');
                        }
                      }
                    },
                    text: 'Login',
                  ),
            logController.isLoading.isTrue
                ? Container()
                : Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed('/signup');
                      },
                      child: Text(
                        'I don\'t have account ? create one',
                        style: GoogleFonts.firaSans(
                          color: Colors.green,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
          ],
        ),
      );
    });
  }
}
