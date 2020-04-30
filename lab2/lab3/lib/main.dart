import 'dart:ui';

import 'package:flutter/material.dart';

import 'Widgets/PaintPanel.dart';


void main() {
  runApp(
    MaterialApp(
      title: "Paint App",
      home: MyHomePage(),
      theme: ThemeData(
        primaryColorDark: Colors.black
      ),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paint',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color pickedColor;
  double strokeWidth;
  bool isPressed;
  final GlobalKey<_BrushSizePanelState> _brushPanelKey = GlobalKey();
  final GlobalKey<PaintPanelState> _paintPanelKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    pickedColor = Colors.black;
    strokeWidth = 2.0;
    isPressed = false;
  }


  void changeStatus(){
    isPressed = _paintPanelKey.currentState.widget.isPressed;
    _brushPanelKey.currentState.changeStatus(isPressed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PaintPanel(
          key: _paintPanelKey,
          changeStatus: changeStatus,
            isPressed: isPressed,
            pickedColor: Colors.black,
            strokeWidth: strokeWidth,
          ),
          BrushSizePanelWidget(key: _brushPanelKey, isPressed: this.isPressed)
        ],
      ),
    );
  }
}

class BrushSizePanelWidget extends StatefulWidget {

  bool isPressed;

  BrushSizePanelWidget({Key key, this.isPressed}) : super(key: key);

  _BrushSizePanelState createState() => _BrushSizePanelState();
}

class _BrushSizePanelState extends State<BrushSizePanelWidget>{

  void changeStatus(bool status) => this.setState(() {this.widget.isPressed = status;});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        widget.isPressed? Container():
        Container(
        width: 50,
        height: 300,
        color: Colors.red,
        margin: EdgeInsets.fromLTRB(350, 150, 0, 0),
        )
      ],
    );

  }

}