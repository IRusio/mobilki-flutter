import 'package:flutter/material.dart';
import 'package:lab2_2/src/Home/Views/HomeView.dart';
import 'package:mvc_application/view.dart';
import 'package:lab2_2/src/controller.dart' as con;

class PhoneApp extends AppView {
  PhoneApp() : super(
    con: con.PhoneAppController(), // con is a controllers in the view
    title: 'Phones',
    theme: con.PhoneAppController.theme,
    localizationsDelegates: <LocalizationsDelegate<dynamic>>
    [
    ],
    //i think that this is a some delegates to another views?
    //im not sure, and i think that i could read about that
    //a little later to understood that better, TODO: read about that
    //i found info that is more like local settings TODO: remove that in final version
    supportedLocales: const <Locale> [
      Locale('en', 'US'),
    ],
  );

  onRoutes() => <String, WidgetBuilder> { //thats a static routes i think?
    '/': (BuildContext context) => HomeView(),
  };

  onOnGenerateRoute() => (RouteSettings settings) {
    switch (settings.name)
    {
      case "/add":
        {
          return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) =>
              con.PhoneAppController.phoneModifyPage(settings.arguments), //TODO: undestood what is going on there
        );
        }
        break;
      case "/edit":
        {
          return MaterialPageRoute<void>(
            settings: settings,
            builder: (BuildContext context) =>
                con.PhoneAppController.phoneModifyPage(settings.arguments)
          );
        }
        break;
      default:
        return null;
    }
  };
}