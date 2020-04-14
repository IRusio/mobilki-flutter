import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mvc_application/view.dart';
import 'package:lab2_2/src/controller.dart' as cont;
class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeViewState();
}

enum HomeViewTab {home}

class HomeViewState extends StateMVC<HomeView> {
  HomeViewState() : super(cont.HomeController()) {
    con = this.controller;
  }
  cont.HomeController con;
  @override
  Widget build(BuildContext context) {
    return _app;
  }

  Widget get _app => DefaultTabController(
    length: 1,
    child: Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      key: con.scaffoldKey,
      appBar: con.widget.appBar,
      floatingActionButton: con.widget.floatingButton.addNewPhone,
      persistentFooterButtons: <Widget>[
        con.widget.deletePhonePanel
      ],
      drawer: Drawer(
        child: ListView(
          dragStartBehavior: DragStartBehavior.down,
          children: <Widget>[
            const DrawerHeader(child: Center(child: Text('Phones'))),
            ListTile(
              leading: Icon(Icons.assessment),
              title: con.tittle.HomeView,
              selected: true,
            )
          ],
        ),
      ),
      body: TabBarView(
        dragStartBehavior: DragStartBehavior.down,
        children: <Widget>[
          con.widget.homePhonesTab
        ],
      )
    )
  );

}
