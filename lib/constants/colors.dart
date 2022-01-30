import 'package:flutter/material.dart';

class ThemeColors {
  static final Map<int, Color> _colorCodesPrimary = {
    50: Color.fromRGBO(133, 185, 77, .1),
    100: Color.fromRGBO(133, 185, 77, .2),
    200: Color.fromRGBO(133, 185, 77, .3),
    300: Color.fromRGBO(133, 185, 77, .4),
    400: Color.fromRGBO(133, 185, 77, .5),
    500: Color.fromRGBO(133, 185, 77, .6),
    600: Color.fromRGBO(133, 185, 77, .7),
    700: Color.fromRGBO(133, 185, 77, .8),
    800: Color.fromRGBO(133, 185, 77, .9),
    900: Color.fromRGBO(133, 185, 77, 1),
  };

  static final Map<int, Color> _colorCodesJet = {
    50: Color.fromRGBO(41, 41, 41, .1),
    100: Color.fromRGBO(41, 41, 41, .2),
    200: Color.fromRGBO(41, 41, 41, .3),
    300: Color.fromRGBO(41, 41, 41, .4),
    400: Color.fromRGBO(41, 41, 41, .5),
    500: Color.fromRGBO(41, 41, 41, .6),
    600: Color.fromRGBO(41, 41, 41, .7),
    700: Color.fromRGBO(41, 41, 41, .8),
    800: Color.fromRGBO(41, 41, 41, .9),
    900: Color.fromRGBO(41, 41, 41, 1),
  };

  static final Map<int, Color> _colorCodesBackground = {
    50: Color.fromRGBO(241, 245, 248, .1),
    100: Color.fromRGBO(241, 245, 248, .2),
    200: Color.fromRGBO(241, 245, 248, .3),
    300: Color.fromRGBO(241, 245, 248, .4),
    400: Color.fromRGBO(241, 245, 248, .5),
    500: Color.fromRGBO(241, 245, 248, .6),
    600: Color.fromRGBO(241, 245, 248, .7),
    700: Color.fromRGBO(241, 245, 248, .8),
    800: Color.fromRGBO(241, 245, 248, .9),
    900: Color.fromRGBO(241, 245, 248, 1),
  };

  static final Map<int, Color> _colorCodesWarning = {
    50: Color.fromRGBO(255, 190, 11, .1),
    100: Color.fromRGBO(255, 190, 11, .2),
    200: Color.fromRGBO(255, 190, 11, .3),
    300: Color.fromRGBO(255, 190, 11, .4),
    400: Color.fromRGBO(255, 190, 11, .5),
    500: Color.fromRGBO(255, 190, 11, .6),
    600: Color.fromRGBO(255, 190, 11, .7),
    700: Color.fromRGBO(255, 190, 11, .8),
    800: Color.fromRGBO(255, 190, 11, .9),
    900: Color.fromRGBO(255, 190, 11, 1),
  };

  static final Map<int, Color> _colorCodesBlue = {
    50: Color.fromRGBO(37, 95, 133, .1),
    100: Color.fromRGBO(37, 95, 133, .2),
    200: Color.fromRGBO(37, 95, 133, .3),
    300: Color.fromRGBO(37, 95, 133, .4),
    400: Color.fromRGBO(37, 95, 133, .5),
    500: Color.fromRGBO(37, 95, 133, .6),
    600: Color.fromRGBO(37, 95, 133, .7),
    700: Color.fromRGBO(37, 95, 133, .8),
    800: Color.fromRGBO(37, 95, 133, .9),
    900: Color.fromRGBO(37, 95, 133, 1),
  };

  static MaterialColor primary = MaterialColor(0xFF85b94d, _colorCodesPrimary);
  static MaterialColor jet = MaterialColor(0xFF292929, _colorCodesJet);
  static MaterialColor blue = MaterialColor(0xFF255f85, _colorCodesBlue);
  static MaterialColor background =
      MaterialColor(0xFFf1f5f8, _colorCodesBackground);
  static MaterialColor warning = MaterialColor(0xFFFFBE0B, _colorCodesWarning);
}
