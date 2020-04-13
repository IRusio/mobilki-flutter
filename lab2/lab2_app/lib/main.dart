import 'package:lab2app/src/app/Views/PhoneAppView.dart';
import 'package:mvc_application/app.dart';

void main() => runApp(MyApp());

class MyApp extends App {
  createView() => PhoneApp();
}