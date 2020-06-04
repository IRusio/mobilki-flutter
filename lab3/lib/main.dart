import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Widgets/CanvasWidget.dart';
import 'Widgets/DisposablePanelWidget.dart';

import 'package:flutter/services.dart';

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
  bool isPaintScreenPressed;
  final GlobalKey<DisposablePanelState> _disposablePanelKey = GlobalKey();
  final GlobalKey<CanvasPanelState> _canvasPanelKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    pickedColor = Colors.black;
    strokeWidth = 2.0;
    isPaintScreenPressed = false;
  }


  void changeStatus(){
    isPaintScreenPressed = _canvasPanelKey.currentState.widget.isPressed;
    strokeWidth = _disposablePanelKey.currentState.widget.strokeWidth;
    pickedColor = _disposablePanelKey.currentState.widget.pickedColor;
    _disposablePanelKey.currentState.updateIsPressed(isPaintScreenPressed);
    _canvasPanelKey.currentState.changeStatus(strokeWidth, pickedColor);
  }

  void cleanCanvas(){
    setState(() {
      _canvasPanelKey.currentState.points.clear();
    });
  }

  Widget _child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CanvasPanel(
          key: _canvasPanelKey,
          changeStatus: changeStatus,
            isPressed: isPaintScreenPressed,
            pickedColor: Colors.black,
            strokeWidth: strokeWidth,
          ),
          OrientationBuilder(
            builder: (_, orientation){
                _child = DisposablePanelWidget(
                  key: _disposablePanelKey,
                  isPaintScreenPressed: this.isPaintScreenPressed,
                  strokeWidth: strokeWidth,
                  changeStatus: this.changeStatus,
                  pickedColor: this.pickedColor,
                  cleanCanvas: cleanCanvas,
                  orientation: orientation
                );

              return AnimatedSwitcher(
                duration: Duration(seconds: 2),
                child: _child,
              );
            },
          )
        ],
      ),
    );
  }
}