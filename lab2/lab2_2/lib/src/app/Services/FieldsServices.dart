bool isAnyStringFieldEmpty([fields])
{
  for(var data in fields)
  {
    if (data.toString().length == 0)
      return true;
  }
  return false;
}

bool isWwwPageLink(phoneWebPage)
{
  String reg = r"^(https?|chrome):\/\/[^\s$.?#].[^\s]*$";
  var regex = RegExp(reg);

  var result =  regex.hasMatch(phoneWebPage);
  return result;
}