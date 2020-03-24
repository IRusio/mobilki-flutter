bool isAnyStringFieldEmpty([fields])
{
  for(var data in fields)
  {
    if (data.toString().length == 0)
      return true;
  }
  return false;
}

bool isAllFieldsFilled(List<int> data)
{
  for(int obj in data)
  {
    if(obj == -1)
    {
      return false;
    }
  }
  return true;
}
