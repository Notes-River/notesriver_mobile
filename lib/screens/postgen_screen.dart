import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/constrance/ThemeData.dart';
import 'package:notesriver_mobile/src/config.dart';
import 'package:notesriver_mobile/src/controllers/notes_create_controller.dart';
import 'package:notesriver_mobile/src/controllers/ui_widget_controller.dart';
import 'package:notesriver_mobile/widget/stylish_readlist.dart';
import 'package:notesriver_mobile/widget/stylistpage_poper.dart';

class PostGenScreen extends StatelessWidget {
  const PostGenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UIWidgetController uiWidgetController = Get.find<UIWidgetController>();

    return GetX<NotesCreateController>(builder: (ncController) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: StylishPagePopper(),
          title: Text(
            'Upload Notes',
            style: GoogleFonts.firaSans(
              color: Colors.indigo.shade600,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: Column(
          children: [
            ncController.isError.isTrue
                ? Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        ncController.errorMessage,
                        style: GoogleFonts.firaSans(color: Colors.red),
                      ),
                    ),
                  )
                : Container(),
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
                height: 150,
                child: TextField(
                  enabled: !ncController.isLoading.value,
                  controller: ncController.aboutController,
                  expands: true,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Write something about notes.',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    ncController.filterHastagFromAbout(about: value);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5),
              child: TextField(
                enabled: !ncController.isLoading.value,
                controller: ncController.titleController,
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'title of notes',
                  border: OutlineInputBorder(),
                  focusColor: Colors.indigo.shade600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 0, left: 10, right: 10),
              child: Card(
                elevation: 0,
                child: InkWell(
                  onTap: () async {
                    FilePickerResult? files =
                        await uiWidgetController.filePicker(
                      multiple: true,
                      title: 'Select Notes',
                      ext: ['pdf'],
                    );
                    if (files == null) {
                      uiWidgetController.shoeSnackBar(
                        context: context,
                        widget: Text('Please select notes for upload'),
                      );
                    } else {
                      ncController.setFilesValue(
                        list:
                            files.files.map((e) => e.path.toString()).toList(),
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
                        FaIcon(
                          FontAwesomeIcons.fileAlt,
                          color: Colors.indigo.shade600,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            ncController.files.isNotEmpty
                                ? ncController.files.value.length.toString() +
                                    ' files are selected (PDF formate) '
                                : 'Select files (PDF formate)',
                            style: GoogleFonts.firaSans(
                              color: Colors.indigo.shade500,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: ncController.files.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      if (ncController.isLoading.isFalse) {
                                        ncController.emptyFilesValue();
                                      } else {
                                        uiWidgetController.shoeSnackBar(
                                          context: context,
                                          widget: Text('Process started '),
                                        );
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.indigo.shade600,
                                      ),
                                      child: const FaIcon(
                                        FontAwesomeIcons.trashAlt,
                                        color: Colors.white,
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
              padding: EdgeInsets.only(top: 0, bottom: 5, left: 10, right: 10),
              child: Card(
                elevation: 0,
                child: InkWell(
                  onTap: () {
                    uiWidgetController.showDialouge(
                      context: context,
                      text: 'Select Readlist',
                      widget: SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                ncController.setSelectedReadList(
                                  readList: ncController.readLists.value[index],
                                );
                                Navigator.of(context).pop();
                              },
                              child: StylishReadlist(
                                isDig: false,
                                readList: ncController.readLists.value[index],
                              ),
                            );
                          },
                          itemCount: ncController.readLists.length,
                        ),
                      ),
                      actions: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Okay'),
                        )
                      ],
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ncController.selectedRl.value.id == 'N/A'
                            ? FaIcon(
                                FontAwesomeIcons.book,
                                color: Colors.indigo.shade600,
                              )
                            : ncController.selectedRl.value.logo == 'N/A'
                                ? FaIcon(
                                    FontAwesomeIcons.listAlt,
                                    color: Colors.indigo.shade600,
                                  )
                                : Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    child: Image.network(
                                      Config.serverAdress +
                                          '/' +
                                          ncController.selectedRl.value.logo,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            ncController.selectedRl.value.id == 'N/A'
                                ? 'Select readlist'
                                : ncController.selectedRl.value.title,
                            style: GoogleFonts.firaSans(
                              color: Colors.indigo.shade500,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: ncController.selectedRl.value.id != 'N/A'
                                ? InkWell(
                                    onTap: () {
                                      if (ncController.isLoading.isFalse) {
                                        ncController.emptySelectedRl();
                                      } else {
                                        uiWidgetController.shoeSnackBar(
                                          context: context,
                                          widget: Text('Process started '),
                                        );
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.indigo.shade600,
                                      ),
                                      child: const FaIcon(
                                        FontAwesomeIcons.trashAlt,
                                        color: Colors.white,
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
                      ncController.tags.value.isEmpty
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
                                itemCount: ncController.tags.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: Chip(
                                      backgroundColor: CustomThemes.lightBG,
                                      label: Text(
                                        ncController.tags.value[index],
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
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    if (ncController.isLoading.isTrue) {
                      uiWidgetController.shoeSnackBar(
                        context: context,
                        widget: Text('Process already running please wait'),
                      );
                    } else {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ncController.createNotes(cb: () {
                        uiWidgetController.shoeSnackBar(
                          context: context,
                          widget: const Text('Your Notes uploaded'),
                        );
                      });
                    }
                  },
                  child: Container(
                    height: 47,
                    alignment: Alignment.center,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.indigo.shade500),
                    child: ncController.isLoading.isTrue
                        ? CircularProgressIndicator()
                        : Text(
                            'Upload',
                            style: GoogleFonts.firaSans(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            ncController.isLoading.isTrue
                ? Container()
                : Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .popAndPushNamed('/gen-readlist');
                        },
                        child: Text(
                          'don\'t have readlist create one',
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
