import 'package:flutter/cupertino.dart';
import 'package:lab2_2/model/ORMconfiguration.dart';


class PhoneData extends ChangeNotifier {
  PhoneData();

  Future<List<Phone>> get allPhones async => await Phone().select().toList();

  Future<Phone> operator [](int phoneId) async => await Phone().getById(phoneId);

  void add(Phone newPhone) {
    newPhone.save();
    notifyListeners();
  }
}
