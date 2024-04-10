//import 'package:disenos_app/src/pages/animaciones_page.dart';
//import 'package:disenos_app/src/labs/circular_progress_page.dart';
//import 'package:disenos_app/src/retos/cuadrado_animado_page.dart';
//import 'package:disenos_app/src/pages/headers_page.dart';
//import 'package:disenos_app/src/pages/graficas_circulares_page.dart';
//import 'package:disenos_app/src/labs/slideshow_page.dart';
//import 'package:disenos_app/src/pages/slideshow_page.dart';
import 'package:disenos_app/src/pages/pinterest_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños App',
      home: PinterestPage(),
    );
  }
}
