import 'package:flutter/material.dart' show runApp;

import 'package:lab2_2/src/view.dart' show App, PhoneApp;

void main() => runApp(MyApp());

class MyApp extends App {
  createView() => PhoneApp();
}