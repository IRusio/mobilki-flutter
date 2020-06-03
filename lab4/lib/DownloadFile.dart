import 'dart:isolate';
import 'ItemHolder.dart';
import 'TaskInfo.dart';

class DownloadFileService{
  List<TaskInfo> _tasks;
  List<ItemHolder> _items;
  ReceivePort _port = new ReceivePort();
  DownloadFileService(){
  }


}