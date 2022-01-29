import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color.fromRGBO(37, 95, 133, 1);
  static const Color success = Color.fromRGBO(133, 185, 77, 1);

  static final Map<int, Color> _colorCodesForBlue = {
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

  static final Map<int, Color> _colorCodesForWarning = {
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

  static final Map<int, Color> _colorCodesForSuccess = {
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

  static final Map<int, Color> _colorCodesForRaisinBlack = {
    50: Color.fromRGBO(37, 41, 46, .1),
    100: Color.fromRGBO(37, 41, 46, .2),
    200: Color.fromRGBO(37, 41, 46, .3),
    300: Color.fromRGBO(37, 41, 46, .4),
    400: Color.fromRGBO(37, 41, 46, .5),
    500: Color.fromRGBO(37, 41, 46, .6),
    600: Color.fromRGBO(37, 41, 46, .7),
    700: Color.fromRGBO(37, 41, 46, .8),
    800: Color.fromRGBO(37, 41, 46, .9),
    900: Color.fromRGBO(37, 41, 46, 1),
  };

  static MaterialColor blue = MaterialColor(0xFF255f85, _colorCodesForBlue);

  static MaterialColor yellow =
      MaterialColor(0xFFFFBE0B, _colorCodesForWarning);

  static MaterialColor green = MaterialColor(0xFF85b94d, _colorCodesForSuccess);

  static MaterialColor raisinBlack = MaterialColor(0xFF25292E, _colorCodesForRaisinBlack);


  // v2

  static final Map<int, Color> _colorCodesForGhostWhite = {
    50: Color.fromRGBO(244, 243, 247, .1),
    100: Color.fromRGBO(244, 243, 247, .2),
    200: Color.fromRGBO(244, 243, 247, .3),
    300: Color.fromRGBO(244, 243, 247, .4),
    400: Color.fromRGBO(244, 243, 247, .5),
    500: Color.fromRGBO(244, 243, 247, .6),
    600: Color.fromRGBO(244, 243, 247, .7),
    700: Color.fromRGBO(244, 243, 247, .8),
    800: Color.fromRGBO(244, 243, 247, .9),
    900: Color.fromRGBO(244, 243, 247, 1),
  };
  static MaterialColor ghostWhite = MaterialColor(0xFFF4F3F7, _colorCodesForGhostWhite);

  static final Map<int, Color> _colorCodesForJet = {
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
  static MaterialColor jet = MaterialColor(0xFF292929, _colorCodesForJet);

  static final Map<int, Color> _colorCodesForRussianGreen = {
    50: Color.fromRGBO(103, 141, 88, .1),
    100: Color.fromRGBO(103, 141, 88, .2),
    200: Color.fromRGBO(103, 141, 88, .3),
    300: Color.fromRGBO(103, 141, 88, .4),
    400: Color.fromRGBO(103, 141, 88, .5),
    500: Color.fromRGBO(103, 141, 88, .6),
    600: Color.fromRGBO(103, 141, 88, .7),
    700: Color.fromRGBO(103, 141, 88, .8),
    800: Color.fromRGBO(103, 141, 88, .9),
    900: Color.fromRGBO(103, 141, 88, 1),
  };
  static MaterialColor russianGreen = MaterialColor(0xFF678D58, _colorCodesForRussianGreen);


}
