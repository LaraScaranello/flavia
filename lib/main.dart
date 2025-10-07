import 'package:flavia/screens/star_sky_page.dart';
import 'package:flavia/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nosso Céu',
      theme: AppTheme.dark,
      home: StarSkyPage()
    );
  }
}