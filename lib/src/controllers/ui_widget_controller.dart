import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UIWidgetController extends GetxController {
  UIWidgetController() {
    print('Binding UI Controller..');
  }

  RxBool logoutProcess = false.obs;

  showDialouge(
      {required BuildContext context,
      required String text,
      required Widget widget,
      required List<Widget> actions}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      useRootNavigator: true,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          title: Text(
            text,
            style: GoogleFonts.firaSans(
              color: Colors.indigo.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          content: widget,
          actions: actions,
        );
      },
    );
  }

  setLogoutProgress({required bool value}) {
    logoutProcess.value = value;
  }

  shoeSnackBar({required BuildContext context, required Widget widget}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: widget,
    ));
  }

  Future<FilePickerResult?> filePicker(
      {required bool multiple,
      required String title,
      required List<String> ext}) async {
    try {
      FilePickerResult? picker = await FilePicker.platform.pickFiles(
        allowMultiple: multiple,
        type: FileType.custom,
        dialogTitle: title,
        allowedExtensions: ext,
      );
      return picker;
    } catch (e) {
      rethrow;
    }
  }
}
