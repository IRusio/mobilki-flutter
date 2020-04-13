import 'package:flutter/material.dart';
import 'package:lab2app/src/app/Models/PhoneRow.dart';
import 'package:lab2app/src/model/ORMconfiguration.dart';

class PhoneList extends StatelessWidget {
  const PhoneList(
  {Key key, this.phones, this.onOpen, this.onAction})
  : super(key: key);

  final List<Phone> phones;
  final PhoneRowActionCallback onOpen;
  final PhoneRowActionCallback onAction;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: const ValueKey<String>('PhoneList'),
      itemExtent: PhoneRow.kHeight,
      itemCount: phones.length,
      itemBuilder: (BuildContext context, int index) {
        return PhoneRow(
          phone: phones[index],
          onPressed: onOpen,
          onLongPressed: onAction,
        );
      },
    );
  }

}