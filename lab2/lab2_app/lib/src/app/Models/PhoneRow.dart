import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2app/src/model/ORMconfiguration.dart';


typedef PhoneRowActionCallback = void Function(Phone phone);

class PhoneRow extends StatelessWidget {
  PhoneRow({
    this.phone,
    this.onPressed,
    this.onLongPressed,
}) : super(key: ObjectKey(phone));

  final Phone phone;
  final PhoneRowActionCallback onPressed;
  final PhoneRowActionCallback onLongPressed;

  static const double kHeight = 50.0;

  GestureTapCallback _getHandler(PhoneRowActionCallback callback){
    return callback == null ? null : () => callback(phone);
  }


  @override
  Widget build(BuildContext context) {
   return InkWell(
     onTap: _getHandler(onPressed),
     onLongPress: _getHandler(onLongPressed),
     child: Container(
       padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 20.0),
       decoration: BoxDecoration(
         border: Border(
           bottom: BorderSide(color: Theme.of(context).dividerColor)
         )
       ),
         child: Row(
           children: <Widget>[
             Container(
               margin: const EdgeInsets.only(right: 5.0),
             ),
             Expanded(
               child: Row(
                 children: <Widget>[
                   Expanded(
                     flex: 2,
                     child: Text(phone.producer)
                   ),
                   Expanded(
                     child: Text(
                         phone.phoneModel,
                         textAlign: TextAlign.right
                     ),
                   ),
                 ]
               )
             )
           ],
         )
     ),

   );
  }


}