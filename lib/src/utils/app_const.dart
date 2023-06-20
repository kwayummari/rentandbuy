import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

abstract class AppConst {
  static var primary = HexColor('#c05f27');
  // HexColor('#ffcd10')
  static var secondary = HexColor('#ffffff');
  static var black = HexColor('#000000');
  static var grey = Colors.grey;
  static var brown = HexColor('#452612');
  static var whiteOpacity = Colors.white.withOpacity(0.8);
  static var transparent = Colors.transparent;
}
