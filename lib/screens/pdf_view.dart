import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/models/readlist.model.dart';
import 'package:notesriver_mobile/src/config.dart';
import 'package:notesriver_mobile/widget/stylistpage_poper.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  const PdfView({Key? key}) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context)?.settings.arguments as Map;
    ReadList readList = data['readList'] as ReadList;
    String activeFile = data['file'] as String;
    List<String> totalFiles = data['files'] as List<String>;
    String token = data['token'] as String;
    return Scaffold(
      appBar: AppBar(
        leading: StylishPagePopper(),
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            readList.title,
            style: GoogleFonts.firaSans(
              color: Colors.indigo.shade600,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              activeFile = totalFiles[index];
            });
          },
          physics: const ScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          children: totalFiles
              .map(
                (e) => SfPdfViewer.network(
                  Config.serverAdress +
                      '/notes/download-notes?path=' +
                      e +
                      '&token=' +
                      token,
                  canShowScrollHead: true,
                  initialZoomLevel: 1.0,
                  enableDocumentLinkAnnotation: true,
                  enableTextSelection: true,
                  scrollDirection: PdfScrollDirection.vertical,
                  canShowScrollStatus: true,
                  pageSpacing: 4.0,
                  onDocumentLoadFailed: (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Document load failed'),
                    ));
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
