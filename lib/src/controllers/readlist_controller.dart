import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesriver_mobile/src/controllers/api_controller.dart';
import 'package:notesriver_mobile/src/controllers/ui_widget_controller.dart';

class ReadListController extends GetxController {
  late ApiController _apiController;
  RxList tags = [].obs;
  RxBool tagsLoading = false.obs;
  RxList searchedTags = [].obs;
  RxString file = 'N/A'.obs;
  RxBool isLoading = false.obs;

  String oldText = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  ReadListController() {
    _apiController = Get.find<ApiController>();
  }

  createReadList(
      {required BuildContext context,
      required UIWidgetController uiWidgetController}) async {
    isLoading.value = true;
    try {
      await _apiController.createReadList(
        title: titleController.text,
        about: aboutController.text,
        path: file.value == 'N/A' ? null : file.value,
        tags: tags.isNotEmpty ? tags.value : null,
      );
      isLoading.value = false;
      uiWidgetController.shoeSnackBar(
          context: context, widget: Text('Readlist created'));
    } on HttpException catch (e) {
      isLoading.value = false;
      uiWidgetController.shoeSnackBar(
          context: context, widget: Text(e.message));
    } catch (e) {
      isLoading.value = false;
      uiWidgetController.shoeSnackBar(
          context: context, widget: Text(e.toString()));
    }
  }

  filterHastagFromAbout({required String about}) {
    List<String> t = [];
    about = about.replaceAll('\n', ' ');
    if (about.contains('#')) {
      List<String> a = about.split(' ');
      for (var element in a) {
        if (element.isNotEmpty) {
          if (element[0] == '#') {
            t.add(element);
          }
        }
      }
    }

    tags.value = t;
  }

  Future<bool> validateFields(
      {required BuildContext context,
      required UIWidgetController uiWidgetController}) async {
    if (titleController.text.isEmpty) {
      uiWidgetController.shoeSnackBar(
        context: context,
        widget: Text('Please enter valid title'),
      );
      return false;
    } else if (aboutController.text.isEmpty) {
      uiWidgetController.shoeSnackBar(
        context: context,
        widget: Text('Please enter valid details'),
      );
      return false;
    } else {
      return true;
    }
  }

  setFileData({required String file}) {
    this.file.value = file;
  }
}
