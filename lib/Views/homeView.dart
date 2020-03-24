import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/Views/gradesView.dart';
import 'package:flutterapp/services.dart';
import 'package:flutterapp/validators/NumberValidator.dart';

class MyHomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  String name = '';
  String oldName;
  String surname = '';
  String oldSurname;
  double avg;
  int gradeCount;
  int oldGradeCount;
  bool buttonActivity;
  String textOnButton;


  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final gradeController = TextEditingController();

  @override
  void initState(){
    super.initState();
    buttonActivity = false;
    nameController.addListener(_nameController);
    surnameController.addListener(_surnameController);
    gradeController.addListener(_gradeController);
    textOnButton = "Submit";
  }

  @override
  void dispose(){
    nameController.dispose();
    surnameController.dispose();
    gradeController.dispose();
    super.dispose();
  }

  _gradeController()
  {
    gradeCount = int.tryParse(gradeController.text);
    _isButtonShouldBeActive();
  }

  _nameController()
  {
    name = nameController.text;
    _isButtonShouldBeActive();
  }

  _surnameController()
  {
    surname = surnameController.text;
    _isButtonShouldBeActive();
  }

  _isButtonShouldBeActive()
  {
    if(isAnyStringFieldEmpty([name, surname]) || gradeCount == null || gradeCount < 5)
      setState(() {
        buttonActivity = false;
      });
    else
      setState(() {
        buttonActivity = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("HELLO WORLD"),
        ),
        body:
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                _nameWidget(oldName),
                _surnameWidget(oldSurname),
                _countOfGradesWidget(oldGradeCount),
                avg != null? Text("Your avg is equal: ${avg}") : Container(),
                _submitButton(textOnButton)
              ],
            ),
          ),
        )
    );
  }

  Widget _nameWidget(oName) {
    return new Container(
      child: TextField(
        decoration: InputDecoration(
          labelText: "name",
          helperText: oName,
        ),
        controller: nameController,
      ),
    );
  }

  Widget _surnameWidget(oldSurname)
  {
    return new Container(
      child: TextField(
        decoration: InputDecoration(
            labelText: "surname",
            helperText: oldSurname
        ),
        controller: surnameController,
      ),
    );
  }

  Widget _countOfGradesWidget(oldCount)
  {
    return new Container(
      child: TextFormField(
        decoration: InputDecoration(
            labelText: "grade count",
            helperText: oldCount != null? oldCount.toString() : ''
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
          new NumberValidator(5, 15)
        ],
        controller: gradeController,
      ),
    );
  }

  Widget _submitButton(textToShow)
  {
    return new Container(
        child: ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: buttonActivity? () {
                  moveToSecondView();
                } : null,
                child: Text(textToShow),
              )
            ],
            buttonMinWidth: 200,
            buttonHeight: 60
        )
    );
  }

  void moveToSecondView()
  async {
    final data = await Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(radioButtonsToBuild: gradeCount,)));

    setState(() {
      if(data != null){
        oldName = nameController.text;
        oldSurname = surnameController.text;
        avg = data;
        nameController.text = "";
        surnameController.text = "";
        gradeController.text = null;
        if(avg >= 3)
          textOnButton = "Super :)";
        else
          textOnButton = "Wysyłam podanie o waruneczek";
      }
    });
  }
}