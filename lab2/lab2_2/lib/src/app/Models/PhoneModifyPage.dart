// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab2_2/model/ORMconfiguration.dart';
import 'package:lab2_2/src/app/Controllers/PhoneAppController.dart';
import 'package:lab2_2/src/app/Services/FieldsServices.dart';
import 'package:lab2_2/src/app/Services/Validators/isDecimalValidator.dart';
import 'package:lab2_2/src/controller.dart';
import 'package:url_launcher/url_launcher.dart';

import 'PhoneData.dart';

class PhoneModifyPage extends StatefulWidget {
  PhoneModifyPage(this.id, this.phoneData);

  final int id;
  final PhoneData phoneData;

  @override
  State<StatefulWidget> createState() => _PhoneModifyPage(id, phoneData);
}

class _PhoneModifyPage extends State<PhoneModifyPage> {
  _PhoneModifyPage(this.id, this.phoneData);

  final int id;
  final PhoneData phoneData;
  PhoneObject phoneObject;

  final producerController = TextEditingController();
  final modelController = TextEditingController();
  final androidVersionController = TextEditingController();
  final wwwPageController = TextEditingController();

  bool buttonOpenPageActivity;
  bool buttonSaveActivity;
  String tittleContent;


  @override
  void initState() {
    producerController.addListener(_producerController);
    modelController.addListener(_modelController);
    androidVersionController.addListener(_androidVersionController);
    wwwPageController.addListener(_wwwPageController);
    buttonSaveActivity = false;
    buttonOpenPageActivity = false;
    super.initState();
  }

  @override
  void dispose() {
    producerController.dispose();
    modelController.dispose();
    androidVersionController.dispose();
    super.dispose();
  }

  _producerController(){phoneObject.phone.producer = producerController.text;
    _isButtonShouldBeActive();
  }

  _modelController(){
    phoneObject.phone.phoneModel = modelController.text;
    _isButtonShouldBeActive();
  }

  _androidVersionController(){
    phoneObject.phone.androidVersion = double.tryParse(androidVersionController.text);
  }

  _wwwPageController(){
    phoneObject.phone.phoneWebPage = wwwPageController.text;
    _isButtonShouldBeActive();
  }

  _isButtonShouldBeActive() {
    Phone phone = phoneObject.phone;

    var res1 = !isWwwPageLink(phoneObject.phone.phoneWebPage);
    var res2 = isAnyStringFieldEmpty([phone.producer, phone.phoneModel, phone.androidVersion, phone.phoneWebPage]);

    if(res1)
      setState(() {
        buttonOpenPageActivity = false;
      });
    else
      setState(() {
        buttonOpenPageActivity = true;
      });


    if(res1 || res2)
      setState(() {
        buttonSaveActivity = false;
      });
    else
      setState(() {
        buttonSaveActivity = true;
      });
  }

  Future<PhoneObject> getPhone(int _id)
  async {
    PhoneObject phone;
    if(_id == null) {
      phone = new PhoneObject(new Phone());
    }
    else{
      phone = await phoneData[_id];
    }

    this.phoneObject = phone;

    producerController.text = phoneObject.phone.producer;
    modelController.text = phoneObject.phone.phoneModel;
    androidVersionController.text = phoneObject.phone.androidVersion != null? phoneObject.phone.androidVersion.toString() : 0;
    wwwPageController.text = phoneObject.phone.phoneWebPage;


    return phone;
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: this.phoneObject == null? getPhone(id): null,
        builder: (BuildContext context,
            AsyncSnapshot<PhoneObject> phoneObject) {
        return Scaffold(
          appBar: AppBar(
            title: Text(phoneObject.data != null?'${phoneObject.data.phone.producer} ${phoneObject.data.phone.phoneModel}': 'new Phone')
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _producerWidget(),
                  _modelWidget(),
                  _androidVersionWidget(),
                  _wwwPageWidget(),
                  new Row(
                    children: <Widget>[
                      _wwwPageButton(),
                      _saveButton()
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _producerWidget() {
    return new Container(
      child: TextField(
        decoration: InputDecoration(
          labelText: "producer name",
        ),
        keyboardType: TextInputType.text,
        controller: producerController,
      ),
    );
  }

  Widget _modelWidget() {
    return new Container(
      child: TextField(
        decoration: InputDecoration(
            labelText: "model name"
        ),
        keyboardType: TextInputType.text,
        controller: modelController,
      ),
    );
  }

  Widget _androidVersionWidget() {
    return new Container(
      child: TextField(
        decoration: InputDecoration(
            labelText: "android version"
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
        controller: androidVersionController,
        inputFormatters: <TextInputFormatter>[
          DecimalTextInputFormatter(decimalRange: 1)
        ],
      ),
    );
  }

  Widget _wwwPageWidget() {
    return new Container(
      child: TextField(
        decoration: InputDecoration(
          labelText: "www link"
        ),
        keyboardType: TextInputType.url,
        controller: wwwPageController,
      ),
    );
  }

  Widget _wwwPageButton() {
    return new Container(
      child: ButtonBar(
        alignment: MainAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            onPressed: buttonOpenPageActivity? () {_openWebPage(phoneObject.phone.phoneWebPage);}:null,
            child: Text("go to www page"),
          ),
        ],
      ),
    );
  }

  _openWebPage(String url) async
  {
    if(await canLaunch(url))
      await launch(url);
  }

  Widget _saveButton() {
    return new Container(
      child: ButtonBar(
        alignment: MainAxisAlignment.end,
        children: <Widget>[
          RaisedButton(
            onPressed: buttonSaveActivity? () {
              phoneObject.phone.save();
            } : null,
            child: Text("save"),
          )
        ],
      )
    );
  }
}


