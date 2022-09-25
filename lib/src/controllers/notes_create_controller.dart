// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notesriver_mobile/models/readlist.model.dart';
import 'package:notesriver_mobile/src/HttpException.dart';
import 'package:notesriver_mobile/src/controllers/api_controller.dart';
import 'package:notesriver_mobile/src/controllers/storage_controller.dart';

class NotesCreateController extends GetxController {
  late StorageController _storageController;
  late ApiController _apiController;

  TextEditingController aboutController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  RxBool isLoading = false.obs;
  RxList tags = [].obs;
  RxList files = [].obs;

  RxBool isError = false.obs;
  String errorMessage = '';

  Rx<ReadList> selectedRl = ReadList(
    notes: [],
    likedBy: [],
    disklikedBy: [],
    tags: [],
    join: [],
    id: 'N/A',
    title: 'N/A',
    logo: 'N/A',
    user: 'N/A',
  ).obs;
  RxList readLists = [].obs;

  NotesCreateController() {
    _storageController = Get.find<StorageController>();
    readLists.value = _storageController.readLists.value;
    _apiController = Get.find<ApiController>();
  }

  createNotes({required Function cb}) async {
    try {
      isLoading.value = true;
      bool isValid = validateFields();
      if (isValid) {
        await _apiController.createPost(
          title: titleController.text,
          about: aboutController.text,
          tags: tags.value,
          files: files.value,
          id: selectedRl.value.id,
        );
        emptyFilesValue();
        emptySelectedRl();
        tags.value = [];
        titleController.text = '';
        aboutController.text = '';
        cb();
      }
      isLoading.value = false;
    } on HttpException catch (e) {
      showError(error: e.message);
    } catch (e) {
      showError(error: e.toString());
    }
  }

  bool validateFields() {
    if (titleController.text.isEmpty) {
      showError(error: 'Please enter title for you notes');
      return false;
    } else if (files.value.isEmpty) {
      showError(error: 'Please select notes (pdf formate)');
      return false;
    } else if (selectedRl.value.id == 'N/A') {
      showError(error: 'Please select readlist');
      return false;
    } else {
      return true;
    }
  }

  showError({required String error}) {
    errorMessage = error;
    isError.value = true;
    Timer(Duration(seconds: 4), () {
      isLoading.value = false;
      isError.value = false;
    });
  }

  setFilesValue({required List<String> list}) {
    files.value = list;
  }

  emptyFilesValue() {
    files.value = [];
  }

  emptySelectedRl() {
    selectedRl.value = ReadList(
      notes: [],
      likedBy: [],
      disklikedBy: [],
      tags: [],
      join: [],
      id: 'N/A',
      title: 'N/A',
      logo: 'N/A',
      user: 'N/A',
    );
  }

  setSelectedReadList({required ReadList readList}) {
    selectedRl.value = readList;
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
}
