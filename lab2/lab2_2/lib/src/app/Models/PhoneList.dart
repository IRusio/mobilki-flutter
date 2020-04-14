import 'package:flutter/material.dart';
import 'package:lab2_2/model/ORMconfiguration.dart';
import 'package:lab2_2/src/app/Models/PhoneRow.dart';

class PhoneList extends StatelessWidget {
  PhoneList(
  {Key key, this.phones, this.onOpen, this.onAction, this.isPress})
  : super(key: key);

  final List<Phone> phones;
  List<bool> isPress;
  final PhoneRowActionCallback onOpen;
  final PhoneRowActionCallback onAction;

  @override
  Widget build(BuildContext context) {
    var data = ListView.builder(
      key: const ValueKey<String>('PhoneList'),
      itemExtent: PhoneRow.kHeight,
      itemCount: phones.length,
      itemBuilder: (BuildContext context, int index) {
        return PhoneRow(
          phone: phones[index],
          isPress: isPress[index],
          onPressed: onOpen,
          onLongPressed: onAction,
          index: index,
        );
      },
    );

    return data;
  }
}