import 'package:mvc_application/app.dart';

import 'Views/HomeView.dart';

void main() => runApp(MyApp());

class MyApp extends App {
  createView() => HomeView();
}