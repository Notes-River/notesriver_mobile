import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/models/readlist.model.dart';
import 'package:notesriver_mobile/src/config.dart';

class StylishReadlist extends StatelessWidget {
  StylishReadlist({
    Key? key,
    required this.readList,
    required this.isDig,
  }) : super(key: key);
  bool isDig;
  ReadList readList;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(
              horizontal: BorderSide(color: Colors.indigo.shade50))),
      padding: EdgeInsets.only(left: 10, right: 10),
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
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.indigo.shade600,
                      child: readList.logo == 'N/A'
                          ? const CircleAvatar(
                              radius: 20,
                              child: FaIcon(FontAwesomeIcons.listAlt),
                            )
                          : CircleAvatar(
                              radius: 20,
                              child: Image.network(
                                  Config.serverAdress + '/' + readList.logo,
                                  fit: BoxFit.contain),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            readList.title,
                            style: GoogleFonts.firaSans(
                              color: Colors.indigo.shade600,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            readList.join == null
                                ? '0 subscribers'
                                : readList.join.length.toString() +
                                    ' subscribers',
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
                isDig
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 7),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.file,
                                  color: Colors.indigo.shade500,
                                  size: 12,
                                ),
                                Text(
                                  readList.notes == null
                                      ? '(' + 0.toString()
                                      : '(' +
                                          readList.notes.length.toString() +
                                          ')',
                                  style: GoogleFonts.firaSans(
                                    fontSize: 11,
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.thumb_up_alt_outlined,
                                  color: Colors.indigo.shade500,
                                  size: 13,
                                ),
                                Text(
                                  readList.likedBy == null
                                      ? '(' + 0.toString()
                                      : '(' +
                                          readList.likedBy.length.toString() +
                                          ')',
                                  style: GoogleFonts.firaSans(
                                    fontSize: 11,
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 7),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.thumb_down_alt_outlined,
                                  color: Colors.indigo.shade500,
                                  size: 13,
                                ),
                                Text(
                                  readList.disklikedBy == null
                                      ? '(' + 0.toString()
                                      : '(' +
                                          readList.disklikedBy.length
                                              .toString() +
                                          ')',
                                  style: GoogleFonts.firaSans(
                                    fontSize: 11,
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
