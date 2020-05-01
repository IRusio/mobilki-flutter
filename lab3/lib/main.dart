import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Widgets/CanvasWidget.dart';
import 'Widgets/SliderWidget.dart';


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
  final GlobalKey<_DisposablePanelState> _disposablePanelKey = GlobalKey();
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

class DisposablePanelWidget extends StatefulWidget {

  bool isPressed;
  double strokeWidth;
  Function changeStatus;
  Function cleanCanvas;
  Color pickedColor;
  DisposablePanelWidget(
      {Key key,
        this.isPressed,
        this.strokeWidth,
        this.changeStatus,
        this.pickedColor,
        this.cleanCanvas}) : super(key: key);
  _DisposablePanelState createState() => _DisposablePanelState();
}

class _DisposablePanelState extends State<DisposablePanelWidget>{

  final GlobalKey<SliderPanelState> _sliderPanelKey = GlobalKey();
  final GlobalKey<ToolbarPanelState> _toolbarPanelKey = GlobalKey();

  void updateIsPressed(bool status) => this.setState(() {
    this.widget.isPressed = status;
  });

  void changeStatus(){
    this.widget.strokeWidth = this._sliderPanelKey.currentState.widget.strokeWidth;
    this.widget.pickedColor = this._toolbarPanelKey.currentState.widget.pickedColor;
    this.widget.changeStatus();
  }



  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return widget.isPressed? Container(): Container(
      height: height,
      width:  width,
      child: Column(
        children: <Widget>[
          SliderPanelWidget(
           key: _sliderPanelKey,
           pickedColor: widget.pickedColor,
           strokeWidth: widget.strokeWidth,
           changeStatus: changeStatus,
          ),
          ToolbarPanelWidget(
           key: _toolbarPanelKey,
            changeStatus: changeStatus,
            cleanCanvas: widget.cleanCanvas,
            pickedColor: widget.pickedColor,
          )
        ],
      )
    );
  }
}

class ToolbarPanelWidget extends StatefulWidget {
  Color pickedColor;
  Function cleanCanvas;
  Function changeStatus;

  ToolbarPanelWidget(
      {Key key,
        this.pickedColor,
        this.cleanCanvas,
        this.changeStatus
      }) : super(key: key);

  @override
  ToolbarPanelState createState() => ToolbarPanelState();
}

class ToolbarPanelState extends State<ToolbarPanelWidget> {
  @override
  Widget build(BuildContext context) {

    void getColor(){

    }

    return Container(
      width: 300,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
              color: Colors.blueGrey,
              width: 2
          )
      ),
      margin: EdgeInsets.symmetric(vertical: 70.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child:IconButton(
                  icon: Icon(Icons.color_lens),
                  onPressed: getColor,
                  color: widget.pickedColor
              )
          ),
          Expanded(
            child: IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: widget.cleanCanvas,
              color: widget.pickedColor,
            )
          )
        ],
      ),
    );
  }
}