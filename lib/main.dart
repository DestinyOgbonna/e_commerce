import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/landingpage.dart';

void main() {
  runApp( ECommerce());
}

// ignore: use_key_in_widget_constructors
class ECommerce extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,
      //assigning a custom text to the whole application
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        accentColor:const Color(0xffff1e00),
      ),
      home: LandPage(),
    );
  }
}
