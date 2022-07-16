import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/constrance/ThemeData.dart';
import 'package:notesriver_mobile/src/HttpException.dart';
import 'package:notesriver_mobile/src/controllers/api_controller.dart';
import 'package:notesriver_mobile/src/controllers/storage_controller.dart';
import 'package:notesriver_mobile/src/controllers/ui_widget_controller.dart';
import 'package:notesriver_mobile/widget/stylish_button.dart';

class StylishDrawer extends StatelessWidget {
  StylishDrawer({
    Key? key,
    required this.storageController,
  }) : super(key: key);
  StorageController storageController;
  @override
  Widget build(BuildContext context) {
    ApiController apiController = Get.find<ApiController>();
    return GetX<UIWidgetController>(builder: (uiController) {
      return Drawer(
        backgroundColor: CustomThemes.lightBG,
        child: Column(
          children: [
            Container(
              color: Colors.indigo.shade600,
              child: DrawerHeader(
                child: Container(
                  padding: EdgeInsets.only(left: 5, bottom: 5),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    storageController.profile.value.name,
                    style: GoogleFonts.firaSans(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              focusColor: Colors.indigo.shade300,
              hoverColor: Colors.indigo.shade300,
              onTap: () {
                Get.toNamed('/profile');
              },
              leading: FaIcon(
                FontAwesomeIcons.user,
                color: Colors.indigo.shade600,
              ),
              title: Text(
                'Profile',
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/read-list');
              },
              leading: FaIcon(
                FontAwesomeIcons.listUl,
                color: Colors.indigo.shade600,
              ),
              title: Text(
                'Readlists',
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/read-list');
              },
              leading: FaIcon(
                FontAwesomeIcons.listOl,
                color: Colors.indigo.shade600,
              ),
              title: Text(
                'My Readlists',
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/subs');
              },
              leading: FaIcon(
                FontAwesomeIcons.fileAlt,
                color: Colors.indigo.shade600,
              ),
              title: Text(
                'Subscription',
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed('/fav');
              },
              leading: Icon(
                Icons.favorite_outline,
                color: Colors.indigo.shade600,
              ),
              title: Text(
                'Favorite',
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.request_quote_outlined,
                color: Colors.indigo.shade600,
              ),
              title: Text(
                'Request Notes',
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Divider(
              color: Colors.indigo.shade600,
            ),
            ListTile(
              leading: Icon(
                Icons.feedback_outlined,
                color: Colors.indigo.shade600,
              ),
              title: Text(
                'Feedback',
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.report_gmailerrorred_outlined,
                color: Colors.indigo.shade600,
              ),
              title: Text(
                'Report',
                style: GoogleFonts.firaSans(
                  color: Colors.indigo.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                try {
                  await apiController.logoutUser();
                  Get.offAllNamed('/login');
                } on HttpException catch (e) {
                  uiController.showDialouge(
                    context: context,
                    text: 'Error !',
                    widget: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              e.message,
                              style: GoogleFonts.firaSans(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      StylishButton(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        text: 'BACK',
                      )
                    ],
                  );
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              leading: Icon(
                Icons.logout,
                color: Colors.indigo.shade600,
              ),
              title: uiController.logoutProcess.isTrue
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      'Logout',
                      style: GoogleFonts.firaSans(
                        color: Colors.indigo.shade600,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
            ),
          ],
        ),
      );
    });
  }
}
