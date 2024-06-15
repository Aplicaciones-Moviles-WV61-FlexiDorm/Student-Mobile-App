import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<Color> colorList = <Color>[
  const Color.fromARGB(255, 160, 95, 239),
  const Color.fromARGB(255, 33, 65, 243),
  const Color.fromARGB(255, 180, 58, 50),
  const Color.fromARGB(255, 216, 42, 246),
  const Color.fromARGB(255, 246, 84, 138),
  const Color.fromARGB(255, 175, 110, 11),
  Colors.black,
];

class AppTheme{
  final int selectedColor;

  AppTheme({
    this.selectedColor = 0
  })
  : assert(
      selectedColor >= 0,
      "Color index must be >= 0"
    ),
    assert(
      selectedColor < colorList.length,
      "Color index must be < ${colorList.length}"
    );

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorList[selectedColor],
    appBarTheme: const AppBarTheme(
      centerTitle: true
    ),
    textTheme: GoogleFonts.ptSansTextTheme(),
  );

}