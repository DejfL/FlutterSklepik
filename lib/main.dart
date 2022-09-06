import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sklepik/const.dart';
import 'package:sklepik/function/createColor.dart';
import 'package:sklepik/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sklepik',
      theme: ThemeData(
        textTheme: GoogleFonts.signikaNegativeTextTheme(
          Theme.of(context).textTheme,
        ).copyWith(
          headline5: const TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
          caption: TextStyle(
            color: primaryColor.withOpacity(0.5),
            fontSize: 25,
          ),
        ),
        primarySwatch: createMaterialColor(
          primaryColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: greyColor,
          hintStyle: TextStyle(
            color: primaryColor.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: primaryColor, width: 5),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
