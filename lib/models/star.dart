import 'package:flutter/material.dart';

class Star {
  final Offset pos;
  final double size;
  final String title;
  final String subtitle;
  final bool special;

  Star(this.pos, this.size, this.title, this.subtitle, {this.special = false});
}