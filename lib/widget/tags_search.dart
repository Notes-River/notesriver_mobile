// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:notesriver_mobile/constrance/ThemeData.dart';
// import 'package:notesriver_mobile/src/controllers/readlist_controller.dart';

// class TagSercher extends StatelessWidget {
//   TagSercher({
//     Key? key,
//     required this.readListController,
//   }) : super(key: key);
//   ReadListController readListController;
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Container(
//         // height: 370,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               onChanged: (value) {
//                 if (value.contains('#'))
//                   readListController.callGetTagsApi(value);
//                 else
//                   readListController.callGetTagsApi('#' + value);
//               },
//               style: GoogleFonts.firaSans(
//                 color: Colors.indigo.shade600,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 15,
//               ),
//               decoration: InputDecoration(
//                 hintText: 'Enter tag',
//                 border: OutlineInputBorder(),
//                 focusColor: Colors.indigo.shade600,
//               ),
//             ),
//             readListController.tags.length > 0
//                 ? Container(
//                     height: 50,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: readListController.tags.length,
//                       itemBuilder: (context, index) {
//                         return Chip(
//                           backgroundColor: CustomThemes.lightBG,
//                           label: Text(
//                             readListController.tags.value[index],
//                             style: GoogleFonts.firaSans(
//                               color: Colors.indigo.shade500,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           onDeleted: () {
//                             readListController.deleteTagsFromList(
//                                 readListController.tags.value[index]);
//                           },
//                           elevation: 1,
//                           deleteIcon: Icon(
//                             Icons.clear_rounded,
//                             color: Colors.indigo.shade400,
//                             size: 15,
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                 : Container(),
//             readListController.tagsLoading.isTrue
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : SizedBox(
//                     height: 180,
//                     child: ListView.builder(
//                       scrollDirection: Axis.vertical,
//                       itemCount: readListController.searchedTags.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding:
//                               EdgeInsets.only(left: 0, right: 0, bottom: 2),
//                           child: InkWell(
//                             onTap: () {
//                               readListController.addTags(
//                                   readListController.searchedTags.value[index]);
//                             },
//                             child: Container(
//                               height: 47,
//                               width: double.infinity,
//                               color: CustomThemes.lightBG,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: FaIcon(
//                                       FontAwesomeIcons.hashtag,
//                                       color: Colors.indigo.shade500,
//                                     ),
//                                   ),
//                                   Flexible(
//                                     child: Padding(
//                                       padding: EdgeInsets.only(left: 5),
//                                       child: Text(
//                                         readListController
//                                             .searchedTags.value[index],
//                                         style: GoogleFonts.firaSans(
//                                           color: Colors.indigo.shade400,
//                                         ),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     padding:
//                                         EdgeInsets.only(left: 5, right: 10),
//                                     alignment: Alignment.centerRight,
//                                     child: Row(
//                                       children: [
//                                         FaIcon(
//                                           FontAwesomeIcons.fireAlt,
//                                           color: Colors.green.shade600,
//                                           size: 11,
//                                         ),
//                                         Text(
//                                           '1k',
//                                           style: GoogleFonts.firaSans(
//                                               color: Colors.blueGrey,
//                                               fontSize: 11),
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     height: 40,
//                     width: 70,
//                     color: Colors.indigo.shade600,
//                     child: Text(
//                       'Done',
//                       style: GoogleFonts.firaSans(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
//     });
//   }
// }
