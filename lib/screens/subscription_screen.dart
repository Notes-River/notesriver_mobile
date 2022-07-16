import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesriver_mobile/widget/stylishUploader.dart';
import 'package:notesriver_mobile/widget/stylish_readlist.dart';
import 'package:notesriver_mobile/widget/stylistpage_poper.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({Key? key}) : super(key: key);
  List<String> data = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  Future<Null> _refresh() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Subscription',
          style: GoogleFonts.firaSans(
            color: Colors.indigo.shade600,
            fontWeight: FontWeight.w400,
          ),
        ),
        leading: StylishPagePopper(),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Text('Subscription'),
      ),
    );
  }
}
