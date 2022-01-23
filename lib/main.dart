import 'package:flutter/material.dart';
import 'package:fretapp/panels/app.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/app',
  routes: {
    '/app': (context) => App(),
  },
));