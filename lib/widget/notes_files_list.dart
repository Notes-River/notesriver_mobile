import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/constrance/ThemeData.dart';
import 'package:notesriver_mobile/models/readlist.model.dart';
import 'package:notesriver_mobile/widget/stylish_button.dart';

class NotesFilesList extends StatefulWidget {
  NotesFilesList({
    Key? key,
    required this.files,
    required this.readList,
    required this.token,
  }) : super(key: key);
  List<String> files;
  ReadList readList;
  String token;

  @override
  State<NotesFilesList> createState() => _NotesFilesListState();
}

class _NotesFilesListState extends State<NotesFilesList> {
  late List<String> local_files = [];
  bool showMore = false;
  bool flag = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.files.length > 4) {
      showMore = true;
      flag = true;
      for (var i = 0; i < 4; i++) {
        local_files.add(widget.files[i]);
      }
    } else {
      showMore = false;
      flag = false;
      local_files = widget.files;
    }
  }

  showMoreList() {
    local_files = [];
    if (showMore) {
      if (flag) {
        setState(() {
          flag = false;
          local_files = widget.files;
        });
      } else {
        setState(() {
          flag = true;

          for (var i = 0; i < 4; i++) {
            local_files.add(widget.files[i]);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: local_files
              .map(
                (e) => Card(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10),
                    color: CustomThemes.lightBG,
                    height: 40,
                    width: double.infinity,
                    child: InkWell(
                      focusColor: Colors.indigo.shade400,
                      splashColor: Colors.indigo.shade400,
                      highlightColor: Colors.indigo.shade400,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/pdf',
                          arguments: {
                            "readList": widget.readList,
                            "file": e,
                            "files": local_files,
                            "token": widget.token,
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Image(
                            image: AssetImage("assets/pdf.png"),
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              e.split('/').last,
                              style: GoogleFonts.firaSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        showMore
            ? flag
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                          text: '+' +
                              (widget.files.length - 4).toString() +
                              ' more file',
                          children: [
                            widget.files.length - 4 == 1
                                ? TextSpan(text: '')
                                : TextSpan(text: 's')
                          ],
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showMoreList();
                            },
                          style: GoogleFonts.firaSans(
                            color: Colors.indigo.shade500,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      showMoreList();
                    },
                    child: Text('show less'),
                  )
            : SizedBox(
                height: 0,
                width: 0,
              )
      ],
    );
  }
}
