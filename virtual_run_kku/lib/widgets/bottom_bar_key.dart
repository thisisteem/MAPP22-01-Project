import 'package:flutter/material.dart';

class BottomBarKey {
  BottomBarKey._();

  static final GlobalKey _key = GlobalKey();

  static GlobalKey getKey() => _key;
}
