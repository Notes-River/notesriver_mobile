import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StylishHeaderText extends StatelessWidget {
  StylishHeaderText({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.showLogo,
    required this.showHeader,
  }) : super(key: key);
  String firstText;
  String secondText;
  bool showLogo;
  bool showHeader;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        showHeader
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        firstText,
                        style: GoogleFonts.firaSans(
                          color: Colors.indigo.shade600,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        secondText,
                        style: GoogleFonts.firaSans(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
        showLogo
            ? Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/notes_river.png',
                  height: 80,
                  width: 80,
                ),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              ),
      ],
    );
  }
}
