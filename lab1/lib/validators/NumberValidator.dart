import 'package:flutter/services.dart';

class NumberValidator extends TextInputFormatter
{
  final int minValue, maxValue;

  NumberValidator(this.minValue, this.maxValue);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if(newValue.text == '')
      return newValue;

    if(minValue != null && maxValue != null && newValue.text != null)
    {
      int number = int.tryParse(newValue.text);
      if(number <= maxValue)
        return newValue;
      else return oldValue;
    }
    return oldValue;
  }

}
