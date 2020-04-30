import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lab3/Models/DrawingArea.dart';

class PaintPanel extends StatefulWidget {
  Color pickedColor;
  double strokeWidth;
  bool isPressed;

  final Function changeStatus;

  PaintPanel({Key key, this.changeStatus, this.pickedColor, this.strokeWidth, this.isPressed}): super (key: key);

  @override
  State<StatefulWidget> createState() => PaintPanelState();

}

class PaintPanelState extends State<PaintPanel> {

  List<DrawingArea> points = [];
  Offset lastPosition;
  final int startAndEndButtonSize = 3;



  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;


    return Center(
      child: Container(
        width: width,
        height: height,
        child:  GestureDetector(
            onPanDown: (details) {
              this.setState(() {
                this.widget.changeStatus();
                points.add(DrawingArea(
                    details.localPosition,
                    Paint()
                      ..strokeCap = StrokeCap.round
                      ..isAntiAlias = true
                      ..color = widget.pickedColor
                      ..strokeWidth = widget.strokeWidth*startAndEndButtonSize
                ));
              });
            },

            onPanUpdate: (details) {
              this.setState(() {
                points.add(DrawingArea(
                    details.localPosition,
                    Paint()
                      ..strokeCap = StrokeCap.round
                      ..isAntiAlias = true
                      ..color = widget.pickedColor
                      ..strokeWidth = widget.strokeWidth
                ));
                lastPosition = details.localPosition;
                widget.isPressed = true;
                this.widget.changeStatus();
              });
            },

            onPanEnd: (details) {
              this.setState(() {
                if(widget.isPressed){
                  points.add(DrawingArea(
                      lastPosition,
                      Paint()
                        ..strokeCap = StrokeCap.round
                        ..isAntiAlias = true
                        ..color = widget.pickedColor
                        ..strokeWidth = widget.strokeWidth*startAndEndButtonSize
                  ));
                  points.add(null);
                  widget.isPressed = false;
                  this.widget.changeStatus();
                }
                else
                  points.add(null);
              });
            },


            child: SizedBox.expand(
              child: CustomPaint(
                painter: Painter(points: points),
              ),
            )

        ),
      ),

    );
  }

}

class Painter extends CustomPainter {

  List<DrawingArea> points;

  Painter({@required this.points});



  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);
    canvas.clipRect(rect);

    for(int i = 0 ; i < points.length - 1 ; i++){
      if(points[i] != null && points[i+1] != null)
        canvas.drawLine(points[i].point, points[i + 1].point, points[i].areaPaint);
      else if(points[i] != null && points[i+1] == null)
        canvas.drawPoints(PointMode.points, [points[i].point], points[i].areaPaint);
    }

  }

  @override
  bool shouldRepaint(Painter oldDelegate) {
    return oldDelegate.points == points;
  }
}