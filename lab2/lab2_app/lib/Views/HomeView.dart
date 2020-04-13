import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mvc_application/view.dart';
import 'package:lab2app/Controllers/HomeController.dart' as con;

class HomeView extends AppView {
  HomeView() : super(
    con: con.HomeController(), // con is a controllers in the view
    title: 'Phones',
    theme: con.HomeController.theme,
    localizationsDelegates: <LocalizationsDelegate<dynamic>>
    [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ],
    //i think that this is a some delegates to another views?
    //im not sure, and i think that i could read about that
    //a little later to understood that better, TODO: read about that
    //i found info that is more like local settings TODO: remove that in final version
    supportedLocales: const <Locale> [
      Locale('en', 'US'),
      Locale('es', 'ES'),
    ],
  );

  onRoutes() => <String, WidgetBuilder> { //thats a static routes i think?
    '/': (BuildContext context) => Home(),
//    "/add": (BuildContext context) => AddPhone(),
//    "/edit": (BuildContext context) => EditPhone(),
  };

  onOnGenerateRoute() => (RouteSettings settings) {
    if (settings.name == '/test') { //i think this will add new content without reloading page, or sth?
      final String symbol = settings.arguments;
      return MaterialPageRoute<void>(
        settings: settings,
        //builder: (BuildContext context) => con.HomeController.symbolPage(symbol: symbol), TODO: undestood what is going on there
      );
    }
    return null;
  }
}