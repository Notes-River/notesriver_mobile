import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/constrance/ThemeData.dart';
import 'package:notesriver_mobile/src/controllers/home_controller.dart';
import 'package:notesriver_mobile/src/controllers/profile_controller.dart';
import 'package:notesriver_mobile/src/controllers/storage_controller.dart';
import 'package:notesriver_mobile/widget/notes_items.dart';
import 'package:notesriver_mobile/widget/stylishUploader.dart';
import 'package:notesriver_mobile/widget/stylistpage_poper.dart';

class ProfileScreens extends StatelessWidget {
  ProfileScreens({Key? key}) : super(key: key);

  int index = -1;

  @override
  Widget build(BuildContext context) {
    StorageController storageController = Get.find<StorageController>();
    HomeController homeController = Get.find<HomeController>();
    return GetX<ProfileController>(builder: (profileController) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: StylishPagePopper(),
          title: Text(
            'Profile',
            style: GoogleFonts.firaSans(
                color: Colors.indigo.shade600, fontWeight: FontWeight.w400),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: profileController.refreshProfile,
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 50,
                  child: FaIcon(
                    FontAwesomeIcons.userAlt,
                    color: Colors.indigo.shade600,
                    size: 45,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                child: Text(
                  storageController.profile.value.name,
                  style: GoogleFonts.firaSans(
                      color: Colors.indigo.shade700, fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 3,
                  left: 10,
                  right: 10,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.indigo.shade600,
                  ),
                  title: Text(
                    'Username',
                    style: GoogleFonts.firaSans(
                        fontSize: 15,
                        color: Colors.indigo.shade600,
                        fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    storageController.profile.value.username,
                    style: GoogleFonts.firaSans(color: Colors.black54),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 3),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.indigo.shade600,
                  ),
                  title: Text(
                    'Email',
                    style: GoogleFonts.firaSans(
                        fontSize: 15,
                        color: Colors.indigo.shade600,
                        fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    storageController.profile.value.email,
                    style: GoogleFonts.firaSans(color: Colors.black54),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10, bottom: 0),
                child: ListTile(
                  leading: Icon(
                    Icons.verified,
                    color: Colors.indigo.shade600,
                  ),
                  title: Text(
                    'Status',
                    style: GoogleFonts.firaSans(
                        fontSize: 15,
                        color: Colors.indigo.shade600,
                        fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    storageController.profile.value.status == true
                        ? 'verified'
                        : 'Not Verified',
                    style: GoogleFonts.firaSans(color: Colors.black54),
                  ),
                ),
              ),
              StylishUploader(
                onTap: () {
                  Navigator.of(context).pushNamed('/gen-notes');
                },
                text: 'Want to upload notes',
              ),
              ...storageController.notes.value
                  .map(
                    (e) => NotesItem(
                      homeController: homeController,
                      storageController: storageController,
                      notesModel: e,
                      index: index++,
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      );
    });
  }
}
