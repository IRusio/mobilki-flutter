// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// SqfEntityFormGenerator
// **************************************************************************

part of 'ORMconfiguration.dart';

class PhoneAdd extends StatefulWidget {
  PhoneAdd(this._phones);
  final dynamic _phones;
  @override
  State<StatefulWidget> createState() => PhoneAddState(_phones as Phone);
}

class PhoneAddState extends State {
  PhoneAddState(this.phones);
  Phone phones;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController txtProducer = TextEditingController();
  final TextEditingController txtPhoneModel = TextEditingController();
  final TextEditingController txtAndroidVersion = TextEditingController();
  final TextEditingController txtPhoneWebPage = TextEditingController();

  @override
  void initState() {
    txtProducer.text = phones.producer == null ? '' : phones.producer;
    txtPhoneModel.text = phones.phoneModel == null ? '' : phones.phoneModel;
    txtAndroidVersion.text =
        phones.androidVersion == null ? '' : phones.androidVersion.toString();
    txtPhoneWebPage.text =
        phones.phoneWebPage == null ? '' : phones.phoneWebPage;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (phones.id == null)
            ? Text('Add a new phones')
            : Text('Edit phones'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    buildRowProducer(),
                    buildRowPhoneModel(),
                    buildRowAndroidVersion(),
                    buildRowPhoneWebPage(),
                    FlatButton(
                      child: saveButton(),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          save();
                          /* Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                              content: Text('Processing Data')));
                           */
                        }
                      },
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget buildRowProducer() {
    return TextFormField(
      controller: txtProducer,
      decoration: InputDecoration(labelText: 'Producer'),
    );
  }

  Widget buildRowPhoneModel() {
    return TextFormField(
      controller: txtPhoneModel,
      decoration: InputDecoration(labelText: 'PhoneModel'),
    );
  }

  Widget buildRowAndroidVersion() {
    return TextFormField(
      validator: (value) {
        if (value.isNotEmpty && double.tryParse(value) == null) {
          return 'Please Enter valid number';
        }

        return null;
      },
      controller: txtAndroidVersion,
      decoration: InputDecoration(labelText: 'AndroidVersion'),
    );
  }

  Widget buildRowPhoneWebPage() {
    return TextFormField(
      controller: txtPhoneWebPage,
      decoration: InputDecoration(labelText: 'PhoneWebPage'),
    );
  }

  Container saveButton() {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(95, 66, 119, 1.0),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0)),
      child: Text(
        'Save',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  void save() async {
    phones
      ..producer = txtProducer.text
      ..phoneModel = txtPhoneModel.text
      ..androidVersion = double.tryParse(txtAndroidVersion.text)
      ..phoneWebPage = txtPhoneWebPage.text;
    final result = await phones.save();
    if (result != 0) {
      Navigator.pop(context, true);
    } else {
      UITools(context).alertDialog(phones.saveResult.toString(),
          title: 'save Phone Failed!', callBack: () {
        Navigator.pop(context, true);
      });
    }
  }
}
