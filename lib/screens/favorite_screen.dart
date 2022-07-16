import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/src/controllers/home_controller.dart';
import 'package:notesriver_mobile/src/controllers/storage_controller.dart';
import 'package:notesriver_mobile/widget/notes_items.dart';
import 'package:notesriver_mobile/widget/stylishUploader.dart';
import 'package:notesriver_mobile/widget/stylistpage_poper.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late StorageController _storageController;
  late HomeController _homeController;

  Future<Null> _refrsh() async {
    _homeController.fetchAllFav();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storageController = Get.find<StorageController>();
    _homeController = Get.find<HomeController>();
    _refrsh();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Favorite',
          style: GoogleFonts.firaSans(
            color: Colors.indigo.shade600,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: StylishPagePopper(),
      ),
      body: RefreshIndicator(
        child: Obx(() {
          return _homeController.isFavLoading.isTrue
              ? const Center(child: CircularProgressIndicator())
              : _homeController.isFavError.isTrue
                  ? Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child:
                              Icon(Icons.error, color: Colors.indigo.shade400),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            _homeController.isFavErrorMsg,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.firaSans(
                              color: Colors.indigo.shade400,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: _refrsh,
                            child: Text('Reload'),
                          ),
                        )
                      ],
                    )
                  : _storageController.favNotes.isNotEmpty
                      ? ListView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          children: [
                            StylishUploader(
                              text: 'Want to upload notes',
                              onTap: () {},
                            ),
                            ..._storageController.favNotes.value.map((e) {
                              index++;
                              return NotesItem(
                                homeController: _homeController,
                                notesModel: e,
                                storageController: _storageController,
                                index: index,
                              );
                            }).toList(),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                'No Notes found',
                                style: GoogleFonts.firaSans(
                                  color: Colors.indigo.shade400,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: _refrsh,
                                child: Text('Reload'),
                              ),
                            )
                          ],
                        );
        }),
        onRefresh: _refrsh,
      ),
    );
  }
}
