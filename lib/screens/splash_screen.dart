import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesriver_mobile/models/user_profile.model.dart';
import 'package:notesriver_mobile/src/HttpException.dart';
import 'package:notesriver_mobile/src/controllers/api_controller.dart';
import 'package:notesriver_mobile/src/controllers/storage_controller.dart';
import 'package:notesriver_mobile/src/controllers/ui_widget_controller.dart';
import 'package:notesriver_mobile/widget/stylish_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeScreen();
  }

  changeScreen() async {
    StorageController storageController = Get.find<StorageController>();
    ApiController apiController = Get.find<ApiController>();
    UIWidgetController uiWidgetController = Get.find<UIWidgetController>();
    await storageController.getToken();
    if (storageController.token.isEmpty) {
      Navigator.of(context).popAndPushNamed('/login');
    } else {
      try {
        await apiController.getUserProfile(notes: false);
        if (storageController.profile.value.status == false) {
          Get.offAndToNamed('/verify');
        } else {
          await apiController.getReadLists();
          Get.offAndToNamed('/home');
        }
      } on HttpException catch (e) {
        uiWidgetController.showDialouge(
          context: context,
          text: 'Error !',
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(e.toString()),
                ),
              ),
            ],
          ),
          actions: [
            StylishButton(
              onTap: () {
                Navigator.of(context).pop();
                changeScreen();
              },
              text: 'RETRY',
            ),
            StylishButton(
              onTap: () {
                exit(0);
              },
              text: 'EXIT',
            )
          ],
        );
      } on HttpExceptionWithStatus catch (e) {
        uiWidgetController.showDialouge(
          context: context,
          text: 'Token Expire. Login Again !!',
          widget: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(e.message),
                ),
              ),
            ],
          ),
          actions: [
            StylishButton(
              onTap: () {
                storageController.storeToken(token: '');
                storageController.changeProfileValue(
                  profile: UserProfile(
                      id: '', name: '', username: '', email: '', status: false),
                );
                Get.offAndToNamed('/login');
              },
              text: 'Login',
            ),
            StylishButton(
              onTap: () {
                exit(0);
              },
              text: 'EXIT',
            )
          ],
        );
      } catch (e) {
        uiWidgetController.showDialouge(
          context: context,
          text: 'Error !',
          widget: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.center,
              child: Text(e.toString()),
            ),
          ),
          actions: [
            StylishButton(
              onTap: () {
                Navigator.of(context).pop();
                changeScreen();
              },
              text: 'RETRY',
            ),
            StylishButton(
              onTap: () {
                exit(0);
              },
              text: 'EXIT',
            )
          ],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.center,
              child: Image.asset('assets/notes_river.png',
                  height: 150, width: 150),
            ),
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.indigoAccent,
            ),
          )
        ],
      ),
    );
  }
}
