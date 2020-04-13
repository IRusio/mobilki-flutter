import 'package:flutter/cupertino.dart';
import 'package:lab2app/src/model/ORMconfiguration.dart';


class PhoneData extends ChangeNotifier {
  PhoneData() {
    _phones = Phone().select().toList() as List<Phone>;
  }

  List<Phone> _phones = <Phone>[];

  Iterable<Phone> get allPhones => _phones;

  Future<Phone> operator [](int phoneId) async => await Phone().getById(phoneId);

  void add(Phone newPhone) {
    newPhone.save();
    notifyListeners();
  }

  void _end() {
    _phones = null;
  }

}