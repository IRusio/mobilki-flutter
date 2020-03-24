import 'package:flutter/material.dart';
import 'package:flutterapp/services.dart';

class SecondPage extends StatefulWidget {

  int radioButtonsToBuild;

  SecondPage({Key key, @required this.radioButtonsToBuild}) : super(key: key);
  @override
  State<StatefulWidget> createState()  => _SecondPage(radioButtonsToBuild);
}

class _SecondPage extends State<SecondPage>
{
  bool buttonActivity;
  List<int> radioValue = new List();
  int radiobuttonsToBuild;
  int dataInRows = 4;

  _SecondPage(int this.radiobuttonsToBuild);


  @override
  void initState()
  {
    super.initState();
    buttonActivity = true;
    for(int i = 0; i < radiobuttonsToBuild; i++)
      radioValue.add(-1);
  }

  void _handleRadioSwitch(int row, int newValue)
  {
    setState(() {
      radioValue[row] = newValue;
    });

    if (isAllFieldsFilled(radioValue))
      setState(() {
        buttonActivity = false;
      });
    else
      setState(() {
        buttonActivity = true;
      });
  }

  Widget _oneRadioWidget(int groupId, int value)
  {
    return new Row(
      children: <Widget>[
        new Radio(
          value: value,
          groupValue: radioValue[groupId],
          onChanged: (int value)
          {
            _handleRadioSwitch(groupId, value);
          },
        ),
        new Text(value.toString())
      ],
    );
  }

  Widget _groupWidget(int groupId, int amount)
  {
    List<Widget> radio = new List();

    for(int i = 0; i < amount; i++)
    {
      radio.add(_oneRadioWidget(groupId, i+2));
    }


    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: radio,
    );
  }

  List<Widget> _columnRadioButtonWidget(int countOfRadiobutton, int amount)
  {
    List<Widget> radio = new List();

    for(int i = countOfRadiobutton -1 ; i != -1 ; i--)
      radio.add(_groupWidget(i, amount));

    return radio;
  }

  Widget _radioButtonGroup(int count)
  {
    return Column(
        children: _columnRadioButtonWidget(count, dataInRows)
    );
  }

  Widget _submitButton(textToShow)
  {
    return new Container(
        child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: buttonActivity? null: ()
                {
                  double sum = 0.0;
                  radioValue.forEach((x) => sum+= x);
                  Navigator.pop(context, sum/radiobuttonsToBuild);
                },
                child: Text(textToShow),
              )
            ],
            buttonMinWidth: 200,
            buttonHeight: 60
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Grades"),
        ),
        body: SingleChildScrollView(
            child:
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _radioButtonGroup(radiobuttonsToBuild),
                  _submitButton("Calculate")
                ],
              ),
            )
        )
    );
  }

}