// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/src/HttpException.dart';
import 'package:notesriver_mobile/src/controllers/get_readlist_controller.dart';
import 'package:notesriver_mobile/widget/stylishUploader.dart';
import 'package:notesriver_mobile/widget/stylish_readlist.dart';
import 'package:notesriver_mobile/widget/stylistpage_poper.dart';

class ReadListScreen extends StatefulWidget {
  ReadListScreen({Key? key}) : super(key: key);

  @override
  State<ReadListScreen> createState() => _ReadListScreenState();
}

class _ReadListScreenState extends State<ReadListScreen> {
  Future<Null> _refrsh() async {
    loadlist();
  }

  late ReadlistUtils _readlistUtils;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadlist();
  }

  loadlist() async {
    _readlistUtils = Get.find<ReadlistUtils>();
    try {
      await _readlistUtils.loadReadLists();
    } on HttpException catch (e) {
      print(e.message);
    } catch (e) {
      print('here');
      print(e);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _readlistUtils.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<ReadlistUtils>(builder: (rc) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Readlist',
            style: GoogleFonts.firaSans(
              color: Colors.indigo.shade600,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: StylishPagePopper(),
        ),
        body: rc.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: _refrsh,
                child: ListView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    StylishUploader(
                      onTap: () {
                        Get.toNamed('/gen-readlist');
                      },
                      text: 'Want to create readlist',
                    ),
                    if (rc.readLists.value.isNotEmpty)
                      ...rc.readLists.value
                          .map(
                            (e) => StylishReadlist(
                              readList: e,
                              isDig: true,
                            ),
                          )
                          .toList(),
                    if (rc.readLists.value.isEmpty)
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.3),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: FaIcon(
                                FontAwesomeIcons.stickyNote,
                                size: 30,
                                color: Colors.indigo.shade600,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Empty Please create one',
                                style: GoogleFonts.firaSans(
                                  color: Colors.indigo.shade600,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
      );
    });
  }
}
