import 'package:flutter/material.dart';
import 'package:fretapp/widgets/MainView.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/' : (context) => const MainView(),
  },
));