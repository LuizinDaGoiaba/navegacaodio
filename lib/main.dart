import 'package:flutter/material.dart';
import 'package:navegacaocomdio/home_page2.dart';
import 'home_page.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/homePage2': (context) => HomePage2(),
    },
  ));
}