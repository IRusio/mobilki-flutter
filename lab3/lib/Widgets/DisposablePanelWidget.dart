import 'package:flutter/material.dart';

import 'SliderWidget.dart';
import 'ToolbarWidget.dart';

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
  DisposablePanelState createState() => DisposablePanelState();
}

class DisposablePanelState extends State<DisposablePanelWidget>{

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