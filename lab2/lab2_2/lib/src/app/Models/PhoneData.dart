import 'package:flutter/cupertino.dart';
import 'package:lab2_2/model/ORMconfiguration.dart';

class PhoneObject extends ChangeNotifier {
  PhoneObject(this.phone);

  final Phone phone;

  Phone operator () => phone;
}

class PhoneData extends ChangeNotifier {
  PhoneData(){}
  Phone _phone;
  Future<List<Phone>> get allPhones async => await Phone().select().toList();


  Phone get phone => _phone;

  set phone(Phone value) {
    _phone = value;
  }

  Future<PhoneObject> operator [](int phoneId) async {
    if(phoneId == null)
      return PhoneObject(new Phone());

    var phone = await Phone().getById(phoneId);
    return PhoneObject(phone);
  }

  void add(Phone newPhone) {
    newPhone.save();
    notifyListeners();
  }
}
