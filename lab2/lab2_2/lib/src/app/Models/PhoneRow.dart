import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab2_2/model/ORMconfiguration.dart';


typedef PhoneRowActionCallback = void Function(Phone phone, bool isActive, int index);

class PhoneRow extends StatelessWidget {
  PhoneRow({
    this.phone,
    this.onPressed,
    this.onLongPressed,
    this.isPress,
    this.index
}) : super(key: ObjectKey(phone));

  final Phone phone;
  bool isPress;
  final int index;
  final PhoneRowActionCallback onPressed;
  final PhoneRowActionCallback onLongPressed;

  static const double kHeight = 50.0;

  GestureTapCallback _getHandler(PhoneRowActionCallback callback){
    return callback == null ? null : () => callback(phone, isPress, index);
  }


  @override
  Widget build(BuildContext context) {
   return InkWell(
     onTap: _getHandler(onPressed),
     onLongPress: _getHandler(onLongPressed),
     child: Container(
       padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 20.0),
       decoration: BoxDecoration(
         color: isPress?Colors.red:Colors.transparent,
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