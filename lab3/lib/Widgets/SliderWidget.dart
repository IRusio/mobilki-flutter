import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderPanelWidget extends StatefulWidget {
  Color pickedColor;
  double strokeWidth;
  Function changeStatus;
  Orientation orientation;

  SliderPanelWidget({Key key, this.pickedColor, this.strokeWidth, this.changeStatus, this.orientation}) : super(key: key);

  @override
  SliderPanelState createState() => SliderPanelState();

}

class SliderPanelState extends State<SliderPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: new Column(
            children: <Widget>[
              Icon(CupertinoIcons.circle_filled, color: widget.pickedColor,),
              Expanded(
                child: RotatedBox(
                  child: CupertinoSlider(
                      min: 1.0,
                      max: 20.0,
                      activeColor: widget.pickedColor,
                      value: widget.strokeWidth, onChanged: (value){
                    setState(() {
                      widget.strokeWidth = value;
                      widget.changeStatus();
                    });
                  }), quarterTurns: 3,
                ),
              ),
              Icon(CupertinoIcons.circle, color: widget.pickedColor,)
            ],
          ),
          width: 50,
          height: 300,
          decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: Colors.blueGrey,
                  width: 2
              )
          ),
          alignment: Alignment.centerRight,
          margin: widget.orientation == Orientation.portrait? EdgeInsets.fromLTRB(350, 150, 0, 0) : EdgeInsets.fromLTRB(600, 30, 0, 0)
          ,
        ),
      ],
    );
  }

}