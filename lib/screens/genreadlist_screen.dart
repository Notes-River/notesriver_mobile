import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/constrance/ThemeData.dart';
import 'package:notesriver_mobile/src/controllers/readlist_controller.dart';
import 'package:notesriver_mobile/src/controllers/ui_widget_controller.dart';
import 'package:notesriver_mobile/widget/stylistpage_poper.dart';

class GenReadListScreen extends StatelessWidget {
  GenReadListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIWidgetController uiWidgetController = Get.find<UIWidgetController>();
    return GetX<ReadListController>(builder: (crlController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: StylishPagePopper(),
          title: Text(
            'Create Readlist',
            style: GoogleFonts.firaSans(
              color: Colors.indigo.shade600,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 5,
                left: 10,
                right: 10,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 100,
                child: TextField(
                  controller: crlController.aboutController,
                  enabled: !crlController.isLoading.value,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Write something about your readlist',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    crlController.filterHastagFromAbout(about: value);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: TextField(
                controller: crlController.titleController,
                enabled: !crlController.isLoading.value,
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'title of readlist',
                  border: const OutlineInputBorder(),
                  focusColor: Colors.indigo.shade600,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 0, left: 10, right: 10),
              child: Card(
                elevation: 0,
                child: InkWell(
                  onTap: () async {
                    FilePickerResult? files =
                        await uiWidgetController.filePicker(
                      ext: ['png'],
                      multiple: false,
                      title: 'Select image for logo (png)',
                    );

                    if (files == null) {
                      uiWidgetController.shoeSnackBar(
                          context: context, widget: Text('Please select file'));
                    } else {
                      crlController.setFileData(
                        file: files.files.single.path as String,
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        crlController.file.value == 'N/A'
                            ? FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.indigo.shade600,
                              )
                            : Container(
                                height: 40,
                                width: 40,
                                // alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(crlController.file.value),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            crlController.file.value == 'N/A'
                                ? 'Select logo for readlist'
                                : 'Change logo',
                            style: GoogleFonts.firaSans(
                              color: Colors.indigo.shade500,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: crlController.file.value != 'N/A'
                                ? InkWell(
                                    onTap: () {
                                      if (crlController.isLoading.isFalse) {
                                        crlController.setFileData(file: 'N/A');
                                      } else {
                                        uiWidgetController.shoeSnackBar(
                                          context: context,
                                          widget: Text('Process started '),
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 4),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.indigo.shade600,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const FaIcon(
                                          FontAwesomeIcons.trashAlt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Card(
                elevation: 0,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      crlController.tags.value.isEmpty
                          ? Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'your tags',
                                style: GoogleFonts.firaSans(
                                    color: Colors.indigo.shade500),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: crlController.tags.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: Chip(
                                      backgroundColor: CustomThemes.lightBG,
                                      label: Text(
                                        crlController.tags.value[index],
                                        style: GoogleFonts.firaSans(
                                          color: Colors.indigo.shade500,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      elevation: 1,
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () async {
                    if (crlController.isLoading.isTrue) {
                      uiWidgetController.shoeSnackBar(
                          context: context,
                          widget: const Text('Already running please wait'));
                    } else {
                      bool isValid = await crlController.validateFields(
                          context: context,
                          uiWidgetController: uiWidgetController);
                      if (isValid) {
                        await crlController.createReadList(
                          context: context,
                          uiWidgetController: uiWidgetController,
                        );
                        Get.back();
                      }
                    }
                  },
                  child: Container(
                    height: 47,
                    alignment: Alignment.center,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.indigo.shade500),
                    child: crlController.isLoading.isTrue
                        ? const CircularProgressIndicator.adaptive()
                        : Text(
                            'Create',
                            style: GoogleFonts.firaSans(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            crlController.isLoading.isTrue
                ? Container()
                : Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).popAndPushNamed('/gen-notes');
                        },
                        child: Text(
                          'already have readlist upload notes',
                          style: GoogleFonts.firaSans(
                            color: Colors.green.shade600,
                          ),
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
