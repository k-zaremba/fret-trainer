import 'package:flutter/material.dart';
import 'package:fretapp/widgets/MainView.dart';
import 'package:fretapp/ignore/Test.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/' : (context) => const MainView(),
    '/t' : (context) => Test()
  },
));