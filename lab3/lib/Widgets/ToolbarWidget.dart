import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ToolbarPanelWidget extends StatefulWidget {
  Color pickedColor;
  Function cleanCanvas;
  Function changeStatus;
  Orientation orientation;

  ToolbarPanelWidget(
      {Key key,
        this.pickedColor,
        this.cleanCanvas,
        this.changeStatus,
        this.orientation
      }) : super(key: key);

  @override
  ToolbarPanelState createState() => ToolbarPanelState();
}

class ToolbarPanelState extends State<ToolbarPanelWidget> {
  @override
  Widget build(BuildContext context) {

    void getColor(){
      showDialog(
        context: context,
        child: AlertDialog(
          title: const Text('Color Chooser'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: this.widget.pickedColor,
              onColorChanged: (color) {
                this.setState(() {
                  this.widget.pickedColor = color;
                  this.widget.changeStatus();
                });
              },
            ),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"))
          ],
        ),
      );
    }

    return Container(
      width: 300,
      height: 80,
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(9.0),
          border: Border.all(
              color: Colors.blueGrey,
              width: 2
          )
      ),
      margin: widget.orientation != Orientation.landscape? EdgeInsets.symmetric(vertical: 70.0) : EdgeInsets.symmetric(vertical: 0),
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