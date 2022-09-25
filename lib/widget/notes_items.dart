import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/models/notes.models.dart';
import 'package:notesriver_mobile/src/HttpException.dart';
import 'package:notesriver_mobile/src/config.dart';
import 'package:notesriver_mobile/src/controllers/home_controller.dart';
import 'package:notesriver_mobile/src/controllers/storage_controller.dart';
import 'package:notesriver_mobile/widget/notes_files_list.dart';

// ignore: must_be_immutable
class NotesItem extends StatefulWidget {
  NotesItem({
    Key? key,
    required this.notesModel,
    required this.homeController,
    required this.storageController,
    required this.index,
  }) : super(key: key);
  NotesModel notesModel;
  HomeController homeController;
  StorageController storageController;
  int index;
  @override
  State<NotesItem> createState() => _NotesItemState();
}

class _NotesItemState extends State<NotesItem> {
  List local_text = [];
  bool flag = false;
  bool showMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.notesModel.desc.length > 80) {
      local_text = widget.notesModel.desc.substring(0, 80).split(' ');
      flag = true;
      showMore = true;
    } else {
      local_text = widget.notesModel.desc.split(' ');
      flag = false;
      showMore = false;
    }
  }

  showMoreAndLess() {
    if (showMore) {
      if (flag) {
        setState(() {
          local_text = widget.notesModel.desc.split(' ');
          flag = false;
        });
      } else {
        setState(() {
          local_text = widget.notesModel.desc.substring(0, 80).split(' ');
          flag = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLiked = widget.notesModel.likedBy
        .contains(widget.storageController.profile.value.id);
    int likedLen = widget.notesModel.likedBy.length;
    bool isDisliked = widget.notesModel.dislikedBy
        .contains(widget.storageController.profile.value.id);
    int dislikedLen = widget.notesModel.dislikedBy.length;

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('/readlist-info');
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.indigo.shade600,
                            width: 2,
                          ),
                        ),
                        child: widget.notesModel.readList.logo == 'N/A'
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset('assets/notes_river.png'),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                  Config.serverAdress +
                                      '/' +
                                      widget.notesModel.readList.logo,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.notesModel.readList.title,
                            style: GoogleFonts.firaSans(
                              color: Colors.indigo.shade600,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'at ' + widget.notesModel.createAt,
                            style: GoogleFonts.firaSans(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Obx(() {
                  return IconButton(
                    onPressed: () async {
                      try {
                        widget.homeController.addToFav(index: widget.index);
                      } on HttpException catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.message)));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())));
                      }
                    },
                    icon: widget.storageController.favNotesIds.value
                            .contains(widget.notesModel.id)
                        ? Icon(
                            Icons.favorite,
                            color: Colors.indigo.shade400,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.indigo.shade400,
                          ),
                  );
                }),
              ],
            ),
          ),

          //Body Title
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 5),
            child: Text(
              widget.notesModel.title,
              style: GoogleFonts.firaSans(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: RichText(
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    children: local_text
                        .map(
                          (e) => e.contains('#')
                              ? TextSpan(
                                  text: e + ' ',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      print(e);
                                    },
                                  style: GoogleFonts.firaSans(
                                    color: Colors.indigo.shade600,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : TextSpan(
                                  text: e + ' ',
                                  style: GoogleFonts.firaSans(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                        )
                        .toList(),
                  ),
                  showMore
                      ? flag
                          ? TextSpan(
                              text: ' show more',
                              style: GoogleFonts.firaSans(
                                color: Colors.indigo.shade500,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showMoreAndLess();
                                })
                          : TextSpan(
                              text: ' show less',
                              style: GoogleFonts.firaSans(
                                color: Colors.indigo.shade500,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showMoreAndLess();
                                })
                      : const TextSpan(text: ''),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: NotesFilesList(
              token: widget.storageController.token.value,
              readList: widget.notesModel.readList,
              files: widget.notesModel.filePath,
            ),
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    try {
                      widget.homeController.likePost(index: widget.index);
                    } on HttpException catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.message)));
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  icon: Icon(
                    isLiked ? Icons.thumb_up_alt : Icons.thumb_up_alt_outlined,
                    color: Colors.indigo.shade600,
                  ),
                  label: Text(
                    likedLen.toString(),
                    style: GoogleFonts.firaSans(
                      color: Colors.indigo.shade600,
                      fontWeight: isLiked ? FontWeight.bold : FontWeight.w400,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () async {
                    try {
                      widget.homeController.dislikePost(index: widget.index);
                    } on HttpException catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.message)));
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  icon: Icon(
                    isDisliked
                        ? Icons.thumb_down_alt
                        : Icons.thumb_down_alt_outlined,
                    color: Colors.indigo.shade600,
                  ),
                  label: Text(
                    dislikedLen.toString(),
                    style: GoogleFonts.firaSans(
                      color: Colors.indigo.shade600,
                      fontWeight:
                          isDisliked ? FontWeight.bold : FontWeight.w400,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.report,
                    color: Colors.indigo.shade600,
                  ),
                  label: Text(
                    'Report',
                    style: GoogleFonts.firaSans(
                      color: Colors.indigo.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLiked
              ? SizedBox(
                  height: 20,
                  child: Container(
                    padding: const EdgeInsets.only(left: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Liked by you' +
                          (likedLen > 1
                              ? ' and ' +
                                  widget.notesModel.likedBy.length.toString() +
                                  ' others'
                              : ''),
                      style: GoogleFonts.firaSans(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
