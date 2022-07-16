import 'package:flutter/material.dart';

class StylishPagePopper extends StatelessWidget {
  const StylishPagePopper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.indigo.shade600,
      ),
    );
  }
}
