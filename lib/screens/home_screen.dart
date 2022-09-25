import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/src/controllers/home_controller.dart';
import 'package:notesriver_mobile/src/controllers/storage_controller.dart';
import 'package:notesriver_mobile/src/controllers/ui_widget_controller.dart';
import 'package:notesriver_mobile/widget/notes_items.dart';
import 'package:notesriver_mobile/widget/stylishUploader.dart';
import 'package:notesriver_mobile/widget/stylish_button.dart';
import 'package:notesriver_mobile/widget/stylish_drawer.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late HomeController _homeController;
  late UIWidgetController _uiWidgetController;

  Future<Null> _refresh() async {
    await _homeController.loadNotes();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeController = Get.find<HomeController>();
    _uiWidgetController = Get.find<UIWidgetController>();
    _refresh();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _homeController.dispose();
    _uiWidgetController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StorageController storageController = Get.find<StorageController>();
    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/notes_river.png',
          height: 50,
          width: 50,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _key.currentState!.openDrawer();
          },
          icon: FaIcon(
            FontAwesomeIcons.userAlt,
            color: Colors.indigo.shade600,
          ),
        ),
        actions: [
          Badge(
            animationDuration: const Duration(milliseconds: 300),
            animationType: BadgeAnimationType.slide,
            position: BadgePosition.topEnd(top: 2, end: 2),
            badgeColor: Colors.red,
            elevation: 0,
            shape: BadgeShape.circle,
            badgeContent: Text(
              10.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10),
            ),
            child: IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.bell,
                color: Colors.indigo.shade600,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        return _homeController.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _homeController.isError.isTrue
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            _homeController.errorMessage,
                            style: GoogleFonts.firaSans(color: Colors.red),
                          ),
                        ),
                      ),
                      StylishButton(
                        onTap: () {
                          _refresh();
                        },
                        text: "Retry",
                      )
                    ],
                  )
                : Column(
                    children: [
                      StylishUploader(
                        text: 'Want to upload notes',
                        onTap: () {
                          Navigator.of(context).pushNamed('/gen-notes');
                        },
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          child: storageController.notes.isNotEmpty
                              ? ListView.builder(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  itemBuilder: (context, index) {
                                    return NotesItem(
                                      index: index,
                                      homeController: _homeController,
                                      storageController: storageController,
                                      notesModel:
                                          storageController.notes.value[index],
                                    );
                                  },
                                  itemCount: storageController.notes.length,
                                )
                              : ListView(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'No Post found',
                                        style: GoogleFonts.firaSans(
                                          color: Colors.indigo.shade400,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: TextButton(
                                        onPressed: _refresh,
                                        child: Text(
                                          'Reload',
                                          style: GoogleFonts.firaSans(
                                            color: Colors.indigo.shade400,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                          onRefresh: _refresh,
                        ),
                      )
                    ],
                  );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo.shade600,
        onPressed: () {},
        child: const FaIcon(
          FontAwesomeIcons.search,
          color: Colors.white,
        ),
      ),
      drawer: StylishDrawer(
        storageController: storageController,
      ),
    );
  }
}
