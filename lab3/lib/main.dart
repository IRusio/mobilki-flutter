import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Widgets/CanvasWidget.dart';
import 'Widgets/DisposablePanelWidget.dart';

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
  final GlobalKey<DisposablePanelState> _disposablePanelKey = GlobalKey();
  final GlobalKey<CanvasPanelState> _canvasPanelKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    pickedColor = Colors.black;
    strokeWidth = 2.0;
    isPressed = false;
  }


  void changeStatus(){
    isPressed = _canvasPanelKey.currentState.widget.isPressed;
    strokeWidth = _disposablePanelKey.currentState.widget.strokeWidth;
    pickedColor = _disposablePanelKey.currentState.widget.pickedColor;
    _disposablePanelKey.currentState.updateIsPressed(isPressed);
    _canvasPanelKey.currentState.changeStatus(strokeWidth, pickedColor);
  }

  void cleanCanvas(){
    setState(() {
      _canvasPanelKey.currentState.points.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CanvasPanel(
          key: _canvasPanelKey,
          changeStatus: changeStatus,
            isPressed: isPressed,
            pickedColor: Colors.black,
            strokeWidth: strokeWidth,
          ),
          DisposablePanelWidget(
              key: _disposablePanelKey,
              isPressed: this.isPressed,
              strokeWidth: strokeWidth,
              changeStatus: this.changeStatus,
              pickedColor: this.pickedColor,
              cleanCanvas: cleanCanvas,
          )
        ],
      ),
    );
  }
}