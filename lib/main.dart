import 'package:flutter/material.dart';
import 'package:fretapp/panels/app.dart';
import 'package:fretapp/widgets/Home.dart';
import 'package:fretapp/widgets/Test.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/home': (context) => Home(),
    '/app': (context) => App(),
    '/test': (context) => Test()
  },
));